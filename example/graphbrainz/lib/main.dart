import 'dart:async';

import 'package:artemis/artemis.dart';

import 'queries/ed_sheeran.query.dart';

Future<void> main() async {
  const graphQLEndpoint = 'https://graphbrainz.herokuapp.com/';
  final client = ArtemisClient(graphQLEndpoint);

  final query = EdSheeranQuery();
  final query2 = EdSheeranQuery();
  final response = await client.execute(query);

  print('Equality works: ${query == query2}');

  if (response.hasErrors) {
    return print('Error: ${response.errors.map((e) => e.message).toList()}');
  }

  print(response.data.node.resolveType);
  final edSheeran = response.data.node as Artist;
  print(edSheeran.name);
  print(edSheeran.lifeSpan.begin);
  print(edSheeran.spotify.href);
}
