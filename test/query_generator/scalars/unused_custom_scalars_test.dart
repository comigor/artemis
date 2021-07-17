import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On unused custom scalars', () {
    test(
      'They will not throw if not configured and unused',
      () async => testGenerator(
        query: 'query query { a }',
        schema: r'''
            scalar MyUuid
            scalar OtherScalar
            
            schema {
              query: SomeObject
            }
            
            type SomeObject {
              a: MyUuid
              b: OtherScalar
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
                  type: DartTypeName(name: r'String'),
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
