import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../helpers.dart';

void main() {
  group('On nnbd', () {
    test(
      'On field selection',
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
      ),
    );
  });

  test(
    'On lists and nullability',
    () async => testGenerator(
      query: 'query { i, inn, li, linn, lnni, lnninn, matrix, matrixnn }',
      schema: r'''
        type Query {
          i: Int
          inn: Int!
          li: [Int]
          linn: [Int!]
          lnni: [Int]!
          lnninn: [Int!]!
          matrix: [[Int]]
          matrixnn: [[Int!]!]!
        }
      ''',
      libraryDefinition: listsLibraryDefinition,
      generatedFile: listsOutput,
      generateHelpers: false,
    ),
  );
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
                  type: TypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'nonNullAndSelected'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'nullableAndSelected'),
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
  @override
  Map<String, dynamic> toJson() => _$Query$QueryToJson(this);
}
''';

final listsLibraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'Query$_Query'),
      operationName: r'query',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'Query$_Query'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'int'),
                  name: ClassPropertyName(name: r'i'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'int', isNonNull: true),
                  name: ClassPropertyName(name: r'inn'),
                  isResolveType: false),
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: TypeName(name: r'int'), isNonNull: false),
                  name: ClassPropertyName(name: r'li'),
                  isResolveType: false),
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: TypeName(name: r'int', isNonNull: true),
                      isNonNull: false),
                  name: ClassPropertyName(name: r'linn'),
                  isResolveType: false),
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: TypeName(name: r'int'), isNonNull: true),
                  name: ClassPropertyName(name: r'lnni'),
                  isResolveType: false),
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: TypeName(name: r'int', isNonNull: true),
                      isNonNull: true),
                  name: ClassPropertyName(name: r'lnninn'),
                  isResolveType: false),
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: ListOfTypeName(
                          typeName: TypeName(name: r'int'), isNonNull: false),
                      isNonNull: false),
                  name: ClassPropertyName(name: r'matrix'),
                  isResolveType: false),
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: ListOfTypeName(
                          typeName: TypeName(name: r'int', isNonNull: true),
                          isNonNull: true),
                      isNonNull: true),
                  name: ClassPropertyName(name: r'matrixnn'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false)
      ],
      generateHelpers: false,
      suffix: r'Query')
]);

const listsOutput = r'''// GENERATED CODE - DO NOT MODIFY BY HAND
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

  int? i;

  late int inn;

  List<int?>? li;

  List<int>? linn;

  late List<int?> lnni;

  late List<int> lnninn;

  List<List<int?>?>? matrix;

  late List<List<int>> matrixnn;

  @override
  List<Object?> get props => [i, inn, li, linn, lnni, lnninn, matrix, matrixnn];
  @override
  Map<String, dynamic> toJson() => _$Query$QueryToJson(this);
}
''';
