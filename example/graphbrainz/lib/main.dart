import 'package:artemis/artemis.dart';

import 'queries/ed_sheeran.query.dart';

void main() async {
  final client = ArtemisClient(
    'https://graphbrainz.herokuapp.com/',
  );

  final query = EdSheeranQuery();
  final query2 = EdSheeranQuery();
  final response = await client.execute(query);
  client.dispose();

  print('Equality works: ${query == query2}');

  if (response.hasErrors) {
    return print('Error: ${response.errors.map((e) => e.message).toList()}');
  }

  print(response.data.node.$$typename);
  final edSheeran = response.data.node as EdSheeran$Query$Node$Artist;
  print(edSheeran.name);
  print(edSheeran.lifeSpan.begin);
}
