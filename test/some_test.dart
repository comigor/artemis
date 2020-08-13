// @dart = 2.8

import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  group('On treatAsCanonical', () {
    test(
      'We can pass a glob in which matched classes will be treated as canonical classes',
      () async => testGenerator(
        query: query,
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
//        schemaMappingMap: {
//          'treat_as_canonical_glob': 'LocalizedText',
//        },
        schema: r'''
          type Query {
            q: QueryResponse!
          }
          
          type QueryResponse {
            text1: LocalizedText!
            text2: [LocalizedText!]!
            secondLevel: SecondLevel!
          }

          type SecondLevel {
            text3: LocalizedText!
          }

          type LocalizedText {
            text: String!
            secondary: [String!]
            locale: Locale!
          }

          type Locale {
            entry: String!
          }
          ''',
      ),
    );
  });
}

const query = r'''
query custom {
  q {
    text1 { text locale { entry } }
    text2 { text locale { entry } }
    secondLevel {
      text3 { text locale { entry } }
    }
  }
}
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'Custom$_Query'),
      operationName: r'custom',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'Custom$_Query$_QueryResponse$_SecondLevel'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'LocalizedText'),
                  name: ClassPropertyName(name: r'text3'),
                  isNonNull: true,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Custom$_Query$_QueryResponse'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'LocalizedText'),
                  name: ClassPropertyName(name: r'text1'),
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'List<LocalizedText>'),
                  name: ClassPropertyName(name: r'text2'),
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(
                      name: r'Custom$_Query$_QueryResponse$_SecondLevel'),
                  name: ClassPropertyName(name: r'secondLevel'),
                  isNonNull: true,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Custom$_Query'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'Custom$_Query$_QueryResponse'),
                  name: ClassPropertyName(name: r'q'),
                  isNonNull: true,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Locale'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'entry'),
                  isNonNull: true,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'LocalizedText'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'text'),
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'List<String>'),
                  name: ClassPropertyName(name: r'secondary'),
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'Locale'),
                  name: ClassPropertyName(name: r'locale'),
                  isNonNull: true,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false)
      ],
      generateHelpers: false,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$Query$QueryResponse$SecondLevel with EquatableMixin {
  Custom$Query$QueryResponse$SecondLevel();

  factory Custom$Query$QueryResponse$SecondLevel.fromJson(
          Map<String, dynamic> json) =>
      _$Custom$Query$QueryResponse$SecondLevelFromJson(json);

  LocalizedText text3;

  @override
  List<Object> get props => [text3];
  Map<String, dynamic> toJson() =>
      _$Custom$Query$QueryResponse$SecondLevelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$Query$QueryResponse with EquatableMixin {
  Custom$Query$QueryResponse();

  factory Custom$Query$QueryResponse.fromJson(Map<String, dynamic> json) =>
      _$Custom$Query$QueryResponseFromJson(json);

  LocalizedText text1;

  List<LocalizedText> text2;

  Custom$Query$QueryResponse$SecondLevel secondLevel;

  @override
  List<Object> get props => [text1, text2, secondLevel];
  Map<String, dynamic> toJson() => _$Custom$Query$QueryResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$Query with EquatableMixin {
  Custom$Query();

  factory Custom$Query.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryFromJson(json);

  Custom$Query$QueryResponse q;

  @override
  List<Object> get props => [q];
  Map<String, dynamic> toJson() => _$Custom$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Locale with EquatableMixin {
  Locale();

  factory Locale.fromJson(Map<String, dynamic> json) => _$LocaleFromJson(json);

  String entry;

  @override
  List<Object> get props => [entry];
  Map<String, dynamic> toJson() => _$LocaleToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LocalizedText with EquatableMixin {
  LocalizedText();

  factory LocalizedText.fromJson(Map<String, dynamic> json) =>
      _$LocalizedTextFromJson(json);

  String text;

  List<String> secondary;

  Locale locale;

  @override
  List<Object> get props => [text, secondary, locale];
  Map<String, dynamic> toJson() => _$LocalizedTextToJson(this);
}
''';
