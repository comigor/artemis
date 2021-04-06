import 'dart:async';

import 'package:gql_dedupe_link/gql_dedupe_link.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_link/gql_link.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

import './schema/graphql_query.dart';
import './schema/graphql_response.dart';

/// Used to execute a GraphQL query or mutation and return its typed response.
///
/// A [Link] is used as the network interface.
class ArtemisClient {
  HttpLink? _httpLink;
  final Link _link;

  /// Instantiate an [ArtemisClient].
  ///
  /// [DedupeLink] and [HttpLink] are included.
  /// To use different [Link] create an [ArtemisClient] with [ArtemisClient.fromLink].
  factory ArtemisClient(
    String graphQLEndpoint, {
    http.Client? httpClient,
  }) {
    final httpLink = HttpLink(
      graphQLEndpoint,
      httpClient: httpClient,
    );
    return ArtemisClient.fromLink(
      Link.from([
        DedupeLink(),
        httpLink,
      ]),
    ).._httpLink = httpLink;
  }

  /// Create an [ArtemisClient] from [Link].
  ArtemisClient.fromLink(this._link);

  /// Executes a [GraphQLQuery], returning a typed response.
  Future<GraphQLResponse<T>> execute<T, U extends JsonSerializable>(
    GraphQLQuery<T, U> query,
  ) async {
    final request = Request(
      operation: Operation(
        document: query.document!,
        operationName: query.operationName,
      ),
      variables: query.getVariablesMap(),
    );

    final response = await _link.request(request).first;

    return GraphQLResponse<T>(
      data: response.data == null ? null : query.parse(response.data),
      errors: response.errors,
    );
  }

  /// Streams a [GraphQLQuery], returning a typed response stream.
  Stream<GraphQLResponse<T>> stream<T, U extends JsonSerializable>(
    GraphQLQuery<T, U> query,
  ) {
    final request = Request(
      operation: Operation(
        document: query.document!,
        operationName: query.operationName,
      ),
      variables: query.getVariablesMap(),
    );

    return _link.request(request).map((response) => GraphQLResponse<T>(
          data: response.data == null ? null : query.parse(response.data),
          errors: response.errors,
        ));
  }

  /// Close the inline [http.Client].
  ///
  /// Keep in mind this will not close clients whose Artemis client
  /// was instantiated from [ArtemisClient.fromLink]. If you're using
  /// this constructor, you need to close your own links.
  void dispose() {
    _httpLink?.dispose();
  }
}
