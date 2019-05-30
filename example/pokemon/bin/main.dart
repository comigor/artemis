import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:graphql_builder/graphql_builder.dart';
import 'pokemon_graphql_api.dart';

Future<void> main() async {
  const graphQLEndpoint = 'https://graphql-pokemon.now.sh/graphql';

  final schema = await fetchGraphQLSchemaFromURL(graphQLEndpoint);
  await generate(schema, File('pokemon_graphql_api.dart'), prefix: 'GQL_');

  final client = http.Client();
  final dataResponse = await client.post(graphQLEndpoint, body: {
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
  client.close();

  final typedResponse =
      GQL_Query.fromJson(json.decode(dataResponse.body)['data']);

  for (final pokemon in typedResponse.pokemons) {
    print('#${pokemon.number}: ${pokemon.name}');
  }
}
