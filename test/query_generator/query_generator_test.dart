import 'package:artemis/builder.dart';
import 'package:artemis/generator/data/data.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import '../helpers.dart';

void main() {
  group('On query generation', () {
    test('When not configured, nothing will be generated', () async {
      final anotherBuilder = graphQLQueryBuilder(BuilderOptions({}));

      await testBuilder(
        anotherBuilder,
        {
          'a|api.schema.graphql': '',
          'a|some_query.query.graphql': 'query some_query { s, i }',
        },
      );
    });

    test(
        'A simple query yields simple classes',
        () async => testGenerator(
            query: 'query some_query { s, i }',
            schema: r'''
        schema {
          query: SomeObject
        }
  
        type SomeObject {
          s: String
          i: Int
        }
      ''',
            libraryDefinition:
                LibraryDefinition(basename: r'query.graphql', queries: [
              QueryDefinition(
                  name: QueryName(name: r'SomeQuery$_SomeObject'),
                  operationName: r'some_query',
                  classes: [
                    ClassDefinition(
                        name: ClassName(name: r'SomeQuery$_SomeObject'),
                        properties: [
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r's'),
                              isResolveType: false),
                          ClassProperty(
                              type: TypeName(name: r'int'),
                              name: ClassPropertyName(name: r'i'),
                              isResolveType: false)
                        ],
                        factoryPossibilities: {},
                        typeNameField: ClassPropertyName(name: r'__typename'),
                        isInput: false)
                  ],
                  generateHelpers: false,
                  suffix: r'Query')
            ]),
            generatedFile: r'''// GENERATED CODE - DO NOT MODIFY BY HAND
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

  String? s;

  int? i;

  @override
  List<Object?> get props => [s, i];
  Map<String, dynamic> toJson() => _$SomeQuery$SomeObjectToJson(this);
}
''',
            generateHelpers: false));

    test(
        'The selection from query can nest',
        () async => testGenerator(
            query: r'''
            query some_query {
          s
          o {
            st
            ob {
              str
            }
          }
        }
            ''',
            schema: r'''
            schema {
              query: Result
            }

            type Result {
              s: String
              o: SomeObject
            }

            type SomeObject {
              st: String
              ob: [AnotherObject]
            }

            type AnotherObject {
              str: String
            }
      ''',
            libraryDefinition:
                LibraryDefinition(basename: r'query.graphql', queries: [
              QueryDefinition(
                  name: QueryName(name: r'SomeQuery$_Result'),
                  operationName: r'some_query',
                  classes: [
                    ClassDefinition(
                        name: ClassName(
                            name:
                                r'SomeQuery$_Result$_SomeObject$_AnotherObject'),
                        properties: [
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'str'),
                              isResolveType: false)
                        ],
                        factoryPossibilities: {},
                        typeNameField: ClassPropertyName(name: r'__typename'),
                        isInput: false),
                    ClassDefinition(
                        name: ClassName(name: r'SomeQuery$_Result$_SomeObject'),
                        properties: [
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'st'),
                              isResolveType: false),
                          ClassProperty(
                              type: ListOfTypeName(
                                  typeName: TypeName(
                                      name:
                                          r'SomeQuery$_Result$_SomeObject$_AnotherObject'),
                                  isNonNull: false),
                              name: ClassPropertyName(name: r'ob'),
                              isResolveType: false)
                        ],
                        factoryPossibilities: {},
                        typeNameField: ClassPropertyName(name: r'__typename'),
                        isInput: false),
                    ClassDefinition(
                        name: ClassName(name: r'SomeQuery$_Result'),
                        properties: [
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r's'),
                              isResolveType: false),
                          ClassProperty(
                              type: TypeName(
                                  name: r'SomeQuery$_Result$_SomeObject'),
                              name: ClassPropertyName(name: r'o'),
                              isResolveType: false)
                        ],
                        factoryPossibilities: {},
                        typeNameField: ClassPropertyName(name: r'__typename'),
                        isInput: false)
                  ],
                  generateHelpers: false,
                  suffix: r'Query')
            ]),
            generatedFile: r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery$Result$SomeObject$AnotherObject extends JsonSerializable
    with EquatableMixin {
  SomeQuery$Result$SomeObject$AnotherObject();

  factory SomeQuery$Result$SomeObject$AnotherObject.fromJson(
          Map<String, dynamic> json) =>
      _$SomeQuery$Result$SomeObject$AnotherObjectFromJson(json);

  String? str;

  @override
  List<Object?> get props => [str];
  Map<String, dynamic> toJson() =>
      _$SomeQuery$Result$SomeObject$AnotherObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$Result$SomeObject extends JsonSerializable with EquatableMixin {
  SomeQuery$Result$SomeObject();

  factory SomeQuery$Result$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$Result$SomeObjectFromJson(json);

  String? st;

  List<SomeQuery$Result$SomeObject$AnotherObject?>? ob;

  @override
  List<Object?> get props => [st, ob];
  Map<String, dynamic> toJson() => _$SomeQuery$Result$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$Result extends JsonSerializable with EquatableMixin {
  SomeQuery$Result();

  factory SomeQuery$Result.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$ResultFromJson(json);

  String? s;

  SomeQuery$Result$SomeObject? o;

  @override
  List<Object?> get props => [s, o];
  Map<String, dynamic> toJson() => _$SomeQuery$ResultToJson(this);
}
''',
            generateHelpers: false));
  });
}
