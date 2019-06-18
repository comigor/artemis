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

GraphQLType _getTypeFromField(GraphQLSchema schema, GraphQLField field) {
  final finalType = _followType(field.type);
  return _getTypeByName(schema, finalType.name);
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

void _generateClassProperty(StringBuffer buffer, GraphQLSchema schema,
    GraphQLField field, GeneratorOptions options,
    {String prefix = '', bool override = false}) {
  final dartTypeStr = _buildType(field.type, options, prefix, dartType: true);
  final leafType = _getTypeFromField(schema, field);
  final scalar = _getSingleScalarMap(options, leafType);

  if (leafType.kind == GraphQLTypeKind.SCALAR && scalar.useCustomParser) {
    final graphqlTypeSafeStr =
        _buildType(field.type, options, prefix, dartType: false)
            .replaceAll(RegExp(r'[<>]'), '');
    final dartTypeSafeStr = dartTypeStr.replaceAll(RegExp(r'[<>]'), '');
    buffer.writeln(
        '  @JsonKey(fromJson: fromGraphQL${graphqlTypeSafeStr}ToDart$dartTypeSafeStr, toJson: fromDart${dartTypeSafeStr}ToGraphQL$graphqlTypeSafeStr)');
  }

  if (override) {
    buffer.writeln('  @override');
  }

  buffer.writeln('  $dartTypeStr ${field.name};');
}

void _generateResolveTypeProperty(StringBuffer buffer,
    {bool override = false}) {
  if (override) {
    buffer.writeln('  @override');
  }
  buffer.writeln('''  @JsonKey(name: '__resolveType')
  String resolveType;''');
}

void _generateFromToJsonOfPossibleTypes(StringBuffer buffer, GraphQLType type,
    {String prefix = ''}) {
  final className = '$prefix${type.name}';
  buffer.writeln('''

  factory $className.fromJson(Map<String, dynamic> json) {
    switch (json['__resolveType']) {''');

  for (final t in type.possibleTypes) {
    final tClassName = '$prefix${t.name}';
    buffer.writeln('''case '$tClassName':
        return _\$${tClassName}FromJson(json);''');
  }

  buffer.writeln('''default:
    }
    return _\$${className}FromJson(json);
  }
  Map<String, dynamic> toJson() {
    switch (resolveType) {''');

  for (final t in type.possibleTypes) {
    final tClassName = '$prefix${t.name}';
    buffer.writeln('''case '$tClassName':
        return _\$${tClassName}ToJson(this as $tClassName);''');
  }

  buffer.writeln('''default:
    }
    return _\$${className}ToJson(this);
  }''');
}

void _generateClass(StringBuffer buffer, GraphQLSchema schema, GraphQLType type,
    GeneratorOptions options,
    {String prefix = ''}) {
  // Ignore reserved GraphQL types
  if (type.name.startsWith('__')) {
    return;
  }
  final className = '$prefix${type.name}';

  switch (type.kind) {
    case GraphQLTypeKind.ENUM:
      buffer.writeln('enum $className {');
      for (final subEnumValue in type.enumValues) {
        buffer.writeln('  ${subEnumValue.name},');
      }
      buffer.writeln('}');
      return;
    case GraphQLTypeKind.UNION:
      buffer.writeln('@JsonSerializable()');
      buffer.writeln('class $className {');

      _generateResolveTypeProperty(buffer);

      buffer.writeln('''
  
  $className();''');

      _generateFromToJsonOfPossibleTypes(buffer, type, prefix: prefix);

      buffer.writeln('}');
      return;
    case GraphQLTypeKind.INTERFACE:
    case GraphQLTypeKind.OBJECT:
      String mixins = '';

      // Part of a union type
      final unionOf = schema.types.firstWhere(
          (t) =>
              t.kind == GraphQLTypeKind.UNION &&
              t.possibleTypes.any((pt) => pt.name == type.name),
          orElse: () => null);
      if (unionOf != null) {
        mixins = 'extends ${unionOf.name}';
      }

      // Implements some interface
      if (type.interfaces.isNotEmpty) {
        mixins = '$mixins implements ' +
            type.interfaces.map((i) => i.name).join(', ');
      }

      buffer.writeln('@JsonSerializable()');
      buffer.writeln('class $className $mixins {');

      if (type.kind == GraphQLTypeKind.INTERFACE ||
          (type.kind == GraphQLTypeKind.OBJECT && type.interfaces.isNotEmpty)) {
        _generateResolveTypeProperty(buffer,
            override: type.kind == GraphQLTypeKind.OBJECT);
      }

      final interfaceFields = type.interfaces
          .map((t) => _getTypeByName(schema, t.name))
          .map((t) => t.fields)
          .expand((t) => t)
          .toList();

      for (final subField in type.fields) {
        final override = interfaceFields.any((f) => f.name == subField.name);
        _generateClassProperty(buffer, schema, subField, options,
            prefix: prefix, override: override);
      }
      buffer.writeln('''
  
  $className();''');

      if (type.kind == GraphQLTypeKind.INTERFACE) {
        _generateFromToJsonOfPossibleTypes(buffer, type, prefix: prefix);
      } else {
        buffer.writeln('''
  
  factory $className.fromJson(Map<String, dynamic> json) => _\$${className}FromJson(json);
  Map<String, dynamic> toJson() => _\$${className}ToJson(this);''');
      }
      buffer.writeln('}');
      return;
    default:
  }
}

GraphQLSchema schemaFromJsonString(String jsonS) =>
    GraphQLSchema.fromJson(json.decode(jsonS));

Future<String> generate(
    GraphQLSchema schema, String path, GeneratorOptions options) async {
  final basename = p.basenameWithoutExtension(path);
  final customParserImport = options.customParserImport != null
      ? '  import \'${options.customParserImport}\';'
      : '';
  final StringBuffer buffer = StringBuffer()
    ..writeln('''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
$customParserImport

part '$basename.api.g.dart';
''');

  for (final t in schema.types) {
    _generateClass(buffer, schema, t, options, prefix: options.prefix);
    buffer.writeln('');
  }

  return buffer.toString();
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

Future<String> generateQuery(GraphQLSchema schema, String path, String queryStr,
    GeneratorOptions options) async {
  final operation = getOperationFromQuery(queryStr);

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

  _generateQueryClass(
      buffer, operation.selectionSet, schema, className, parentType, options);

  if (options.generateHelpers) {
    final sanitizedQueryStr = queryStr.replaceAll(RegExp(r'\s+'), ' ').trim();
    buffer.writeln('''
Future<$className> execute${className}Query(String graphQLEndpoint, {http.Client client}) async {
  final httpClient = client ?? http.Client();
  final dataResponse = await httpClient.post(graphQLEndpoint, body: {
    'operationName': '${ReCase(className).snakeCase}',
    'query': '$sanitizedQueryStr',
  });
  httpClient.close();

  return $className.fromJson(json.decode(dataResponse.body)['data']);
}
''');
  }

  return buffer.toString();
}

List<Function> _generateQueryClassProperties(
    StringBuffer buffer,
    SelectionSetContext selectionSet,
    GraphQLSchema schema,
    String className,
    GraphQLType parentType,
    GeneratorOptions options) {
  final List<Function> queue = [];
  if (selectionSet != null) {
    for (final selection in selectionSet.selections) {
      // if (selection.fragmentSpread != null) {
      //   print(selection.fragmentSpread.name);
      // }

      if (selection.inlineFragment != null) {
        final spreadType = _getTypeByName(
            schema, selection.inlineFragment.typeCondition.typeName.name);
        final subQueue = _generateQueryClassProperties(
            buffer,
            selection.inlineFragment.selectionSet,
            schema,
            className,
            spreadType,
            options);
        queue.addAll(subQueue);
      }

      if (selection.field != null) {
        final String fieldName = selection.field.fieldName.name;
        String alias = fieldName;
        String aliasClassName;
        bool hasAlias = selection.field.fieldName.alias != null;
        if (hasAlias) {
          alias = selection.field.fieldName.alias.alias;
          aliasClassName =
              ReCase(selection.field.fieldName.alias.alias).pascalCase;
        }

        final graphQLField =
            parentType.fields.firstWhere((f) => f.name == fieldName);
        final leafType =
            _getTypeByName(schema, _followType(graphQLField.type).name);

        final dartTypeStr = _buildType(
            graphQLField.type, options, options.prefix,
            dartType: true, replaceLeafWith: aliasClassName);

        buffer.writeln('  $dartTypeStr $alias;');

        if (leafType.kind != GraphQLTypeKind.SCALAR) {
          queue.add(() => _generateQueryClass(
              buffer,
              selection.field.selectionSet,
              schema,
              aliasClassName ?? leafType.name,
              leafType,
              options));
        }
      }
    }
  }
  return queue;
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
  final String fieldName = selection.field.fieldName.name;
  String alias = fieldName;
  String aliasClassName;
  bool hasAlias = selection.field.fieldName.alias != null;
  if (hasAlias) {
    alias = selection.field.fieldName.alias.alias;
    aliasClassName = ReCase(selection.field.fieldName.alias.alias).pascalCase;
  }

  final graphQLField = type.fields.firstWhere((f) => f.name == fieldName);
  final dartTypeStr = _buildType(graphQLField.type, options, options.prefix,
      dartType: true, replaceLeafWith: aliasClassName);

  final leafType = _getTypeByName(schema, _followType(graphQLField.type).name);
  if (leafType.kind != GraphQLTypeKind.SCALAR && customCall != null) {
    customCall(selection.field.selectionSet, schema,
        aliasClassName ?? leafType.name, leafType, options);
  }

  return ClassProperty(dartTypeStr, alias);
}

void _generateQueryClass(
    StringBuffer buffer,
    SelectionSetContext selectionSet,
    GraphQLSchema schema,
    String className,
    GraphQLType parentType,
    GeneratorOptions options,
    {SelectionSetContext parentSelectionSet}) async {
  if (selectionSet != null) {
    final classProperties = <ClassProperty>[];
    final factoryPossibilities = <String>[];
    final queue = <Function>[];
    String mixins = '';

    // Look at field selections and add it as class properties
    selectionSet.selections.where((s) => s.field != null).forEach((selection) {
      final cp =
          selectionToClassProperty(selection, schema, parentType, options,
              customCall: (selectionSet, _, className, type, _2) {
        queue.add(() => _generateQueryClass(buffer,
            selection.field.selectionSet, schema, className, type, options,
            parentSelectionSet: selectionSet));
      });

      classProperties.add(cp);
    });

    // Look at inline fragment spreads to consider factory overrides
    selectionSet.selections
        .where((s) => s.inlineFragment != null)
        .forEach((selection) {
      final spreadClassName =
          selection.inlineFragment.typeCondition.typeName.name;
      final spreadType = _getTypeByName(schema, spreadClassName);
      queue.add(() => _generateQueryClass(
          buffer,
          selection.inlineFragment.selectionSet,
          schema,
          spreadClassName,
          spreadType,
          options,
          parentSelectionSet: selectionSet));

      factoryPossibilities.add(spreadClassName);
    });

    // If this is an interface typem we must add resolveType
    if (parentType.kind == GraphQLTypeKind.INTERFACE) {
      classProperties.add(ClassProperty('String', 'resolveType',
          annotation: '@JsonKey(name: \'__resolveType\')'));
    }
    // If this is an interface child, we must add mixins and resolveType
    else if (parentType.interfaces.isNotEmpty) {
      mixins =
          'implements ' + parentType.interfaces.map((t) => t.name).join(', ');

      classProperties.add(ClassProperty('String', 'resolveType',
          annotation: '@JsonKey(name: \'__resolveType\')', override: true));

      parentType.interfaces.forEach((interfaceTypeName) {
        parentSelectionSet.selections
            .where((s) => s.field != null)
            .forEach((selection) {
          final cp =
              selectionToClassProperty(selection, schema, parentType, options);
          classProperties.add(cp.copyWith(override: true));
        });
      });
    }

    _printCustomClass(buffer, className, classProperties,
        mixins: mixins, factoryPossibilities: factoryPossibilities);
    queue.forEach((f) => f());
  }
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

void _printCustomClass(
    StringBuffer buffer, String className, List<ClassProperty> classProperties,
    {String mixins = '', List<String> factoryPossibilities = const []}) async {
  buffer.writeln('''

@JsonSerializable()
class $className $mixins {''');

  for (final prop in classProperties) {
    if (prop.override) buffer.writeln('  @override');
    buffer.writeln('  ${prop.annotation}\n  ${prop.type} ${prop.name};');
  }

  buffer.writeln('''

  $className();''');

  if (factoryPossibilities.isNotEmpty) {
    buffer.writeln('''

  factory $className.fromJson(Map<String, dynamic> json) {
    switch (json['__resolveType']) {''');

    for (final p in factoryPossibilities) {
      buffer.writeln('''case '$p':
        return _\$${p}FromJson(json);''');
    }

    buffer.writeln('''default:
    }
    return _\$${className}FromJson(json);
  }
  Map<String, dynamic> toJson() {
    switch (resolveType) {''');

    for (final p in factoryPossibilities) {
      buffer.writeln('''case '$p':
        return _\$${p}ToJson(this);''');
    }

    buffer.writeln('''default:
    }
    return _\$${className}ToJson(this);
  }''');
  } else {
    buffer.writeln(
        '''factory $className.fromJson(Map<String, dynamic> json) => _\$${className}FromJson(json);
  Map<String, dynamic> toJson() => _\$${className}ToJson(this);''');
  }

  buffer.writeln('}');
}
