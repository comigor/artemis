import 'dart:async';

import 'package:gql/execution.dart' as exec;
import 'package:gql/language.dart';
import 'package:gql/link.dart';
import 'package:gql_dedupe_link/gql_dedupe_link.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

import './schema/graphql_query.dart';
import './schema/graphql_response.dart';

/// Used to execute a GraphQL query or mutation and return its typed response.
///
/// A [Link] is used as the network interface.
class ArtemisClient {
  final Link _link;

  /// Instantiate an [ArtemisClient].
  ///
  /// [DedupeLink] and [HttpLink] are included.
  /// To use different [Link] create an [ArtemisClient] with [ArtemisClient.fromLink].
  factory ArtemisClient(
    String graphQLEndpoint, {
    http.Client httpClient,
  }) =>
      ArtemisClient.fromLink(
        Link.from([
          DedupeLink(),
          HttpLink(
            graphQLEndpoint,
            httpClient: httpClient,
          ),
        ]),
      );

  /// Create an [ArtemisClient] from [Link].
  ArtemisClient.fromLink(this._link) : assert(_link != null);

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

    final exec.Response response = await _link.request(request).first;

    return GraphQLResponse<T>(
      data: response.data == null ? null : query.parse(response.data),
      errors: response.errors,
    );
  }
}
