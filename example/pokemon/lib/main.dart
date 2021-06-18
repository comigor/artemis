import 'dart:async';

import 'package:artemis/artemis.dart';

import 'graphql/big_query.dart';
import 'graphql/simple_query.dart';

Future<void> main() async {
  final client = ArtemisClient(
    'https://graphql-pokemon2.vercel.app',
  );

  final simpleQuery = SimpleQueryQuery();
  final bigQuery = BigQueryQuery(variables: BigQueryArguments(quantity: 5));

  final bigQuery2 = BigQueryQuery(variables: BigQueryArguments(quantity: 5));

  print('Equality works: ${bigQuery == bigQuery2}');

  final simpleQueryResponse = await client.execute(simpleQuery);
  final bigQueryResponse = await client.execute(bigQuery);
  client.dispose();

  print('Simple query response: ${simpleQueryResponse.data?.pokemon?.number}');

  for (final pokemon in bigQueryResponse.data?.pokemons ?? []) {
    print('#${pokemon.number}: ${pokemon.name}');
  }
}
