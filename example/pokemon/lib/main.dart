import 'dart:async';
import 'package:artemis/artemis.dart';
import 'queries/big_query.query.dart';
import 'queries/simple_query.query.dart';

Future<void> main() async {
  const graphQLEndpoint = 'https://graphql-pokemon.now.sh/graphql';
  final client = ArtemisClient(graphQLEndpoint);

  final simpleQuery = SimpleQueryQuery();
  final bigQuery = BigQueryQuery(variables: BigQueryArguments(quantity: 5));

  final simpleQueryResponse = await client.execute(simpleQuery);
  final bigQueryResponse = await client.execute(bigQuery);

  print('Simple query response: ${simpleQueryResponse.data.pokemon.number}');

  for (final pokemon in bigQueryResponse.data.pokemons) {
    print('#${pokemon.number}: ${pokemon.name}');
  }
}
