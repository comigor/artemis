// @dart = 2.8

import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On AST schema', () {
    test(
      'When schema declaration is missing',
      () async => testGenerator(
        query: query,
        schema: r'''
          type Query {
            a: String
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
      ),
    );
  });
}

const query = r'''
query {
  a
}
''';

final LibraryDefinition libraryDefinition = LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'Query$_Query'),
      operationName: r'query',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'Query$_Query'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'a'),
                  isNonNull: false,
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

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Query$Query extends JsonSerializable with EquatableMixin {
  Query$Query();

  factory Query$Query.fromJson(Map<String, dynamic> json) =>
      _$Query$QueryFromJson(json);

  String a;

  @override
  List<Object?> get props => [a];
  Map<String, dynamic> toJson() => _$Query$QueryToJson(this);
}
''';
