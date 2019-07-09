import 'dart:async';
import 'package:graphbrainz_example/queries/ed_sheeran.query.dart';

Future<void> main() async {
  const graphQLEndpoint = 'https://graphbrainz.herokuapp.com/';
  final response = await executeEdSheeranQuery(graphQLEndpoint);

  if (response.hasErrors) {
    return print('Error: ${response.errors.map((e) => e.message).toList()}');
  }

  print(response.data.node.resolveType);
  final edSheeran = response.data.node as Artist;
  print(edSheeran.name);
  print(edSheeran.lifeSpan.begin);
  print(edSheeran.spotify.href);
}
