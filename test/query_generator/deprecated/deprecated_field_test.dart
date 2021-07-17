import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On deprecated', () {
    test(
      'Fields can be deprecated',
      () async => testGenerator(
        query: query,
        schema: r'''
          schema {
            query: QueryResponse
          }

          type QueryResponse {
            someObject: SomeObject @deprecated(reason: "message")
            someObjects: [SomeObject]
          }

          type SomeObject {
            someField: String
            deprecatedField: String @deprecated(reason: "message 2")
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
      ),
    );
  });
}

const query = r'''
  query some_query {
    deprecatedObject: someObject {
      someField
      deprecatedField
    }
    someObjects {
      someField
      deprecatedField
    }
  }
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'SomeQuery$_QueryResponse'),
      operationName: r'some_query',
      classes: [
        ClassDefinition(
            name:
                ClassName(name: r'SomeQuery$_QueryResponse$_deprecatedObject'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r'someField'),
                  isResolveType: false),
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r'deprecatedField'),
                  annotations: [r'''Deprecated('message 2')'''],
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$_QueryResponse$_SomeObject'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r'someField'),
                  isResolveType: false),
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r'deprecatedField'),
                  annotations: [r'''Deprecated('message 2')'''],
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$_QueryResponse'),
            properties: [
              ClassProperty(
                  type: TypeName(
                      name: r'SomeQuery$_QueryResponse$_deprecatedObject'),
                  name: ClassPropertyName(name: r'deprecatedObject'),
                  annotations: [r'''Deprecated('message')'''],
                  isResolveType: false),
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: TypeName(
                          name: r'SomeQuery$_QueryResponse$_SomeObject'),
                      isNonNull: false),
                  name: ClassPropertyName(name: r'someObjects'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false)
      ],
      generateHelpers: false,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery$QueryResponse$DeprecatedObject extends JsonSerializable
    with EquatableMixin {
  SomeQuery$QueryResponse$DeprecatedObject();

  factory SomeQuery$QueryResponse$DeprecatedObject.fromJson(
          Map<String, dynamic> json) =>
      _$SomeQuery$QueryResponse$DeprecatedObjectFromJson(json);

  String? someField;

  @Deprecated('message 2')
  String? deprecatedField;

  @override
  List<Object?> get props => [someField, deprecatedField];
  @override
  Map<String, dynamic> toJson() =>
      _$SomeQuery$QueryResponse$DeprecatedObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$QueryResponse$SomeObject extends JsonSerializable
    with EquatableMixin {
  SomeQuery$QueryResponse$SomeObject();

  factory SomeQuery$QueryResponse$SomeObject.fromJson(
          Map<String, dynamic> json) =>
      _$SomeQuery$QueryResponse$SomeObjectFromJson(json);

  String? someField;

  @Deprecated('message 2')
  String? deprecatedField;

  @override
  List<Object?> get props => [someField, deprecatedField];
  @override
  Map<String, dynamic> toJson() =>
      _$SomeQuery$QueryResponse$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$QueryResponse extends JsonSerializable with EquatableMixin {
  SomeQuery$QueryResponse();

  factory SomeQuery$QueryResponse.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$QueryResponseFromJson(json);

  @Deprecated('message')
  SomeQuery$QueryResponse$DeprecatedObject? deprecatedObject;

  List<SomeQuery$QueryResponse$SomeObject?>? someObjects;

  @override
  List<Object?> get props => [deprecatedObject, someObjects];
  @override
  Map<String, dynamic> toJson() => _$SomeQuery$QueryResponseToJson(this);
}
''';
