import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart' as p;
import 'package:graphql_parser/graphql_parser.dart';
import 'package:artemis/schema/options.dart';
import 'package:artemis/schema/graphql.dart';
import 'package:recase/recase.dart';

GraphQLType _getTypeByName(GraphQLSchema schema, String name) =>
    schema.types.firstWhere((t) => t.name == name);

GraphQLType _followType(GraphQLType type) {
  switch (type.kind) {
    case GraphQLTypeKind.LIST:
    case GraphQLTypeKind.NON_NULL:
      return _followType(type.ofType);
    default:
      return type;
  }
}

String _buildType(GraphQLType type, GeneratorOptions options, String prefix,
    {bool dartType = true, String replaceLeafWith}) {
  switch (type.kind) {
    case GraphQLTypeKind.LIST:
      return 'List<${_buildType(type.ofType, options, prefix, dartType: dartType, replaceLeafWith: replaceLeafWith)}>';
    case GraphQLTypeKind.NON_NULL:
      return _buildType(type.ofType, options, prefix,
          dartType: dartType, replaceLeafWith: replaceLeafWith);
    case GraphQLTypeKind.SCALAR:
      final scalar = _getSingleScalarMap(options, type);
      return dartType ? scalar.dartType : scalar.graphQLType;
    default:
      if (replaceLeafWith != null) return '$prefix$replaceLeafWith';
      return '$prefix${type.name}';
  }
}

List<ScalarMap> _defaultScalarMapping = [
  ScalarMap(graphQLType: 'Boolean', dartType: 'bool'),
  ScalarMap(graphQLType: 'Float', dartType: 'double'),
  ScalarMap(graphQLType: 'ID', dartType: 'String'),
  ScalarMap(graphQLType: 'Int', dartType: 'int'),
  ScalarMap(graphQLType: 'String', dartType: 'String'),
];

ScalarMap _getSingleScalarMap(GeneratorOptions options, GraphQLType type) =>
    options.scalarMapping.followedBy(_defaultScalarMapping).firstWhere(
        (m) => m.graphQLType == type.name,
        orElse: () => ScalarMap(graphQLType: type.name, dartType: type.name));

GraphQLSchema schemaFromJsonString(String jsonS) =>
    GraphQLSchema.fromJson(json.decode(jsonS));

Future<String> generate(
    GraphQLSchema schema, String path, GeneratorOptions options) async {
  return '';
}

OperationDefinitionContext getOperationFromQuery(String queryStr) {
  final tokens = scan(queryStr);
  final parser = Parser(tokens);

  if (parser.errors.isNotEmpty) {
    print(parser.errors);
  }

  final doc = parser.parseDocument();

  return doc.definitions.first;
}

List<FragmentDefinitionContext> getFragmentsFromQuery(String queryStr) {
  final tokens = scan(queryStr);
  final parser = Parser(tokens);

  if (parser.errors.isNotEmpty) {
    print(parser.errors);
  }

  final doc = parser.parseDocument();

  return doc.definitions.whereType<FragmentDefinitionContext>().toList();
}

Future<String> generateQuery(GraphQLSchema schema, String path, String queryStr,
    GeneratorOptions options, SchemaMap schemaMap) async {
  final operation = getOperationFromQuery(queryStr);
  final fragments = getFragmentsFromQuery(queryStr);

  final basename = p.basenameWithoutExtension(path);
  final customParserImport = options.customParserImport != null
      ? '  import \'${options.customParserImport}\';'
      : '';
  final parentType = _getTypeByName(schema, schema.queryType.name);
  final className = ReCase(operation.name ?? basename).pascalCase;

  final StringBuffer buffer = StringBuffer()
    ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND\n');
  if (options.generateHelpers) {
    buffer.writeln('''import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;''');
  }

  buffer.writeln('''import 'package:json_annotation/json_annotation.dart';
$customParserImport''');

  buffer.writeln('part \'$basename.query.g.dart\';');

  final List<QueryInput> inputs = [];
  if (operation.variableDefinitions != null) {
    inputs.addAll(operation.variableDefinitions.variableDefinitions.map((v) {
      final type = _getTypeByName(schema, v.type.typeName.name);
      final dartTypeStr =
          _buildType(type, options, options.prefix, dartType: true);
      return QueryInput(dartTypeStr, v.variable.name);
    }));
  }

  final classes = _generateQueryClass(buffer, operation.selectionSet, fragments,
      schema, className, parentType, options, schemaMap);
  classes.forEach((c) => _printCustomClass(buffer, c));

  if (options.generateHelpers) {
    final sanitizedQueryStr = queryStr
        .replaceAll(RegExp(r'\s+'), ' ')
        .replaceAll(RegExp(r'\$'), '\\\$')
        .trim();

    String buildArguments = '';
    if (inputs.isNotEmpty) {
      buildArguments = inputs.map((i) => '${i.type} ${i.name}').join(',') + ',';
    }

    buffer.writeln('''
Future<$className> execute${className}Query(String graphQLEndpoint, $buildArguments {http.Client client}) async {
  final httpClient = client ?? http.Client();
  final dataResponse = await httpClient.post(graphQLEndpoint, body: json.encode({
    'operationName': '${ReCase(className).snakeCase}',
    'query': '$sanitizedQueryStr',''');

    if (inputs.isNotEmpty) {
      final variableMap =
          inputs.map((i) => '\'${i.name}\': ${i.name}').join(', ');
      buffer.writeln('\'variables\': {$variableMap},');
    }

    buffer.writeln('''}),  
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
  );
  httpClient.close();

  return $className.fromJson(json.decode(dataResponse.body)['data']);
}
''');
  }

  return buffer.toString();
}

typedef void ClassLikeCall(
    SelectionSetContext selectionSet,
    GraphQLSchema schema,
    String className,
    GraphQLType parentType,
    GeneratorOptions options);

ClassProperty selectionToClassProperty(SelectionContext selection,
    GraphQLSchema schema, GraphQLType type, GeneratorOptions options,
    {ClassLikeCall customCall}) {
  String annotation;
  String fieldName = selection.field.fieldName.name;
  String alias = fieldName;
  String aliasClassName;
  final bool hasAlias = selection.field.fieldName.alias != null;
  if (hasAlias) {
    alias = selection.field.fieldName.alias.alias;
    aliasClassName = ReCase(selection.field.fieldName.alias.alias).pascalCase;
    fieldName = selection.field.fieldName.alias.name;
  }

  final graphQLField = type.fields.firstWhere((f) => f.name == fieldName);
  final dartTypeStr = _buildType(graphQLField.type, options, options.prefix,
      dartType: true, replaceLeafWith: aliasClassName);

  final leafType = _getTypeByName(schema, _followType(graphQLField.type).name);
  if (leafType.kind != GraphQLTypeKind.SCALAR && customCall != null) {
    customCall(selection.field.selectionSet, schema,
        aliasClassName ?? leafType.name, leafType, options);
  }

  final scalar = _getSingleScalarMap(options, leafType);
  if (leafType.kind == GraphQLTypeKind.SCALAR && scalar.useCustomParser) {
    final graphqlTypeSafeStr =
        _buildType(graphQLField.type, options, options.prefix, dartType: false)
            .replaceAll(RegExp(r'[<>]'), '');
    final dartTypeSafeStr = dartTypeStr.replaceAll(RegExp(r'[<>]'), '');
    annotation =
        '@JsonKey(fromJson: fromGraphQL${graphqlTypeSafeStr}ToDart$dartTypeSafeStr, toJson: fromDart${dartTypeSafeStr}ToGraphQL$graphqlTypeSafeStr)';
  }

  return ClassProperty(dartTypeStr, alias, annotation: annotation);
}

List<ClassDefinition> _generateQueryClass(
    StringBuffer buffer,
    SelectionSetContext selectionSet,
    List<FragmentDefinitionContext> fragments,
    GraphQLSchema schema,
    String className,
    GraphQLType currentType,
    GeneratorOptions options,
    SchemaMap schemaMap,
    {SelectionSetContext parentSelectionSet}) {
  if (currentType.kind == GraphQLTypeKind.INPUT_OBJECT) {
    // TODO: this
    return [];
  }
  if (currentType.kind == GraphQLTypeKind.ENUM) {
    _printCustomEnum(
        buffer, currentType.name, currentType.enumValues.map((eV) => eV.name));
    return [];
  }
  if (selectionSet != null) {
    final classProperties = <ClassProperty>[];
    final factoryPossibilities = Set<String>();
    final queue = <ClassDefinition>[];
    String mixins = '';

    // Look at field selections and add it as class properties
    selectionSet.selections.where((s) => s.field != null).forEach((selection) {
      final cp =
          selectionToClassProperty(selection, schema, currentType, options,
              customCall: (selectionSet, _, className, type, _2) {
        queue.addAll(_generateQueryClass(buffer, selection.field.selectionSet,
            fragments, schema, className, type, options, schemaMap,
            parentSelectionSet: selectionSet));
      });

      classProperties.add(cp);
    });

    // Look at fragment spreads and spread them
    selectionSet.selections
        .where((s) => s.fragmentSpread != null)
        .forEach((selection) {
      final fragment =
          fragments.firstWhere((f) => f.name == selection.fragmentSpread.name);

      fragment.selectionSet.selections
          .where((s) => s.field != null)
          .forEach((selection) {
        final cp =
            selectionToClassProperty(selection, schema, currentType, options,
                customCall: (selectionSet, _, className, type, _2) {
          queue.addAll(_generateQueryClass(buffer, fragment.selectionSet,
              fragments, schema, className, type, options, schemaMap,
              parentSelectionSet: selectionSet));
        });

        classProperties.add(cp);
      });
    });

    // Look at inline fragment spreads to consider factory overrides
    selectionSet.selections
        .where((s) => s.inlineFragment != null)
        .forEach((selection) {
      final spreadClassName =
          selection.inlineFragment.typeCondition.typeName.name;
      final spreadType = _getTypeByName(schema, spreadClassName);

      if (spreadType.possibleTypes.isNotEmpty) {
        // If it's, say, a union type, add to factory possibilities all possibleTypes that the query selects
        factoryPossibilities.addAll(spreadType.possibleTypes
            .where((t) => selection.inlineFragment.selectionSet.selections.any(
                (s) =>
                    s.inlineFragment != null &&
                    s.inlineFragment.typeCondition.typeName.name == t.name))
            .map((t) => t.name));
      } else {
        factoryPossibilities.add(spreadClassName);
      }

      queue.addAll(_generateQueryClass(
          buffer,
          selection.inlineFragment.selectionSet,
          fragments,
          schema,
          spreadClassName,
          spreadType,
          options,
          schemaMap,
          parentSelectionSet: selectionSet));
    });

    // Part of a union type
    final unionOf = schema.types.firstWhere(
        (t) =>
            t.kind == GraphQLTypeKind.UNION &&
            t.possibleTypes.any((pt) => pt.name == currentType.name),
        orElse: () => null);
    if (unionOf != null) {
      mixins = 'extends ${unionOf.name}';
    }

    // If this is an interface or union type, we must add resolveType
    if (currentType.kind == GraphQLTypeKind.INTERFACE) {
      classProperties.add(ClassProperty('String', 'resolveType',
          annotation: '@JsonKey(name: \'${schemaMap.resolveTypeField}\')'));
    }

    // If this is an interface child, we must add mixins and resolveType
    if (currentType.interfaces.isNotEmpty ||
        currentType.kind == GraphQLTypeKind.UNION) {
      final interfacesOfUnion = currentType.kind == GraphQLTypeKind.UNION
          ? currentType.possibleTypes
              .map((t) => _getTypeByName(schema, t.name)
                  .interfaces
                  .map((t) => _getTypeByName(schema, t.name)))
              .expand<GraphQLType>((i) => i)
          : <GraphQLType>[];
      final implementations = currentType.interfaces
          .map((t) => _getTypeByName(schema, t.name))
          .toSet()
            ..addAll(interfacesOfUnion);

      mixins =
          '$mixins implements ' + implementations.map((t) => t.name).join(', ');

      classProperties.add(ClassProperty('String', 'resolveType',
          annotation: '@JsonKey(name: \'${schemaMap.resolveTypeField}\')',
          override: true));

      implementations.forEach((interfaceType) {
        parentSelectionSet.selections
            .where((s) => s.field != null)
            .forEach((selection) {
          final cp = selectionToClassProperty(
              selection, schema, interfaceType, options);
          classProperties.add(cp.copyWith(override: true));
        });
      });
    }

    queue.insert(
      0,
      ClassDefinition(
        className,
        classProperties,
        mixins: mixins,
        factoryPossibilities: factoryPossibilities,
        resolveTypeField: schemaMap.resolveTypeField,
      ),
    );

    return queue;
  }
  return [];
}

class ClassProperty {
  final String type;
  final String name;
  final bool override;
  final String annotation;

  ClassProperty(this.type, this.name,
      {this.override = false, this.annotation = ''});

  ClassProperty copyWith({type, name, override, annotation}) =>
      ClassProperty(type ?? this.type, name ?? this.name,
          override: override ?? this.override,
          annotation: annotation ?? this.annotation);
}

class QueryInput {
  final String type;
  final String name;

  QueryInput(this.type, this.name);
}

void _printCustomEnum(
    StringBuffer buffer, String enumName, List<String> enumValues) {
  buffer.writeln('enum $enumName {');
  for (final enumValue in enumValues) {
    buffer.writeln('  $enumValue,');
  }
  buffer.writeln('}');
}

class ClassDefinition {
  final String className;
  final List<ClassProperty> classProperties;
  final String mixins;
  final Set<String> factoryPossibilities;
  final String resolveTypeField;

  ClassDefinition(
    this.className,
    this.classProperties, {
    this.mixins = '',
    this.factoryPossibilities = const {},
    this.resolveTypeField = '__resolveType',
  }) : assert(
            factoryPossibilities.isEmpty ||
                (factoryPossibilities.isNotEmpty && resolveTypeField != null),
            'To use a custom factory, include resolveType.');
}

void _printCustomClass(StringBuffer buffer, ClassDefinition definition) async {
  buffer.writeln('''

@JsonSerializable()
class ${definition.className} ${definition.mixins} {''');

  for (final prop in definition.classProperties) {
    if (prop.override) buffer.writeln('  @override');
    if (prop.annotation != null) buffer.writeln('  ${prop.annotation}');
    buffer.writeln('  ${prop.type} ${prop.name};');
  }

  buffer.writeln('''

  ${definition.className}();''');

  if (definition.factoryPossibilities.isNotEmpty) {
    buffer.writeln('''

  factory ${definition.className}.fromJson(Map<String, dynamic> json) {
    switch (json['${definition.resolveTypeField}']) {''');

    for (final p in definition.factoryPossibilities) {
      buffer.writeln('''case '$p':
        return ${p}.fromJson(json);''');
    }

    buffer.writeln('''default:
    }
    return _\$${definition.className}FromJson(json);
  }
  Map<String, dynamic> toJson() {
    switch (resolveType) {''');

    for (final p in definition.factoryPossibilities) {
      buffer.writeln('''case '$p':
        return (this as ${p}).toJson();''');
    }

    buffer.writeln('''default:
    }
    return _\$${definition.className}ToJson(this);
  }''');
  } else {
    buffer.writeln(
        '''factory ${definition.className}.fromJson(Map<String, dynamic> json) => _\$${definition.className}FromJson(json);
  Map<String, dynamic> toJson() => _\$${definition.className}ToJson(this);''');
  }

  buffer.writeln('}');
}
