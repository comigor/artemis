import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'pokemon.api.dart';

Future<void> main() async {
  const graphQLEndpoint = 'https://graphql-pokemon.now.sh/graphql';
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

  final typedResponse = Query.fromJson(json.decode(dataResponse.body)['data']);

  for (final pokemon in typedResponse.pokemons) {
    print('#${pokemon.number}: ${pokemon.name}');
  }
}
