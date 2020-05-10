import 'package:artemis/generator/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('Enum duplication', () {
    test(
      'Enum duplication should be properly handeled',
      () async => testGenerator(
        query: query,
        namingScheme: 'pathedWithFields',
        schema: r'''
          schema {
            query: Query
          }
          
          type Query {
            q: QueryResponse
            qList: [QueryResponse]
          }
          
          type QueryResponse {
            e: MyEnum
          }
          
          enum MyEnum {
            A
            B
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedCanonicalFile: generatedCanonicalFile,
        generatedFile: generatedFile,
        sourceAssetsMap: {
          'a|queries/another_query.graphql': anotherQuery,
        },
      ),
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

const anotherQuery = r'''
  query customList {
    qList {
      e
    }
  }
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      queryName: r'custom',
      queryType: r'Custom$Query',
      classes: [
        EnumDefinition(
            name: r'MyEnum', values: [r'A', r'B', r'ARTEMIS_UNKNOWN']),
        ClassDefinition(
            name: r'Custom$Query$Q',
            properties: [
              ClassProperty(
                  type: r'MyEnum',
                  name: r'e',
                  isOverride: false,
                  annotation:
                      r'JsonKey(unknownEnumValue: MyEnum.ARTEMIS_UNKNOWN)',
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'Custom$Query',
            properties: [
              ClassProperty(
                  type: r'Custom$Query$Q',
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
      suffix: r'Query'),
  QueryDefinition(
      queryName: r'customList',
      queryType: r'CustomList$Query',
      classes: [
        EnumDefinition(
            name: r'MyEnum', values: [r'A', r'B', r'ARTEMIS_UNKNOWN']),
        ClassDefinition(
            name: r'CustomList$Query$QList',
            properties: [
              ClassProperty(
                  type: r'MyEnum',
                  name: r'e',
                  isOverride: false,
                  annotation:
                      r'JsonKey(unknownEnumValue: MyEnum.ARTEMIS_UNKNOWN)',
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'CustomList$Query',
            properties: [
              ClassProperty(
                  type: r'List<CustomList$Query$QList>',
                  name: r'qList',
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
import 'canonical.graphql.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$Query$Q with EquatableMixin {
  Custom$Query$Q();

  factory Custom$Query$Q.fromJson(Map<String, dynamic> json) =>
      _$Custom$Query$QFromJson(json);

  @JsonKey(unknownEnumValue: MyEnum.ARTEMIS_UNKNOWN)
  MyEnum e;

  @override
  List<Object> get props => [e];
  Map<String, dynamic> toJson() => _$Custom$Query$QToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$Query with EquatableMixin {
  Custom$Query();

  factory Custom$Query.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryFromJson(json);

  Custom$Query$Q q;

  @override
  List<Object> get props => [q];
  Map<String, dynamic> toJson() => _$Custom$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CustomList$Query$QList with EquatableMixin {
  CustomList$Query$QList();

  factory CustomList$Query$QList.fromJson(Map<String, dynamic> json) =>
      _$CustomList$Query$QListFromJson(json);

  @JsonKey(unknownEnumValue: MyEnum.ARTEMIS_UNKNOWN)
  MyEnum e;

  @override
  List<Object> get props => [e];
  Map<String, dynamic> toJson() => _$CustomList$Query$QListToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CustomList$Query with EquatableMixin {
  CustomList$Query();

  factory CustomList$Query.fromJson(Map<String, dynamic> json) =>
      _$CustomList$QueryFromJson(json);

  List<CustomList$Query$QList> qList;

  @override
  List<Object> get props => [qList];
  Map<String, dynamic> toJson() => _$CustomList$QueryToJson(this);
}
''';

String generatedCanonicalFile = '''// GENERATED CODE - DO NOT MODIFY BY HAND

enum MyEnum {
  A,
  B,
  ARTEMIS_UNKNOWN,
}
''';
