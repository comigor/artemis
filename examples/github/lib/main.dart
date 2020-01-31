import 'dart:async';
import 'dart:io';

import 'package:artemis/artemis.dart';
import 'package:http/http.dart' as http;

import 'graphql/search_repositories.dart';

class AuthenticatedClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Authorization'] =
        'Bearer ${Platform.environment['GITHUB_TOKEN']}';
    return _inner.send(request);
  }
}

Future<void> main() async {
  final client = ArtemisClient(
    'https://api.github.com/graphql',
    httpClient: AuthenticatedClient(),
  );

  final query = SearchRepositoriesQuery(
    variables: SearchRepositoriesArguments(query: 'flutter'),
  );

  final response = await client.execute(query);

  (response?.data?.search?.nodes ?? [])
      .whereType<
          SearchRepositories$Query$SearchResultItemConnection$SearchResultItem$Repository>()
      .map((r) => r.name)
      .forEach(print);
}
