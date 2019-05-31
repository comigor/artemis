import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'schema/graphql.dart';

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

typedef ScalarMapping = ScalarMap Function(GraphQLType type);

ScalarMap defaultScalarMapping(GraphQLType type) => [
      ScalarMap('Boolean', 'bool'),
      ScalarMap('Float', 'double'),
      ScalarMap('ID', 'String'),
      ScalarMap('Int', 'int'),
      ScalarMap('String', 'String'),
    ].firstWhere((m) => m.graphqlType == type.name, orElse: () => null);

String _addListIfNecessary(bool isList, String typeStr, GraphQLField field) {
  if (isList) {
    return '  List<$typeStr> ${field.name};';
  }
  return '  $typeStr ${field.name};';
}

void _generateClassProperty(
    StringBuffer buffer, GraphQLSchema schema, GraphQLField field,
    {ScalarMapping scalarMap = defaultScalarMapping, String prefix = ''}) {
  final subType = _getTypeFromField(schema, field);
  final isList = _isEventuallyList(field.type);
  final scalar = scalarMap(subType) ?? defaultScalarMapping(subType);

  final typeStr = subType.kind == GraphQLTypeKind.SCALAR
      ? scalar.dartType
      : prefix + subType.name;

  if (subType.kind == GraphQLTypeKind.SCALAR && scalar.useCustomParsers) {
    final graphqlType = scalar.graphqlType;
    final appendList = isList ? 'List' : '';
    buffer.writeln(
        '  @JsonKey(fromJson: fromGraphQL$graphqlType${appendList}ToDart$typeStr$appendList, toJson: fromDart$typeStr${appendList}ToGraphQL$graphqlType$appendList)');
  }

  buffer.writeln(_addListIfNecessary(isList, typeStr, field));
}

void _generateClass(StringBuffer buffer, GraphQLSchema schema, GraphQLType type,
    {ScalarMapping scalarMap = defaultScalarMapping, String prefix = ''}) {
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
      for (final unionType in type.possibleTypes) {
        for (final subField in unionType.fields) {
          _generateClassProperty(buffer, schema, subField,
              scalarMap: scalarMap, prefix: prefix);
        }
      }
      buffer.writeln('''
  
  $className();

  factory $className.fromJson(Map<String, dynamic> json) => _\$${className}FromJson(json);
  Map<String, dynamic> toJson() => _\$${className}ToJson(this);''');
      buffer.writeln('}');
      return;
    case GraphQLTypeKind.INTERFACE:
    // TODO(igor): Consider inherited classes
    case GraphQLTypeKind.OBJECT:
      buffer.writeln('@JsonSerializable()');
      buffer.writeln('class $className {');
      for (final subField in type.fields) {
        _generateClassProperty(buffer, schema, subField,
            scalarMap: scalarMap, prefix: prefix);
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

class ScalarMap {
  final String graphqlType;
  final String dartType;
  final bool useCustomParsers;

  ScalarMap(
    this.graphqlType,
    this.dartType, {
    this.useCustomParsers = false,
  });
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

Future<String> generate(GraphQLSchema schema, String path,
    {String typeCoercingFile,
    ScalarMapping scalarMap = defaultScalarMapping,
    String prefix = ''}) async {
  final basename = p.basenameWithoutExtension(path);
  final StringBuffer buffer = StringBuffer()
    ..writeln('''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
${typeCoercingFile != null ? '  import \'$typeCoercingFile\';' : ''}

part '$basename.api.g.dart';
''');

  for (final t in schema.types) {
    _generateClass(buffer, schema, t, scalarMap: scalarMap, prefix: prefix);
    buffer.writeln('');
  }

  return buffer.toString();
}
