import 'dart:convert';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'package:artemis/schema/graphql.dart';
import 'package:artemis/generator.dart';

String jsonFromSchema(GraphQLSchema schema) => json.encode({
      'data': {'__schema': schema.toJson()}
    });

void main() {
  group('On scalars', () {
    final builder = graphQLTypesBuilder(BuilderOptions({}));

    test('Scalars yield no output', () async {
      final GraphQLSchema schema = GraphQLSchema(types: [
        GraphQLType(name: 'ID', kind: GraphQLTypeKind.SCALAR),
        GraphQLType(name: 'AScalar', kind: GraphQLTypeKind.SCALAR),
        GraphQLType(name: 'SomeScalar', kind: GraphQLTypeKind.SCALAR),
      ]);

      await testBuilder(builder, {
        'a|api.schema.json': jsonFromSchema(schema),
      }, outputs: {
        'a|api.api.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'api.api.g.dart';
''',
      });
    });

    test('All default scalars can be converted to Dart types', () async {
      final GraphQLSchema schema = GraphQLSchema(types: [
        GraphQLType(name: 'Boolean', kind: GraphQLTypeKind.SCALAR),
        GraphQLType(name: 'Float', kind: GraphQLTypeKind.SCALAR),
        GraphQLType(name: 'ID', kind: GraphQLTypeKind.SCALAR),
        GraphQLType(name: 'Int', kind: GraphQLTypeKind.SCALAR),
        GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
        GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT, fields: [
          GraphQLField(
              name: 'b',
              type: GraphQLType(name: 'Boolean', kind: GraphQLTypeKind.SCALAR)),
          GraphQLField(
              name: 'f',
              type: GraphQLType(name: 'Float', kind: GraphQLTypeKind.SCALAR)),
          GraphQLField(
              name: 'id',
              type: GraphQLType(name: 'ID', kind: GraphQLTypeKind.SCALAR)),
          GraphQLField(
              name: 'i',
              type: GraphQLType(name: 'Int', kind: GraphQLTypeKind.SCALAR)),
          GraphQLField(
              name: 's',
              type: GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR)),
        ]),
      ]);

      await testBuilder(builder, {
        'a|api.schema.json': jsonFromSchema(schema),
      }, outputs: {
        'a|api.api.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'api.api.g.dart';

@JsonSerializable()
class SomeObject {
  bool b;
  double f;
  String id;
  int i;
  String s;

  SomeObject();

  factory SomeObject.fromJson(Map<String, dynamic> json) =>
      _\$SomeObjectFromJson(json);
  Map<String, dynamic> toJson() => _\$SomeObjectToJson(this);
}
''',
      });
    });
  });
}
