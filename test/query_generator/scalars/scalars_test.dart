// @dart = 2.8

import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On scalars', () {
    group('All default GraphQL scalars are parsed correctly', () {
      test(
        'If they are defined on schema',
        () async => testGenerator(
          schema: r'''
            scalar Int
            scalar Float
            scalar String
            scalar Boolean
            scalar ID
            
            schema {
              query: SomeObject
            }
            
            type SomeObject {
              i: Int
              f: Float
              s: String
              b: Boolean
              id: ID
            }
          ''',
          query: 'query some_query { i, f, s, b, id }',
          libraryDefinition: libraryDefinition,
          generatedFile: generatedFile,
        ),
      );

      test(
        'All default GraphQL scalars are parsed correctly even if they are NOT explicitly defined on schema',
        () async => testGenerator(
          schema: r'''
            schema {
              query: SomeObject
            }
            
            type SomeObject {
              i: Int
              f: Float
              s: String
              b: Boolean
              id: ID
            }
          ''',
          query: query,
          libraryDefinition: libraryDefinition,
          generatedFile: generatedFile,
        ),
      );
    });
  });
}

final String query = 'query some_query { i, f, s, b, id }';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'SomeQuery$_SomeObject'),
      operationName: r'some_query',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$_SomeObject'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'int'),
                  name: ClassPropertyName(name: r'i'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'double'),
                  name: ClassPropertyName(name: r'f'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r's'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'bool'),
                  name: ClassPropertyName(name: r'b'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'id'),
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
class SomeQuery$SomeObject extends JsonSerializable with EquatableMixin {
  SomeQuery$SomeObject();

  factory SomeQuery$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$SomeObjectFromJson(json);

  int? i;

  double? f;

  String? s;

  bool? b;

  String? id;

  @override
  List<Object?> get props => [i, f, s, b, id];
  Map<String, dynamic> toJson() => _$SomeQuery$SomeObjectToJson(this);
}
''';
