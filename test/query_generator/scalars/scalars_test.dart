import 'package:artemis/generator/data.dart';
import 'package:artemis/schema/graphql.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On scalars', () {
    group('All default GraphQL scalars are parsed correctly', () {
      testGenerator(
        description: 'If they are defined on schema',
        query: 'query query { a, b, c, d, e }',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        typedSchema: schemaWithScalars,
      );

      testGenerator(
        description: 'If they are NOT explicitly defined on schema',
        query: 'query query { a, b, c, d, e }',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        typedSchema: schemaWithoutScalars,
      );
    });
  });
}

final schemaWithScalars = GraphQLSchema(
    queryType: GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT),
    types: [
      GraphQLType(name: 'Int', kind: GraphQLTypeKind.SCALAR),
      GraphQLType(name: 'Float', kind: GraphQLTypeKind.SCALAR),
      GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
      GraphQLType(name: 'Boolean', kind: GraphQLTypeKind.SCALAR),
      GraphQLType(name: 'ID', kind: GraphQLTypeKind.SCALAR),
      GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT, fields: [
        GraphQLField(
          name: 'a',
          type: GraphQLType(name: 'Int', kind: GraphQLTypeKind.SCALAR),
        ),
        GraphQLField(
          name: 'b',
          type: GraphQLType(name: 'Float', kind: GraphQLTypeKind.SCALAR),
        ),
        GraphQLField(
          name: 'c',
          type: GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
        ),
        GraphQLField(
          name: 'd',
          type: GraphQLType(name: 'Boolean', kind: GraphQLTypeKind.SCALAR),
        ),
        GraphQLField(
          name: 'e',
          type: GraphQLType(name: 'ID', kind: GraphQLTypeKind.SCALAR),
        ),
      ]),
    ]);

final schemaWithoutScalars = GraphQLSchema(
    queryType: GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT),
    types: [
      GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT, fields: [
        GraphQLField(
          name: 'a',
          type: GraphQLType(name: 'Int', kind: GraphQLTypeKind.SCALAR),
        ),
        GraphQLField(
          name: 'b',
          type: GraphQLType(name: 'Float', kind: GraphQLTypeKind.SCALAR),
        ),
        GraphQLField(
          name: 'c',
          type: GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
        ),
        GraphQLField(
          name: 'd',
          type: GraphQLType(name: 'Boolean', kind: GraphQLTypeKind.SCALAR),
        ),
        GraphQLField(
          name: 'e',
          type: GraphQLType(name: 'ID', kind: GraphQLTypeKind.SCALAR),
        ),
      ]),
    ]);

final libraryDefinition = LibraryDefinition(basename: r'query', queries: [
  QueryDefinition(
    queryName: r'query',
    queryType: r'Query$SomeObject',
    classes: [
      ClassDefinition(name: r'Query$SomeObject', properties: [
        ClassProperty(type: 'int', name: 'a'),
        ClassProperty(type: 'double', name: 'b'),
        ClassProperty(type: 'String', name: 'c'),
        ClassProperty(type: 'bool', name: 'd'),
        ClassProperty(type: 'String', name: 'e'),
      ]),
    ],
  )
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

  int a;

  double b;

  String c;

  bool d;

  String e;

  @override
  List<Object> get props => [a, b, c, d, e];
  Map<String, dynamic> toJson() => _$Query$SomeObjectToJson(this);
}
''';
