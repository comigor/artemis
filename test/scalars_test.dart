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
          GraphQLField(name: 'b', type: GraphQLType(name: 'Boolean')),
          GraphQLField(name: 'f', type: GraphQLType(name: 'Float')),
          GraphQLField(name: 'id', type: GraphQLType(name: 'ID')),
          GraphQLField(name: 'i', type: GraphQLType(name: 'Int')),
          GraphQLField(name: 's', type: GraphQLType(name: 'String')),
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
  @JsonKey(name: \'__typename\')
  String typename;
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
  @JsonKey(name: \'__typename\')
  String typename;
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
  });
}
