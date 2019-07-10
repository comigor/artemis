import 'dart:async';

import 'queries/big_query.query.dart';
import 'queries/simple_query.query.dart';

Future<void> main() async {
  const graphQLEndpoint = 'https://graphql-pokemon.now.sh/graphql';

  final simpleQueryResponse = await executeSimpleQueryQuery(graphQLEndpoint);
  final bigQueryResponse = await executeBigQueryQuery(graphQLEndpoint, 10);

  print('Simple query response: ${simpleQueryResponse.data.pokemon.number}');

  for (final pokemon in bigQueryResponse.data.pokemons) {
    print('#${pokemon.number}: ${pokemon.name}');
  }
}
