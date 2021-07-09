import 'package:artemis/generator/data/annotation.dart';
import 'package:artemis/generator/data/data.dart';
import 'package:artemis/generator/data/enum_value_definition.dart';
import 'package:gql/language.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On deprecated value', () {
    test(
      'Enum values can be deprecated',
      () async => testGenerator(
        query: query,
        schema: r'''
          schema {
            query: QueryResponse
          }

          type QueryResponse {
            someValue: StarWarsMovies
          }

          enum StarWarsMovies {
            NEW_HOPE @deprecated(reason: "deprecated movie")
            EMPIRE
            JEDI
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
    someValue
  }
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'SomeQuery$_QueryResponse'),
      operationName: r'some_query',
      classes: [
        EnumDefinition(name: EnumName(name: r'StarWarsMovies'), values: [
          EnumValueDefinition(
              name: EnumValueName(name: r'NEW_HOPE'),
              annotations: [
                StringAnnotation(name: r'''Deprecated('deprecated movie')''')
              ]),
          EnumValueDefinition(name: EnumValueName(name: r'EMPIRE')),
          EnumValueDefinition(name: EnumValueName(name: r'JEDI')),
          EnumValueDefinition(name: EnumValueName(name: r'ARTEMIS_UNKNOWN'))
        ]),
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$_QueryResponse'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'StarWarsMovies'),
                  name: ClassPropertyName(name: r'someValue'),
                  annotations: [
                    JsonKeyAnnotation(
                        jsonKey: JsonKeyItem(
                            unknownEnumValue: r'StarWarsMovies.artemisUnknown'))
                  ],
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
class SomeQuery$QueryResponse extends JsonSerializable with EquatableMixin {
  SomeQuery$QueryResponse();

  factory SomeQuery$QueryResponse.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$QueryResponseFromJson(json);

  @JsonKey(unknownEnumValue: StarWarsMovies.artemisUnknown)
  StarWarsMovies? someValue;

  @override
  List<Object?> get props => [someValue];
  @override
  Map<String, dynamic> toJson() => _$SomeQuery$QueryResponseToJson(this);
}

enum StarWarsMovies {
  @Deprecated('deprecated movie')
  @JsonValue('NEW_HOPE')
  newHope,
  @JsonValue('EMPIRE')
  empire,
  @JsonValue('JEDI')
  jedi,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}
''';
