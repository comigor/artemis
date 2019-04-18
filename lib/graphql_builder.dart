library graphql_builder;

import 'dart:io';
import 'dart:convert';
import 'schema/graphql.dart';

void main() async {
  final file = File(
      '/Users/igor/Projects/nu/mini-meta-repo/cross-platform/react-native/data/schema.json');
  final schema = GraphQLSchema.fromJson(
      await file.readAsString().then((s) => json.decode(s)));

  print(schema);
  print(schema);
  print(schema.types);
  print(schema.types.first);
  print(schema.types.first.kind);
}
