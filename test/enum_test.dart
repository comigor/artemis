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
  group('On enums', () {
    final builder = graphQLTypesBuilder(BuilderOptions({}));

    test('Even without properties, a object has __typename', () async {
      final GraphQLSchema schema = GraphQLSchema(types: [
        GraphQLType(name: 'SomeEnum', kind: GraphQLTypeKind.ENUM, enumValues: [
          GraphQLEnumValue(name: 'OPTION_A'),
          GraphQLEnumValue(name: 'OptionB'),
          GraphQLEnumValue(name: 'optionC'),
          GraphQLEnumValue(name: 'option_d'),
        ]),
      ]);

      await testBuilder(builder, {
        'a|api.schema.json': jsonFromSchema(schema),
      }, outputs: {
        'a|api.api.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'api.api.g.dart';

enum SomeEnum {
  OPTION_A,
  OptionB,
  optionC,
  option_d,
}
''',
      });
    });
  });
}
