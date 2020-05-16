import 'package:artemis/generator/data.dart';
import 'package:gql/language.dart';
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
        'If they are NOT explicitly defined on schema',
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
    document: parseString(query),
    queryName: r'some_query',
    queryType: r'SomeQuery$SomeObject',
    classes: [
      ClassDefinition(
          name: TempName(name: r'SomeQuery$SomeObject'),
          properties: [
            ClassProperty(type: 'int', name: TempName(name: 'i')),
            ClassProperty(type: 'double', name: TempName(name: 'f')),
            ClassProperty(type: 'String', name: TempName(name: 's')),
            ClassProperty(type: 'bool', name: TempName(name: 'b')),
            ClassProperty(type: 'String', name: TempName(name: 'id')),
          ]),
    ],
  )
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery$SomeObject with EquatableMixin {
  SomeQuery$SomeObject();

  factory SomeQuery$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$SomeObjectFromJson(json);

  int i;

  double f;

  String s;

  bool b;

  String id;

  @override
  List<Object> get props => [i, f, s, b, id];
  Map<String, dynamic> toJson() => _$SomeQuery$SomeObjectToJson(this);
}
''';
