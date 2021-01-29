// @dart = 2.8

import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On scalars', () {
    group('On custom scalars', () {
      test(
        'If they can be converted to a simple dart class',
        () async => testGenerator(
          query: 'query query { a }',
          schema: r'''
            scalar MyUuid
            
            schema {
              query: SomeObject
            }
            
            type SomeObject {
              a: MyUuid
            }
          ''',
          libraryDefinition: libraryDefinition,
          generatedFile: generatedFile,
          builderOptionsMap: {
            'scalar_mapping': [
              {
                'graphql_type': 'MyUuid',
                'dart_type': 'String',
              },
            ],
          },
        ),
      );
    });

    test(
      'When they need custom parser functions',
      () async => testGenerator(
        query: 'query query { a }',
        schema: r'''
          scalar MyUuid

          schema {
            query: SomeObject
          }

          type SomeObject {
            a: MyUuid
          }
        ''',
        libraryDefinition: libraryDefinitionWithCustomParserFns,
        generatedFile: generatedFileWithCustomParserFns,
        builderOptionsMap: {
          'scalar_mapping': [
            {
              'graphql_type': 'MyUuid',
              'custom_parser_import': 'package:example/src/custom_parser.dart',
              'dart_type': 'MyDartUuid',
            },
          ],
        },
      ),
    );

    test(
      'When they need custom imports',
      () async => testGenerator(
        query: 'query query { a }',
        schema: r'''
          scalar MyUuid

          schema {
            query: SomeObject
          }

          type SomeObject {
            a: MyUuid
          }
        ''',
        libraryDefinition: libraryDefinitionWithCustomImports,
        generatedFile: generatedFileWithCustomImports,
        builderOptionsMap: {
          'scalar_mapping': [
            {
              'graphql_type': 'MyUuid',
              'custom_parser_import': 'package:example/src/custom_parser.dart',
              'dart_type': {
                'name': 'MyUuid',
                'imports': ['package:uuid/uuid.dart'],
              }
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
      name: QueryName(name: r'Query$_SomeObject'),
      operationName: r'query',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'Query$_SomeObject'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'a'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false)
      ],
      generateHelpers: false,
      suffix: r'Query')
]);

final LibraryDefinition libraryDefinitionWithCustomParserFns =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'Query$_SomeObject'),
      operationName: r'query',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'Query$_SomeObject'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'MyDartUuid'),
                  name: ClassPropertyName(name: r'a'),
                  annotations: [
                    r'JsonKey(fromJson: fromGraphQLMyUuidToDartMyDartUuid, toJson: fromDartMyDartUuidToGraphQLMyUuid)'
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

final LibraryDefinition libraryDefinitionWithCustomImports =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'Query$_SomeObject'),
      operationName: r'query',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'Query$_SomeObject'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'MyUuid'),
                  name: ClassPropertyName(name: r'a'),
                  annotations: [
                    r'JsonKey(fromJson: fromGraphQLMyUuidToDartMyUuid, toJson: fromDartMyUuidToGraphQLMyUuid)'
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
  r'package:uuid/uuid.dart',
  r'package:example/src/custom_parser.dart'
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Query$SomeObject extends JsonSerializable with EquatableMixin {
  Query$SomeObject();

  factory Query$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$Query$SomeObjectFromJson(json);

  String a;

  @override
  List<Object> get props => [a];
  Map<String, dynamic> toJson() => _$Query$SomeObjectToJson(this);
}
''';

const generatedFileWithCustomParserFns =
    r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:example/src/custom_parser.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Query$SomeObject extends JsonSerializable with EquatableMixin {
  Query$SomeObject();

  factory Query$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$Query$SomeObjectFromJson(json);

  @JsonKey(
      fromJson: fromGraphQLMyUuidToDartMyDartUuid,
      toJson: fromDartMyDartUuidToGraphQLMyUuid)
  MyDartUuid a;

  @override
  List<Object> get props => [a];
  Map<String, dynamic> toJson() => _$Query$SomeObjectToJson(this);
}
''';

const generatedFileWithCustomImports =
    r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:uuid/uuid.dart';
import 'package:example/src/custom_parser.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Query$SomeObject extends JsonSerializable with EquatableMixin {
  Query$SomeObject();

  factory Query$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$Query$SomeObjectFromJson(json);

  @JsonKey(
      fromJson: fromGraphQLMyUuidToDartMyUuid,
      toJson: fromDartMyUuidToGraphQLMyUuid)
  MyUuid a;

  @override
  List<Object> get props => [a];
  Map<String, dynamic> toJson() => _$Query$SomeObjectToJson(this);
}
''';
