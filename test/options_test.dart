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
  group('On builder options', () {
    test('Custom scalars can have custom parsers', () async {
      final anotherBuilder = graphQLTypesBuilder(BuilderOptions({
        'custom_parser_import': 'package:a/coercers.dart',
        'scalar_mapping': [
          {
            'graphql_type': 'Date',
            'dart_type': 'DateTime',
            'use_custom_parser': true,
          },
          {
            'graphql_type': 'CustomNumber',
            'dart_type': 'double',
          }
        ]
      }));
      final GraphQLSchema schema = GraphQLSchema(types: [
        GraphQLType(name: 'Date', kind: GraphQLTypeKind.SCALAR),
        GraphQLType(name: 'CustomNumber', kind: GraphQLTypeKind.SCALAR),
        GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT, fields: [
          GraphQLField(name: 'd', type: GraphQLType(name: 'Date')),
          GraphQLField(name: 'n', type: GraphQLType(name: 'CustomNumber')),
        ]),
      ]);

      await testBuilder(anotherBuilder, {
        'a|api.schema.json': jsonFromSchema(schema),
      }, outputs: {
        'a|api.api.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:a/coercers.dart';

part 'api.api.g.dart';

@JsonSerializable()
class SomeObject {
  @JsonKey(
      fromJson: fromGraphQLDateToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDate)
  DateTime d;
  double n;

  SomeObject();

  factory SomeObject.fromJson(Map<String, dynamic> json) =>
      _\$SomeObjectFromJson(json);
  Map<String, dynamic> toJson() => _\$SomeObjectToJson(this);
}
''',
      });
    });

    test('Custom prefix prefixes all classes and enums', () async {
      final anotherBuilder =
          graphQLTypesBuilder(BuilderOptions({'prefix': 'PRE_'}));
      final GraphQLSchema schema = GraphQLSchema(types: [
        GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
        GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT, fields: [
          GraphQLField(name: 'a', type: GraphQLType(name: 'String')),
          GraphQLField(name: 'b', type: GraphQLType(name: 'AnotherObject')),
        ]),
        GraphQLType(name: 'AnotherObject', kind: GraphQLTypeKind.OBJECT),
        GraphQLType(name: 'AEnum', kind: GraphQLTypeKind.ENUM, enumValues: [
          GraphQLEnumValue(name: 'OPTION_A'),
          GraphQLEnumValue(name: 'OPTION_B'),
        ]),
      ]);

      await testBuilder(anotherBuilder, {
        'a|api.schema.json': jsonFromSchema(schema),
      }, outputs: {
        'a|api.api.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'api.api.g.dart';

@JsonSerializable()
class PRE_SomeObject {
  String a;
  PRE_AnotherObject b;

  PRE_SomeObject();

  factory PRE_SomeObject.fromJson(Map<String, dynamic> json) =>
      _\$PRE_SomeObjectFromJson(json);
  Map<String, dynamic> toJson() => _\$PRE_SomeObjectToJson(this);
}

@JsonSerializable()
class PRE_AnotherObject {
  PRE_AnotherObject();

  factory PRE_AnotherObject.fromJson(Map<String, dynamic> json) =>
      _\$PRE_AnotherObjectFromJson(json);
  Map<String, dynamic> toJson() => _\$PRE_AnotherObjectToJson(this);
}

enum PRE_AEnum {
  OPTION_A,
  OPTION_B,
}
''',
      });
    });
  });
}
