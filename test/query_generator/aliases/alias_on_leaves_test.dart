import 'package:artemis/generator/data.dart';
import 'package:artemis/schema/graphql.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On aliases', () {
    test(
      'Leaves can be aliased',
      () async => testGenerator(
        query: query,
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        typedSchema: schema,
      ),
    );
  });
}

const query = r'''
        query some_query {
          thisIsAString: s
          o {
            thisIsAnEnum: e
          }
        }
        ''';

final schema = GraphQLSchema(
    queryType: GraphQLType(name: 'Query', kind: GraphQLTypeKind.OBJECT),
    types: [
      GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
      GraphQLType(name: 'MyEnum', kind: GraphQLTypeKind.ENUM, enumValues: [
        GraphQLEnumValue(name: 'A'),
        GraphQLEnumValue(name: 'B'),
      ]),
      GraphQLType(name: 'Query', kind: GraphQLTypeKind.OBJECT, fields: [
        GraphQLField(
            name: 's',
            type: GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR)),
        GraphQLField(
            name: 'o',
            type:
                GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT)),
      ]),
      GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT, fields: [
        GraphQLField(
            name: 'e',
            type: GraphQLType(name: 'MyEnum', kind: GraphQLTypeKind.ENUM)),
      ]),
    ]);

final libraryDefinition = LibraryDefinition(basename: r'query', queries: [
  QueryDefinition(
      queryName: r'some_query',
      queryType: r'SomeQuery$Query',
      classes: [
        EnumDefinition(
            name: r'SomeQuery$Query$SomeObject$ThisIsAnEnum',
            values: [r'A', r'B', r'ARTEMIS_UNKNOWN']),
        ClassDefinition(
            name: r'SomeQuery$Query$SomeObject',
            properties: [
              ClassProperty(
                  type: r'SomeQuery$Query$SomeObject$ThisIsAnEnum',
                  name: r'thisIsAnEnum',
                  isOverride: false,
                  annotation:
                      r'JsonKey(unknownEnumValue: SomeQuery$Query$SomeObject$ThisIsAnEnum.ARTEMIS_UNKNOWN)',
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'SomeQuery$Query',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r'thisIsAString',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: r'SomeQuery$Query$SomeObject',
                  name: r'o',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false)
      ],
      generateHelpers: false,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery$Query$SomeObject with EquatableMixin {
  SomeQuery$Query$SomeObject();

  factory SomeQuery$Query$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$Query$SomeObjectFromJson(json);

  @JsonKey(
      unknownEnumValue: SomeQuery$Query$SomeObject$ThisIsAnEnum.ARTEMIS_UNKNOWN)
  SomeQuery$Query$SomeObject$ThisIsAnEnum thisIsAnEnum;

  @override
  List<Object> get props => [thisIsAnEnum];
  Map<String, dynamic> toJson() => _$SomeQuery$Query$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$Query with EquatableMixin {
  SomeQuery$Query();

  factory SomeQuery$Query.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$QueryFromJson(json);

  String thisIsAString;

  SomeQuery$Query$SomeObject o;

  @override
  List<Object> get props => [thisIsAString, o];
  Map<String, dynamic> toJson() => _$SomeQuery$QueryToJson(this);
}

enum SomeQuery$Query$SomeObject$ThisIsAnEnum {
  A,
  B,
  ARTEMIS_UNKNOWN,
}
''';
