import 'dart:async';
import 'package:graphbrainz_example/queries/ed_sheeran.query.dart';
import 'package:artemis/client.dart';

Future<void> main() async {
  const graphQLEndpoint = 'https://graphbrainz.herokuapp.com/';
  final client = ArtemisClient(graphQLEndpoint);

  final query = EdSheeranQuery();
  final response = await client.execute(query);

  if (response.hasErrors) {
    return print('Error: ${response.errors.map((e) => e.message).toList()}');
  }

  print(response.data.node.resolveType);
  final edSheeran = response.data.node as Artist;
  print(edSheeran.name);
  print(edSheeran.lifeSpan.begin);
  print(edSheeran.spotify.href);
}
