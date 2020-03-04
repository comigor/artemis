import 'package:artemis/generator/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On enum list', () {
    test(
      'Enums as lists are generated correctly',
      () async => testGenerator(
        sourceAssetsMap: {
          'a|queries/query.graphql': query,
          'a|queries/query2.graphql': query2,
        },
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        schema: r'''
          schema {
            query: QueryRoot
          }
          
          type QueryRoot {
            q: QueryResponse
          }
          
          type QueryResponse {
            le: [MyEnum]
          }
          
          enum MyEnum {
            A
            B
          }''',
      ),
    );
  });
}

const query = r'''
query custom {
  q {
    le
  }
}
''';

const query2 = r'''
query custom2 {
  q {
    le
  }
}
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      queryName: r'custom',
      queryType: r'Custom$QueryRoot',
      classes: [
        EnumDefinition(
            name: r'MyEnum', values: [r'A', r'B', r'ARTEMIS_UNKNOWN']),
        ClassDefinition(
            name: r'Custom$QueryRoot$QueryResponse',
            properties: [
              ClassProperty(
                  type: r'List<MyEnum>',
                  name: r'le',
                  isOverride: false,
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
      suffix: r'Query'),
  QueryDefinition(
      queryName: r'custom2',
      queryType: r'Custom2$QueryRoot',
      classes: [
        EnumDefinition(
            name: r'MyEnum', values: [r'A', r'B', r'ARTEMIS_UNKNOWN']),
        ClassDefinition(
            name: r'Custom2$QueryRoot$QueryResponse',
            properties: [
              ClassProperty(
                  type: r'List<MyEnum>',
                  name: r'le',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'Custom2$QueryRoot',
            properties: [
              ClassProperty(
                  type: r'Custom2$QueryRoot$QueryResponse',
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
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot$QueryResponse with EquatableMixin {
  Custom$QueryRoot$QueryResponse();

  factory Custom$QueryRoot$QueryResponse.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRoot$QueryResponseFromJson(json);

  List<MyEnum> le;

  @override
  List<Object> get props => [le];
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

enum MyEnum {
  A,
  B,
  ARTEMIS_UNKNOWN,
}
''';
