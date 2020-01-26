import 'package:artemis/generator/data.dart';
import 'package:artemis/schema/graphql.dart';
import 'package:test/test.dart';

import '../helpers.dart';

void main() {
  group('On fragments', () {
    testGenerator(
      description: 'Fragments will have their own classes',
      query:
          'fragment myFragment on SomeObject { s, i }\nquery some_query { ...myFragment }',
      libraryDefinition: libraryDefinition,
      generatedFile: generatedFile,
      typedSchema: schema,
    );
  });
}

final schema = GraphQLSchema(
    queryType: GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT),
    types: [
      GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
      GraphQLType(name: 'Int', kind: GraphQLTypeKind.SCALAR),
      GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT, fields: [
        GraphQLField(
            name: 's',
            type: GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR)),
        GraphQLField(
            name: 'i',
            type: GraphQLType(name: 'Int', kind: GraphQLTypeKind.SCALAR)),
      ]),
    ]);

final libraryDefinition = LibraryDefinition(basename: r'query', queries: [
  QueryDefinition(
      queryName: r'some_query',
      queryType: r'SomeObject',
      classes: [
        FragmentClassDefinition(name: r'MyFragmentMixin', properties: [
          ClassProperty(type: r'String', name: r's', isOverride: false),
          ClassProperty(type: r'int', name: r'i', isOverride: false)
        ]),
        ClassDefinition(
            name: r'SomeObject',
            mixins: [r'MyFragmentMixin'],
            resolveTypeField: r'__resolveType')
      ],
      generateHelpers: false)
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.g.dart';

mixin MyFragmentMixin {
  String s;
  int i;
}

@JsonSerializable(explicitToJson: true)
class SomeObject with EquatableMixin, MyFragmentMixin {
  SomeObject();

  factory SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeObjectFromJson(json);

  @override
  List<Object> get props => [s, i];
  Map<String, dynamic> toJson() => _$SomeObjectToJson(this);
}
''';
