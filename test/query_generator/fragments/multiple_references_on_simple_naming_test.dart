import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

// While we don't have canonical classes generation, we can leverage class
// deduplication on fragments expansion and use the generated fragment mixin
// as "canonical data" when the fragment is the only selection of the field.
// Example:
// someObject {
//   ...myFragment
// }
void main() {
  test(
    'On multiple reference of same fragment on simple naming',
    () async => testGenerator(
      query: r'''
          fragment myFragment on SomeObject {
            s, i
          }

          query some_query {
            someObject {
              ...myFragment
            }
            moreData {
              someObject {
                ...myFragment
              }
            }
          }
        ''',
      schema: r'''
         schema {
            query: QueryResponse
          }

          type QueryResponse {
            someObject: SomeObject
            moreData: MoreData
          }

          type MoreData {
            someObject: SomeObject
          }

          type SomeObject {
            s: String
            i: Int
          }
        ''',
      libraryDefinition: libraryDefinition,
      generatedFile: generatedFile,
      namingScheme: 'simple',
    ),
  );
}

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'SomeQuery$_QueryResponse'),
      operationName: r'some_query',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'SomeObject'),
            mixins: [FragmentName(name: r'MyFragmentMixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'SomeObject'),
            mixins: [FragmentName(name: r'MyFragmentMixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'MoreData'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'SomeObject'),
                  name: ClassPropertyName(name: r'someObject'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$_QueryResponse'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'SomeObject'),
                  name: ClassPropertyName(name: r'someObject'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'MoreData'),
                  name: ClassPropertyName(name: r'moreData'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        FragmentClassDefinition(
            name: FragmentName(name: r'MyFragmentMixin'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r's'),
                  isResolveType: false),
              ClassProperty(
                  type: DartTypeName(name: r'int'),
                  name: ClassPropertyName(name: r'i'),
                  isResolveType: false)
            ])
      ],
      generateHelpers: false,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

mixin MyFragmentMixin {
  String? s;
  int? i;
}

@JsonSerializable(explicitToJson: true)
class SomeObject extends JsonSerializable with EquatableMixin, MyFragmentMixin {
  SomeObject();

  factory SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeObjectFromJson(json);

  @override
  List<Object?> get props => [s, i];
  @override
  Map<String, dynamic> toJson() => _$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MoreData extends JsonSerializable with EquatableMixin {
  MoreData();

  factory MoreData.fromJson(Map<String, dynamic> json) =>
      _$MoreDataFromJson(json);

  SomeObject? someObject;

  @override
  List<Object?> get props => [someObject];
  @override
  Map<String, dynamic> toJson() => _$MoreDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$QueryResponse extends JsonSerializable with EquatableMixin {
  SomeQuery$QueryResponse();

  factory SomeQuery$QueryResponse.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$QueryResponseFromJson(json);

  SomeObject? someObject;

  MoreData? moreData;

  @override
  List<Object?> get props => [someObject, moreData];
  @override
  Map<String, dynamic> toJson() => _$SomeQuery$QueryResponseToJson(this);
}
''';
