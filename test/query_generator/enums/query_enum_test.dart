import 'package:artemis/generator/data.dart';
import 'package:artemis/schema/graphql.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On enums', () {
    testGenerator(
      description: 'Enums can be part of queries responses',
      query: query,
      libraryDefinition: libraryDefinition,
      generatedFile: generatedFile,
      typedSchema: schema,
    );
  });
}

const query = r'''
query custom {
  q {
    e
  }
}
''';

final schema = GraphQLSchema(
    queryType: GraphQLType(name: 'QueryRoot', kind: GraphQLTypeKind.OBJECT),
    types: [
      GraphQLType(name: 'MyEnum', kind: GraphQLTypeKind.ENUM, enumValues: [
        GraphQLEnumValue(name: 'A'),
        GraphQLEnumValue(name: 'B'),
      ]),
      GraphQLType(
        name: 'QueryResponse',
        kind: GraphQLTypeKind.OBJECT,
        fields: [
          GraphQLField(
              name: 'e',
              type: GraphQLType(name: 'MyEnum', kind: GraphQLTypeKind.ENUM)),
        ],
      ),
      GraphQLType(
        name: 'QueryRoot',
        kind: GraphQLTypeKind.OBJECT,
        fields: [
          GraphQLField(
              name: 'q',
              type: GraphQLType(
                  name: 'QueryResponse', kind: GraphQLTypeKind.OBJECT)),
        ],
      ),
    ]);

final libraryDefinition = LibraryDefinition(basename: r'query', queries: [
  QueryDefinition(
      queryName: r'custom',
      queryType: r'Custom$QueryRoot',
      classes: [
        EnumDefinition(
            name: r'Custom$QueryRoot$QueryResponse$MyEnum',
            values: [r'A', r'B', r'ARTEMIS_UNKNOWN']),
        ClassDefinition(
            name: r'Custom$QueryRoot$QueryResponse',
            properties: [
              ClassProperty(
                  type: r'Custom$QueryRoot$QueryResponse$MyEnum',
                  name: r'e',
                  isOverride: false,
                  annotation:
                      r'JsonKey(unknownEnumValue: Custom$QueryRoot$QueryResponse$MyEnum.ARTEMIS_UNKNOWN)',
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'Custom$QueryRoot',
            properties: [
              ClassProperty(
                  type: r'Custom$QueryRoot$QueryResponse',
                  name: r'q',
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
class Custom$QueryRoot$QueryResponse with EquatableMixin {
  Custom$QueryRoot$QueryResponse();

  factory Custom$QueryRoot$QueryResponse.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRoot$QueryResponseFromJson(json);

  @JsonKey(
      unknownEnumValue: Custom$QueryRoot$QueryResponse$MyEnum.ARTEMIS_UNKNOWN)
  Custom$QueryRoot$QueryResponse$MyEnum e;

  @override
  List<Object> get props => [e];
  Map<String, dynamic> toJson() => _$Custom$QueryRoot$QueryResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot with EquatableMixin {
  Custom$QueryRoot();

  factory Custom$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRootFromJson(json);

  Custom$QueryRoot$QueryResponse q;

  @override
  List<Object> get props => [q];
  Map<String, dynamic> toJson() => _$Custom$QueryRootToJson(this);
}

enum Custom$QueryRoot$QueryResponse$MyEnum {
  A,
  B,
  ARTEMIS_UNKNOWN,
}
''';
