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
  group('On objects', () {
    final builder = graphQLTypesBuilder(BuilderOptions({}));

    test('Even without properties, a object has __typename', () async {
      final GraphQLSchema schema = GraphQLSchema(types: [
        GraphQLType(
            name: 'SomeObject', kind: GraphQLTypeKind.OBJECT, fields: []),
      ]);

      await testBuilder(builder, {
        'a|api.schema.json': jsonFromSchema(schema),
      }, outputs: {
        'a|api.api.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'api.api.g.dart';

@JsonSerializable()
class SomeObject {
  @JsonKey(name: \'__typename\')
  String typename;

  SomeObject();

  factory SomeObject.fromJson(Map<String, dynamic> json) =>
      _\$SomeObjectFromJson(json);
  Map<String, dynamic> toJson() => _\$SomeObjectToJson(this);
}
''',
      });
    });

    test('Every object yield its own class', () async {
      final GraphQLSchema schema = GraphQLSchema(types: [
        GraphQLType(name: 'ID', kind: GraphQLTypeKind.SCALAR),
        GraphQLType(
            name: 'SomeObject',
            kind: GraphQLTypeKind.OBJECT,
            fields: [GraphQLField(name: 'id', type: GraphQLType(name: 'ID'))]),
        GraphQLType(name: 'AnotherObject', kind: GraphQLTypeKind.OBJECT),
      ]);

      await testBuilder(builder, {
        'a|api.schema.json': jsonFromSchema(schema),
      }, outputs: {
        'a|api.api.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'api.api.g.dart';

@JsonSerializable()
class SomeObject {
  @JsonKey(name: \'__typename\')
  String typename;
  String id;

  SomeObject();

  factory SomeObject.fromJson(Map<String, dynamic> json) =>
      _\$SomeObjectFromJson(json);
  Map<String, dynamic> toJson() => _\$SomeObjectToJson(this);
}

@JsonSerializable()
class AnotherObject {
  @JsonKey(name: \'__typename\')
  String typename;

  AnotherObject();

  factory AnotherObject.fromJson(Map<String, dynamic> json) =>
      _\$AnotherObjectFromJson(json);
  Map<String, dynamic> toJson() => _\$AnotherObjectToJson(this);
}
''',
      });
    });
  });
}
