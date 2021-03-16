// @dart = 2.8

import 'package:artemis/builder.dart';
import 'package:artemis/generator/data/data.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import '../helpers.dart';

void main() {
  group('On nnbd', () {
    test(
      'A simple query yields simple nnbd classes',
      () async => testGenerator(
        query: 'query { nonNullAndSelected, nullableAndSelected }',
        schema: r'''
        type Query {
          nonNullAndSelected: String!
          nonNullAndNotSelected: String!
          nullableAndSelected: String
          nullableAndNotSelected: String
        }
      ''',
        libraryDefinition: libraryDefinition,
        generatedFile: output,
        generateHelpers: false,
        builderOptionsMap: {
          'nnbd': true,
        },
      ),
    );
  });
}

final libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'Query$_Query'),
      operationName: r'query',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'Query$_Query'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'nonNullAndSelected'),
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'nullableAndSelected'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false)
      ],
      generateHelpers: false,
      suffix: r'Query')
]);

const output = r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Query$Query extends JsonSerializable with EquatableMixin {
  Query$Query();

  factory Query$Query.fromJson(Map<String, dynamic> json) =>
      _$Query$QueryFromJson(json);

  late String nonNullAndSelected;

  String? nullableAndSelected;

  @override
  List<Object?> get props => [nonNullAndSelected, nullableAndSelected];
  Map<String, dynamic> toJson() => _$Query$QueryToJson(this);
}
''';
