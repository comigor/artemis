import 'dart:async';
import 'dart:convert';
import 'package:artemis/schema/graphql_error.dart';
import 'package:artemis/schema/graphql_query.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

class _DefaultHttpJsonClient extends http.BaseClient {
  http.Client _httpClient = http.Client();

  _DefaultHttpJsonClient();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    final jsonHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    request.headers.addAll(jsonHeaders);
    return _httpClient.send(request);
  }
}

class ArtemisClient {
  ArtemisClient(this.graphQLEndpoint, {http.Client httpClient}) {
    this.httpClient = httpClient ?? _DefaultHttpJsonClient();
  }

  final String graphQLEndpoint;
  http.Client httpClient;

  Future<GraphQLResponse<T>> execute<T, U extends JsonSerializable>(
      GraphQLQuery<T, U> query) async {
    final dataResponse = await httpClient.post(
      graphQLEndpoint,
      body: json.encode({
        'operationName': query.operationName,
        'variables': query.getVariablesMap(),
        'query': query.query,
      }),
    );

    final Map<String, dynamic> jsonBody = json.decode(utf8.decode(dataResponse.bodyBytes));
    final response = GraphQLResponse<T>.fromJson(jsonBody)
      ..data = query.parse(jsonBody['data'] ?? {});

    return response;
  }
}
