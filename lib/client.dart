import 'package:artemis/schema/graphql_error.dart';
import 'package:artemis/schema/graphql_query.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

class ArtemisClient {
  ArtemisClient(this.graphQLEndpoint, {http.Client httpClient}) {
    this.httpClient = httpClient ?? http.Client();
  }

  final String graphQLEndpoint;
  http.Client httpClient;

  Future<GraphQLResponse<T>> execute<T, U extends JsonSerializable>(
      GraphQLQuery<T, U> query,
      {http.Client client}) async {
    final dataResponse = await httpClient.post(
      graphQLEndpoint,
      body: json.encode({
        'operationName': query.operationName,
        'variables': query.getVariablesMap(),
        'query': query.query,
      }),
      headers: (client != null)
          ? null
          : {
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
    );

    final Map<String, dynamic> jsonBody = json.decode(dataResponse.body);
    final response = GraphQLResponse<T>.fromJson(jsonBody)
      ..data = query.parse(jsonBody['data'] ?? <Map<String, dynamic>>{});

    return response;
  }
}
