import 'dart:convert';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'package:artemis/artemis.dart';
import 'package:artemis/schema/graphql.dart';
import 'package:artemis/generator.dart';

String jsonFromSchema(GraphQLSchema schema) => json.encode({
      'data': {'__schema': schema.toJson()}
    });

void main() {
  group('On objects', () {
    final builder = graphQLTypesBuilder(BuilderOptions({}));

    test('O object can have no properties', () async {
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
        GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT, fields: [
          GraphQLField(
              name: 'id',
              type: GraphQLType(name: 'ID', kind: GraphQLTypeKind.SCALAR))
        ]),
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
  String id;

  SomeObject();

  factory SomeObject.fromJson(Map<String, dynamic> json) =>
      _\$SomeObjectFromJson(json);
  Map<String, dynamic> toJson() => _\$SomeObjectToJson(this);
}

@JsonSerializable()
class AnotherObject {
  AnotherObject();

  factory AnotherObject.fromJson(Map<String, dynamic> json) =>
      _\$AnotherObjectFromJson(json);
  Map<String, dynamic> toJson() => _\$AnotherObjectToJson(this);
}
''',
      });
    });

    test(
        'A property can be either a scalar, another object, or a List of those, and non-nullable doesn\'t interfere on it',
        () async {
      final GraphQLSchema schema = GraphQLSchema(types: [
        GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
        GraphQLType(name: 'AObject', kind: GraphQLTypeKind.OBJECT, fields: [
          GraphQLField(
              name: 'id',
              type: GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR)),
        ]),
        GraphQLType(name: 'BObject', kind: GraphQLTypeKind.OBJECT, fields: [
          GraphQLField(
              name: 'id',
              type: GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR)),
          GraphQLField(
              name: 'names',
              type: GraphQLType(
                  kind: GraphQLTypeKind.LIST,
                  ofType: GraphQLType(name: 'String'))),
          GraphQLField(
              name: 'relation',
              type: GraphQLType(name: 'AObject', kind: GraphQLTypeKind.OBJECT)),
          GraphQLField(
              name: 'relations',
              type: GraphQLType(
                  kind: GraphQLTypeKind.NON_NULL,
                  ofType: GraphQLType(
                      kind: GraphQLTypeKind.LIST,
                      ofType: GraphQLType(
                          kind: GraphQLTypeKind.NON_NULL,
                          ofType: GraphQLType(
                              name: 'AObject',
                              kind: GraphQLTypeKind.OBJECT))))),
        ]),
      ]);

      await testBuilder(builder, {
        'a|api.schema.json': jsonFromSchema(schema),
      }, outputs: {
        'a|api.api.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'api.api.g.dart';

@JsonSerializable()
class AObject {
  String id;

  AObject();

  factory AObject.fromJson(Map<String, dynamic> json) =>
      _\$AObjectFromJson(json);
  Map<String, dynamic> toJson() => _\$AObjectToJson(this);
}

@JsonSerializable()
class BObject {
  String id;
  List<String> names;
  AObject relation;
  List<AObject> relations;

  BObject();

  factory BObject.fromJson(Map<String, dynamic> json) =>
      _\$BObjectFromJson(json);
  Map<String, dynamic> toJson() => _\$BObjectToJson(this);
}
'''
      });
    });

    test('A property can also be a List of Lists of something', () async {
      final GraphQLSchema schema = GraphQLSchema(types: [
        GraphQLType(name: 'Boolean', kind: GraphQLTypeKind.SCALAR),
        GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT, fields: [
          GraphQLField(
              name: 'matrix',
              type: GraphQLType(
                  kind: GraphQLTypeKind.LIST,
                  ofType: GraphQLType(
                      kind: GraphQLTypeKind.LIST,
                      ofType: GraphQLType(
                          kind: GraphQLTypeKind.LIST,
                          ofType: GraphQLType(
                              name: 'Boolean',
                              kind: GraphQLTypeKind.SCALAR))))),
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
  List<List<List<bool>>> matrix;

  SomeObject();

  factory SomeObject.fromJson(Map<String, dynamic> json) =>
      _\$SomeObjectFromJson(json);
  Map<String, dynamic> toJson() => _\$SomeObjectToJson(this);
}
'''
      });
    });
  });
}
