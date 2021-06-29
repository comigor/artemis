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
        query: 'query query { a, b, c, d, e, f }',
        schema: r'''
          scalar MyUuid

          schema {
            query: SomeObject
          }

          type SomeObject {
            a: MyUuid
            b: MyUuid!
            c: [MyUuid!]!
            d: [MyUuid]
            e: [MyUuid]!
            f: [MyUuid!]
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
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
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
                    r'JsonKey(fromJson: fromGraphQLMyUuidNullableToDartMyDartUuidNullable, toJson: fromDartMyDartUuidNullableToGraphQLMyUuidNullable)'
                  ],
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
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
                    r'JsonKey(fromJson: fromGraphQLMyUuidNullableToDartMyUuidNullable, toJson: fromDartMyUuidNullableToGraphQLMyUuidNullable)'
                  ],
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'MyUuid', isNonNull: true),
                  name: ClassPropertyName(name: r'b'),
                  annotations: [
                    r'JsonKey(fromJson: fromGraphQLMyUuidToDartMyUuid, toJson: fromDartMyUuidToGraphQLMyUuid)'
                  ],
                  isResolveType: false),
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: TypeName(name: r'MyUuid', isNonNull: true),
                      isNonNull: true),
                  name: ClassPropertyName(name: r'c'),
                  annotations: [
                    r'JsonKey(fromJson: fromGraphQLListMyUuidToDartListMyUuid, toJson: fromDartListMyUuidToGraphQLListMyUuid)'
                  ],
                  isResolveType: false),
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: TypeName(name: r'MyUuid'), isNonNull: false),
                  name: ClassPropertyName(name: r'd'),
                  annotations: [
                    r'JsonKey(fromJson: fromGraphQLListNullableMyUuidNullableToDartListNullableMyUuidNullable, toJson: fromDartListNullableMyUuidNullableToGraphQLListNullableMyUuidNullable)'
                  ],
                  isResolveType: false),
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: TypeName(name: r'MyUuid'), isNonNull: true),
                  name: ClassPropertyName(name: r'e'),
                  annotations: [
                    r'JsonKey(fromJson: fromGraphQLListMyUuidNullableToDartListMyUuidNullable, toJson: fromDartListMyUuidNullableToGraphQLListMyUuidNullable)'
                  ],
                  isResolveType: false),
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: TypeName(name: r'MyUuid', isNonNull: true),
                      isNonNull: false),
                  name: ClassPropertyName(name: r'f'),
                  annotations: [
                    r'JsonKey(fromJson: fromGraphQLListNullableMyUuidToDartListNullableMyUuid, toJson: fromDartListNullableMyUuidToGraphQLListNullableMyUuid)'
                  ],
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false)
      ],
      generateHelpers: false,
      suffix: r'Query')
], customImports: [
  r'package:uuid/uuid.dart',
  r'package:example/src/custom_parser.dart'
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Query$SomeObject extends JsonSerializable with EquatableMixin {
  Query$SomeObject();

  factory Query$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$Query$SomeObjectFromJson(json);

  String? a;

  @override
  List<Object?> get props => [a];
  @override
  Map<String, dynamic> toJson() => _$Query$SomeObjectToJson(this);
}
''';

const generatedFileWithCustomParserFns =
    r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

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
      fromJson: fromGraphQLMyUuidNullableToDartMyDartUuidNullable,
      toJson: fromDartMyDartUuidNullableToGraphQLMyUuidNullable)
  MyDartUuid? a;

  @override
  List<Object?> get props => [a];
  @override
  Map<String, dynamic> toJson() => _$Query$SomeObjectToJson(this);
}
''';

const generatedFileWithCustomImports =
    r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

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
      fromJson: fromGraphQLMyUuidNullableToDartMyUuidNullable,
      toJson: fromDartMyUuidNullableToGraphQLMyUuidNullable)
  MyUuid? a;

  @JsonKey(
      fromJson: fromGraphQLMyUuidToDartMyUuid,
      toJson: fromDartMyUuidToGraphQLMyUuid)
  late MyUuid b;

  @JsonKey(
      fromJson: fromGraphQLListMyUuidToDartListMyUuid,
      toJson: fromDartListMyUuidToGraphQLListMyUuid)
  late List<MyUuid> c;

  @JsonKey(
      fromJson:
          fromGraphQLListNullableMyUuidNullableToDartListNullableMyUuidNullable,
      toJson:
          fromDartListNullableMyUuidNullableToGraphQLListNullableMyUuidNullable)
  List<MyUuid?>? d;

  @JsonKey(
      fromJson: fromGraphQLListMyUuidNullableToDartListMyUuidNullable,
      toJson: fromDartListMyUuidNullableToGraphQLListMyUuidNullable)
  late List<MyUuid?> e;

  @JsonKey(
      fromJson: fromGraphQLListNullableMyUuidToDartListNullableMyUuid,
      toJson: fromDartListNullableMyUuidToGraphQLListNullableMyUuid)
  List<MyUuid>? f;

  @override
  List<Object?> get props => [a, b, c, d, e, f];
  @override
  Map<String, dynamic> toJson() => _$Query$SomeObjectToJson(this);
}
''';
