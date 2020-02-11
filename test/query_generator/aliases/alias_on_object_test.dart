import 'package:artemis/generator/data.dart';
import 'package:artemis/schema/graphql.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On aliases', () {
    test(
      'Objects can be aliased',
      () async => testGenerator(
        query: query,
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        typedSchema: schema,
      ),
    );
  });
}

const query = r'''
        query some_query {
          s
          o {
            st
          }
          anotherObject: ob {
            str
          }
        }
        ''';

final schema = GraphQLSchema(
    queryType: GraphQLType(name: 'Query', kind: GraphQLTypeKind.OBJECT),
    types: [
      GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
      GraphQLType(name: 'Query', kind: GraphQLTypeKind.OBJECT, fields: [
        GraphQLField(
            name: 's',
            type: GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR)),
        GraphQLField(
            name: 'o',
            type:
                GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT)),
        GraphQLField(
            name: 'ob',
            type: GraphQLType(
                kind: GraphQLTypeKind.LIST,
                ofType: GraphQLType(
                    name: 'SomeObject', kind: GraphQLTypeKind.OBJECT))),
      ]),
      GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT, fields: [
        GraphQLField(
            name: 'st',
            type: GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR)),
        GraphQLField(
            name: 'str',
            type: GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR)),
      ]),
    ]);

final libraryDefinition = LibraryDefinition(basename: r'query', queries: [
  QueryDefinition(
      queryName: r'some_query',
      queryType: r'SomeQuery$Query',
      classes: [
        ClassDefinition(
            name: r'SomeQuery$Query$SomeObject',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r'st',
                  isOverride: false,
                  isNonNull: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'SomeQuery$Query$AnotherObject',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r'str',
                  isOverride: false,
                  isNonNull: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'SomeQuery$Query',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r's',
                  isOverride: false,
                  isNonNull: false),
              ClassProperty(
                  type: r'SomeQuery$Query$SomeObject',
                  name: r'o',
                  isOverride: false,
                  isNonNull: false),
              ClassProperty(
                  type: r'List<SomeQuery$Query$AnotherObject>',
                  name: r'anotherObject',
                  isOverride: false,
                  isNonNull: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false)
      ],
      generateHelpers: false,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery$Query$SomeObject with EquatableMixin {
  SomeQuery$Query$SomeObject();

  factory SomeQuery$Query$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$Query$SomeObjectFromJson(json);

  String st;

  @override
  List<Object> get props => [st];
  Map<String, dynamic> toJson() => _$SomeQuery$Query$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$Query$AnotherObject with EquatableMixin {
  SomeQuery$Query$AnotherObject();

  factory SomeQuery$Query$AnotherObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$Query$AnotherObjectFromJson(json);

  String str;

  @override
  List<Object> get props => [str];
  Map<String, dynamic> toJson() => _$SomeQuery$Query$AnotherObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$Query with EquatableMixin {
  SomeQuery$Query();

  factory SomeQuery$Query.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$QueryFromJson(json);

  String s;

  SomeQuery$Query$SomeObject o;

  List<SomeQuery$Query$AnotherObject> anotherObject;

  @override
  List<Object> get props => [s, o, anotherObject];
  Map<String, dynamic> toJson() => _$SomeQuery$QueryToJson(this);
}
''';
