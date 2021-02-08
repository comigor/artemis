import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:http/http.dart' as http;

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

Future<String> fetchGraphQLSchemaStringFromURL(String? graphqlEndpoint,
    {http.Client? client}) async {
  final httpClient = client ?? http.Client();

  final response = await httpClient.post(graphqlEndpoint, body: {
    'operationName': 'IntrospectionQuery',
    'query': introspectionQuery,
  });

  return response.body;
}

void main(List<String> args) async {
  final parser = ArgParser()
    ..addFlag('help', abbr: 'h', help: 'Show this help', negatable: false)
    ..addOption('endpoint',
        abbr: 'e', help: 'Endpoint to hit to get the schema')
    ..addOption('output', abbr: 'o', help: 'File to output the schema to');
  final results = parser.parse(args);

  if (results['help'] as bool || args.isEmpty) {
    return print(parser.usage);
  }

  File(
    results['output'] as String,
  ).writeAsStringSync(
    await fetchGraphQLSchemaStringFromURL(
      results['endpoint'] as String?,
    ),
    flush: true,
  );
}
