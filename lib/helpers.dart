import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart' as p;
import 'package:graphql_parser/graphql_parser.dart';
import 'package:artemis/schema/options.dart';
import 'package:artemis/schema/graphql.dart';
import 'package:recase/recase.dart';
import 'package:graphql_parser/graphql_parser.dart';

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
    {bool dartType = true}) {
  switch (type.kind) {
    case GraphQLTypeKind.LIST:
      return 'List<${_buildType(type.ofType, options, prefix, dartType: dartType)}>';
    case GraphQLTypeKind.NON_NULL:
      return _buildType(type.ofType, options, prefix, dartType: dartType);
    case GraphQLTypeKind.SCALAR:
      final scalar = _getSingleScalarMap(options, type);
      return dartType ? scalar.dartType : scalar.graphQLType;
    default:
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
  final className = ReCase(operation.name ?? basename).pascalCase;
  final StringBuffer buffer = StringBuffer()
    ..writeln('''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
$customParserImport

part '$basename.query.g.dart';

@JsonSerializable()
class $className {''');
  buffer.writeln('''

  $className();
  
  factory $className.fromJson(Map<String, dynamic> json) => _\$${className}FromJson(json);
  Map<String, dynamic> toJson() => _\$${className}ToJson(this);
  }''');

  return buffer.toString();
}
