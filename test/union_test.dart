import 'dart:convert';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'package:artemis/schema/graphql.dart';
import 'package:artemis/generator.dart';

String jsonFromSchema(GraphQLSchema schema) => json.encode({
      'data': {'__schema': schema.toJson()}
    });

void main() {
  group('On union types', () {
    final builder = graphQLTypesBuilder(BuilderOptions({}));

    test(
        'A union type must have no properties but __resolveType and its children must extend it',
        () async {
      final GraphQLSchema schema = GraphQLSchema(types: [
        GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
        GraphQLType(name: 'Book', kind: GraphQLTypeKind.OBJECT, fields: [
          GraphQLField(name: 'title', type: GraphQLType(name: 'String'))
        ]),
        GraphQLType(name: 'Author', kind: GraphQLTypeKind.OBJECT, fields: [
          GraphQLField(name: 'name', type: GraphQLType(name: 'String'))
        ]),
        GraphQLType(
            name: 'Result',
            kind: GraphQLTypeKind.UNION,
            possibleTypes: [
              GraphQLType(name: 'Book'),
              GraphQLType(name: 'Author'),
            ]),
      ]);

      await testBuilder(builder, {
        'a|api.schema.json': jsonFromSchema(schema),
      }, outputs: {
        'a|api.api.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'api.api.g.dart';

@JsonSerializable()
class Book extends Result {
  String title;

  Book();

  factory Book.fromJson(Map<String, dynamic> json) => _\$BookFromJson(json);
  Map<String, dynamic> toJson() => _\$BookToJson(this);
}

@JsonSerializable()
class Author extends Result {
  String name;

  Author();

  factory Author.fromJson(Map<String, dynamic> json) => _\$AuthorFromJson(json);
  Map<String, dynamic> toJson() => _\$AuthorToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: \'__resolveType\')
  String resolveType;

  Result();

  factory Result.fromJson(Map<String, dynamic> json) {
    switch (resolveType) {
      case 'Book':
        return _\$BookFromJson(json);
      case 'Author':
        return _\$AuthorFromJson(json);
      default:
    }
    return _\$ResultFromJson(json);
  }
  Map<String, dynamic> toJson() {
    switch (resolveType) {
      case 'Book':
        return _\$BookToJson(this as Book);
      case 'Author':
        return _\$AuthorToJson(this as Author);
      default:
    }
    return _\$ResultToJson(this);
  }
}
''',
      });
    });
  });
}
