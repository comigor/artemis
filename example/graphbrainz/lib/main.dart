import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'graphbrainz.api.dart';

Future<void> main() async {
  const graphQLEndpoint = 'https://graphbrainz.herokuapp.com/';
  final client = http.Client();
  final dataResponse = await client.post(graphQLEndpoint, body: {
    'operationName': 'EdSheeran',
    'query': '''
query EdSheeran {
  node(id: "QXJ0aXN0OmI4YTdjNTFmLTM2MmMtNGRjYi1hMjU5LWJjNmUwMDk1ZjBhNg==") {
    __typename
    id
    ... on Artist {
      mbid
      name
      lifeSpan {
        begin
      }
      spotify {
        href
      }
    }
  }
}'''
  });
  client.close();

  final typedResponse = Query.fromJson(json.decode(dataResponse.body)['data']);

  print(typedResponse.node.id);
  print(typedResponse.node.typename);
  // print((typedResponse.node as Artist).spotify.href);
}
