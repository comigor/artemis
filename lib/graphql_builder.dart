library graphql_builder;

import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'schema/graphql.dart';
// import 'pokemon_graphql_api.dart';

GraphQLType getTypeByName(GraphQLSchema schema, String name) =>
    schema.types.firstWhere((t) => t.name == name);

GraphQLType followType(GraphQLType type) {
  switch (type.kind) {
    case GraphQLTypeKind.LIST:
    case GraphQLTypeKind.NON_NULL:
      return followType(type.ofType);
    default:
      return type;
  }
}

bool isEventuallyList(GraphQLType type) {
  if (type == null) return false;
  switch (type.kind) {
    case GraphQLTypeKind.LIST:
      return true;
    default:
      return isEventuallyList(type.ofType);
  }
}

GraphQLType getTypeFromField(GraphQLSchema schema, GraphQLField field) {
  final finalType = followType(field.type);
  return getTypeByName(schema, finalType.name);
}

typedef ScalarMap ScalarMapping(GraphQLType type);

ScalarMap defaultScalarMapping(GraphQLType type) {
  return [
    ScalarMap('Boolean', 'bool'),
    ScalarMap('Float', 'double'),
    ScalarMap('ID', 'String'),
    ScalarMap('Int', 'int'),
    ScalarMap('String', 'String'),
  ].firstWhere((m) => m.graphqlType == type.name, orElse: () => null);
}

void generateClassProperty(
    StringBuffer buffer, GraphQLSchema schema, GraphQLField field,
    {ScalarMapping scalarMap = defaultScalarMapping, String prefix = ''}) {
  final subType = getTypeFromField(schema, field);
  final isList = isEventuallyList(field.type);
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

  final addListIfNecessary = () {
    if (isList) return '  List<$typeStr> ${field.name};';
    return '  $typeStr ${field.name};';
  };

  buffer.writeln(addListIfNecessary());
}

void generateClass(StringBuffer buffer, GraphQLSchema schema, GraphQLType type,
    {ScalarMapping scalarMap = defaultScalarMapping, String prefix = ''}) {
  if (type.name.startsWith('__')) return;
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
          generateClassProperty(buffer, schema, subField,
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
        generateClassProperty(buffer, schema, subField,
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

GraphQLSchema schemaFromJson(String jsonS) =>
    GraphQLSchema.fromJson(json.decode(jsonS));

void generate(GraphQLSchema schema, File generatedFile,
    {String typeCoercingFile,
    ScalarMapping scalarMap = defaultScalarMapping,
    String prefix = ''}) async {
  final StringBuffer buffer = StringBuffer();

  final basename = p.basenameWithoutExtension(generatedFile.path);

  buffer.writeln('''import 'package:json_annotation/json_annotation.dart';
${typeCoercingFile != null ? '  import \'$typeCoercingFile\';' : ''}

part '$basename.g.dart';
''');

  for (final t in schema.types) {
    generateClass(buffer, schema, t, scalarMap: scalarMap, prefix: prefix);
    buffer.writeln('');
  }

  await generatedFile.writeAsString(buffer.toString());
}

void main() async {
  final graphqlEndpoint = 'https://graphql-pokemon.now.sh/graphql';
  final introspectionQueryFile = File('lib/introspection_query.graphql');
  final introspectionQuery = await introspectionQueryFile.readAsString();

  final client = http.Client();
  try {
    final response = await client.post(graphqlEndpoint, body: {
      'operationName': 'IntrospectionQuery',
      'query': introspectionQuery
    });

    final schema = schemaFromJson(response.body);
    generate(schema, File('lib/pokemon_graphql_api.dart'), prefix: 'GQL_');

    final dataResponse = await client.post(graphqlEndpoint, body: {
      'operationName': 'SomePokemons',
      'query': '''
query SomePokemons {
  pokemons(first: 3) {
    id
    number
    name
    types
    attacks {
      fast {
        name
        type
        damage
      }
    }
    evolutions {
      id
    }
    image
  }
}'''
    });

    final typedResponse =
        Query.fromJson(json.decode(dataResponse.body)['data']);
    print(typedResponse.pokemons[0].name);
    print(typedResponse.pokemons[0].attacks.fast[0].name);
  } finally {
    client.close();
  }
}
