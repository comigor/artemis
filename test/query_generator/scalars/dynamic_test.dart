// @dart = 2.8

import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On scalars', () {
    test(
      'When they are dynamic',
      () async => testGenerator(
        query: 'query { a, b }',
        schema: r'''
            scalar JSON
            scalar MyDynamic
            
            type Query {
              a: JSON
              b: MyDynamic
            }
          ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        builderOptionsMap: {
          'scalar_mapping': [
            {
              'graphql_type': 'JSON',
              'dart_type': 'Map<String, dynamic>',
              'custom_parser_import': 'package:example/src/custom_parser.dart',
            },
            {
              'graphql_type': 'MyDynamic',
              'dart_type': 'dynamic',
              'custom_parser_import': 'package:example/src/custom_parser.dart',
            },
          ],
        },
      ),
    );
  });
}

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'Query$_Query'),
      operationName: r'query',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'Query$_Query'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'Map<String, dynamic>'),
                  name: ClassPropertyName(name: r'a'),
                  annotations: [
                    r'JsonKey(fromJson: fromGraphQLJSONToDartMapStringDynamic, toJson: fromDartMapStringDynamicToGraphQLJSON)'
                  ],
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'dynamic'),
                  name: ClassPropertyName(name: r'b'),
                  annotations: [
                    r'JsonKey(fromJson: fromGraphQLMyDynamicToDartDynamic, toJson: fromDartDynamicToGraphQLMyDynamic)'
                  ],
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false)
      ],
      generateHelpers: false,
      suffix: r'Query')
], customImports: [
  r'package:example/src/custom_parser.dart'
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Query$Query extends JsonSerializable with EquatableMixin {
  Query$Query();

  factory Query$Query.fromJson(Map<String, dynamic> json) =>
      _$Query$QueryFromJson(json);

  Map<String, dynamic> a;

  dynamic b;

  @override
  List<Object> get props => [a, b];
  Map<String, dynamic> toJson() => _$Query$QueryToJson(this);
}
''';
