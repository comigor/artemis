import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'package:artemis/schema/options.dart';
import 'package:artemis/schema/graphql.dart';

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

bool _isEventuallyList(GraphQLType type) {
  if (type == null) {
    return false;
  }

  switch (type.kind) {
    case GraphQLTypeKind.LIST:
      return true;
    default:
      return _isEventuallyList(type.ofType);
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

String _addListIfNecessary(bool isList, String typeStr, GraphQLField field) {
  if (isList) {
    return '  List<$typeStr> ${field.name};';
  }
  return '  $typeStr ${field.name};';
}

void _generateClassProperty(StringBuffer buffer, GraphQLSchema schema,
    GraphQLField field, GeneratorOptions options,
    {String prefix = '', bool override = false}) {
  final subType = _getTypeFromField(schema, field);
  final isList = _isEventuallyList(field.type);
  final scalar = _getSingleScalarMap(options, subType);

  final typeStr = subType.kind == GraphQLTypeKind.SCALAR
      ? scalar.dartType
      : prefix + subType.name;

  if (subType.kind == GraphQLTypeKind.SCALAR && scalar.useCustomParser) {
    final graphqlType = scalar.graphQLType;
    final appendList = isList ? 'List' : '';
    buffer.writeln(
        '  @JsonKey(fromJson: fromGraphQL$graphqlType${appendList}ToDart$typeStr$appendList, toJson: fromDart$typeStr${appendList}ToGraphQL$graphqlType$appendList)');
  }

  if (override) {
    buffer.writeln('  @override');
  }

  buffer.writeln(_addListIfNecessary(isList, typeStr, field));
}

void _generateResolveTypeProperty(StringBuffer buffer) {
  buffer.writeln('''  @JsonKey(name: '__resolveType')
  String resolveType;''');
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
  
  $className();

  factory $className.fromJson(Map<String, dynamic> json) => _\$${className}FromJson(json);
  Map<String, dynamic> toJson() => _\$${className}ToJson(this);''');
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

      if (type.interfaces.isNotEmpty) {
        _generateResolveTypeProperty(buffer);
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
  
  $className();

  factory $className.fromJson(Map<String, dynamic> json) => _\$${className}FromJson(json);
  Map<String, dynamic> toJson() => _\$${className}ToJson(this);''');
      buffer.writeln('}');
      return;
    default:
  }
}

const String introspectionQuery = '''
  query IntrospectionQuery {
    __schema {
      queryType { name }
      mutationType { name }
      subscriptionType { name }
      types {
        ...FullType
      }
      directives {
        name
        description
        locations
        args {
          ...InputValue
        }
      }
    }
  }

  fragment FullType on __Type {
    kind
    name
    description
    fields(includeDeprecated: true) {
      name
      description
      args {
        ...InputValue
      }
      type {
        ...TypeRef
      }
      isDeprecated
      deprecationReason
    }
    inputFields {
      ...InputValue
    }
    interfaces {
      ...TypeRef
    }
    enumValues(includeDeprecated: true) {
      name
      description
      isDeprecated
      deprecationReason
    }
    possibleTypes {
      ...TypeRef
    }
  }

  fragment InputValue on __InputValue {
    name
    description
    type { ...TypeRef }
    defaultValue
  }

  fragment TypeRef on __Type {
    kind
    name
    ofType {
      kind
      name
      ofType {
        kind
        name
        ofType {
          kind
          name
          ofType {
            kind
            name
            ofType {
              kind
              name
              ofType {
                kind
                name
                ofType {
                  kind
                  name
                }
              }
            }
          }
        }
      }
    }
  }
''';

Future<GraphQLSchema> fetchGraphQLSchemaFromURL(String graphqlEndpoint,
    {http.Client client}) async {
  final httpClient = client ?? http.Client();

  final response = await httpClient.post(graphqlEndpoint, body: {
    'operationName': 'IntrospectionQuery',
    'query': introspectionQuery,
  });

  return schemaFromJsonString(response.body);
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
