import 'dart:async';

import 'package:pokemon_example/queries/simple_query.query.dart';
import 'package:pokemon_example/queries/big_query.query.dart';

Future<void> main() async {
  const graphQLEndpoint = 'https://graphql-pokemon.now.sh/graphql';

  final simpleQueryResponse = await executeSimpleQueryQuery(graphQLEndpoint);
  final bigQueryResponse = await executeBigQueryQuery(graphQLEndpoint);

  print('Simple query response: ${simpleQueryResponse.pokemon.number}');

  for (final pokemon in bigQueryResponse.pokemons) {
    print('#${pokemon.number}: ${pokemon.name}');
  }
}
