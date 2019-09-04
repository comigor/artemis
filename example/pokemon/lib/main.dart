import 'dart:async';
import 'package:artemis/artemis.dart';
import 'graphql/simple_query.dart';
import 'graphql/big_query.dart';

Future<void> main() async {
  const graphQLEndpoint = 'https://graphql-pokemon.now.sh/graphql';
  final client = ArtemisClient(graphQLEndpoint);

  final simpleQuery = SimpleQueryQuery();
  final bigQuery = BigQueryQuery(variables: BigQueryArguments(quantity: 5));

  final bigQuery2 = BigQueryQuery(variables: BigQueryArguments(quantity: 5));

  print('Equality works: ${bigQuery == bigQuery2}');

  final simpleQueryResponse = await client.execute(simpleQuery);
  final bigQueryResponse = await client.execute(bigQuery);

  print('Simple query response: ${simpleQueryResponse.data.pokemon.number}');

  for (final pokemon in bigQueryResponse.data.pokemons) {
    print('#${pokemon.number}: ${pokemon.name}');
  }
}
