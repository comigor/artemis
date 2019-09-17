import 'dart:async';
import 'dart:convert';

import 'package:gql/execution.dart' as exec;
import 'package:gql/language.dart';
import 'package:gql/link.dart' as gql_link;
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

import './schema/graphql_error.dart';
import './schema/graphql_query.dart';

/// Simple implementation of an HttpLink
class SimpleHttpJsonLink implements gql_link.Link {
  /// Endpoint of a GraphQL service
  final String graphQLEndpoint;

  http.Client _httpClient = http.Client();

  /// Construct the Link
  SimpleHttpJsonLink(this.graphQLEndpoint);

  Future<exec.Response> _post(exec.Request request) async {
    final dataResponse = await _httpClient.post(
      graphQLEndpoint,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        'operationName': request.operation.operationName,
        'variables': request.operation.variables,
        'query': printNode(request.operation.document),
      }),
    );

    final Map<String, dynamic> jsonBody = json.decode(
      utf8.decode(
        dataResponse.bodyBytes,
      ),
    ) as Map<String, dynamic>;

    final response = GraphQLResponse.fromJson(jsonBody);

    // TODO: implement some `GraphQLJsonResponse`
    // to avoid this re-mapping the response.
    //
    // `package:gql:execution` does not care about the
    // transport protocol and the format. It is `SimpleHttpJsonLink`s
    // responsibility because it chooses to use Http and Json.
    return exec.Response(
      errors: response.errors
          ?.map(
            (e) => exec.GraphQLError(
              message: e.message,
              locations: e.locations
                  ?.map(
                    (l) => exec.ErrorLocation(
                      line: l.line,
                      column: l.column,
                    ),
                  )
                  ?.toList(),
              path: e.queryPath,
            ),
          )
          ?.toList(),
      data: jsonBody['data'] as Map<String, dynamic>,
    );
  }

  @override
  Stream<exec.Response> request(
    exec.Request request, [
    gql_link.NextLink forward,
  ]) {
    return Stream.fromFuture(_post(request));
  }
}

/// Used to execute a GraphQL query or mutation and return its typed response.
///
/// A [gql_link.Link] must be provided as a network interface.
///
/// [SimpleHttpJsonLink] is provided as a simple way
/// to execute requests using HTTP and JSON.
class ArtemisClient {
  /// The link which will be used to execute the request.
  final gql_link.Link link;

  /// Instantiates an [ArtemisClient].
  ArtemisClient({
    this.link,
  }) : assert(link != null);

  /// Executes a [GraphQLQuery], returning a typed response.
  Future<GraphQLResponse<T>> execute<T, U extends JsonSerializable>(
    GraphQLQuery<T, U> query,
  ) async {
    final request = exec.Request(
      operation: exec.Operation(
        // TODO: build document into generated code using `package:gql/dart`
        document: parseString(query.query),
        operationName: query.operationName,
        variables: query.getVariablesMap(),
      ),
    );

    final exec.Response response = await link.request(request).first;

    // TODO: make `GraphQLResponse<T>` compatible with `GraphQLJsonResponse`
    // so that the re-mapping more efficient
    return GraphQLResponse<T>(
      data: response.data == null ? null : query.parse(response.data),
      errors: response.errors == null
          ? null
          : response.errors
              .map(
                (e) => GraphQLError(
                  message: e.message,
                  queryPath: e.path
                      .map((dynamic /* String | int */ e) => e.toString())
                      .toList(),
                  locations: e.locations == null
                      ? null
                      : e.locations
                          .map(
                            (l) => GraphQLErrorLocation(
                              line: l.line,
                              column: l.column,
                            ),
                          )
                          .toList(),
                ),
              )
              .toList(),
    );
  }
}
