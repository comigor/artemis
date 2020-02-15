import 'package:artemis/generator/data.dart';
import 'package:artemis/schema/graphql.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On scalars', () {
    group('On custom scalars', () {
      test(
        'If they can be converted to a simple dart class',
        () async => testGenerator(
          query: 'query query { a }',
          libraryDefinition: libraryDefinition,
          generatedFile: generatedFile,
          typedSchema: schemaWithCustomScalar,
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
        libraryDefinition: libraryDefinitionWithCustomParserFns,
        generatedFile: generatedFileWithCustomParserFns,
        typedSchema: schemaWithCustomScalar,
        builderOptionsMap: {
          'scalar_mapping': [
            {
              'graphql_type': 'MyUuid',
              'custom_parser_import': 'package:example/src/custom_parser.dart',
              'dart_type': 'MyUuid',
            },
          ],
        },
      ),
    );

    test(
      'When they need custom imports',
      () async => testGenerator(
        query: 'query query { a }',
        libraryDefinition: libraryDefinitionWithCustomImports,
        generatedFile: generatedFileWithCustomImports,
        typedSchema: schemaWithCustomScalar,
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

final schemaWithCustomScalar = GraphQLSchema(
    queryType: GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT),
    types: [
      GraphQLType(name: 'MyUuid', kind: GraphQLTypeKind.SCALAR),
      GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT, fields: [
        GraphQLField(
          name: 'a',
          type: GraphQLType(name: 'MyUuid', kind: GraphQLTypeKind.SCALAR),
        ),
      ]),
    ]);

final libraryDefinition = LibraryDefinition(basename: r'query', queries: [
  QueryDefinition(
      queryName: r'query',
      queryType: r'Query$SomeObject',
      classes: [
        ClassDefinition(
            name: r'Query$SomeObject',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r'a',
                  isOverride: false,
                  isNonNull: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false)
      ],
      generateHelpers: false)
]);

final libraryDefinitionWithCustomParserFns =
    LibraryDefinition(basename: r'query', queries: [
  QueryDefinition(
      queryName: r'query',
      queryType: r'Query$SomeObject',
      classes: [
        ClassDefinition(
            name: r'Query$SomeObject',
            properties: [
              ClassProperty(
                  type: r'MyUuid',
                  name: r'a',
                  isOverride: false,
                  annotation:
                      r'JsonKey(fromJson: fromGraphQLMyUuidToDartMyUuid, toJson: fromDartMyUuidToGraphQLMyUuid)',
                  isNonNull: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false)
      ],
      generateHelpers: false)
], customImports: [
  r'package:example/src/custom_parser.dart'
]);

final libraryDefinitionWithCustomImports =
    LibraryDefinition(basename: r'query', queries: [
  QueryDefinition(
      queryName: r'query',
      queryType: r'Query$SomeObject',
      classes: [
        ClassDefinition(
            name: r'Query$SomeObject',
            properties: [
              ClassProperty(
                  type: r'MyUuid',
                  name: r'a',
                  isOverride: false,
                  annotation:
                      r'JsonKey(fromJson: fromGraphQLMyUuidToDartMyUuid, toJson: fromDartMyUuidToGraphQLMyUuid)',
                  isNonNull: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false)
      ],
      generateHelpers: false)
], customImports: [
  r'package:uuid/uuid.dart',
  r'package:example/src/custom_parser.dart'
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.g.dart';

@JsonSerializable(explicitToJson: true)
class Query$SomeObject with EquatableMixin {
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
part 'query.g.dart';

@JsonSerializable(explicitToJson: true)
class Query$SomeObject with EquatableMixin {
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

const generatedFileWithCustomImports =
    r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:uuid/uuid.dart';
import 'package:example/src/custom_parser.dart';
part 'query.g.dart';

@JsonSerializable(explicitToJson: true)
class Query$SomeObject with EquatableMixin {
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
