import 'package:artemis/generator/data.dart';
import 'package:test/test.dart';

import '../helpers.dart';

void main() {
  group('On forwarder', () {
    test(
      'Forwarder are created if output file does not end with .graphql.dart',
      () async => testGenerator(
        query: query,
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        schema: r'''
          schema {
            query: QueryRoot
          }

          type QueryRoot {
            a: String
          }''',
        builderOptionsMap: {
          'schema_mapping': [
            {
              'schema': 'api.schema.graphql',
              'queries_glob': 'queries/**.graphql',
              'output': 'lib/query.dart',
            }
          ],
        },
        outputsMap: {
          'a|lib/query.graphql.dart': generatedFile,
          'a|lib/query.dart': r'''// GENERATED CODE - DO NOT MODIFY BY HAND
export 'query.graphql.dart';
''',
        },
      ),
    );
  });
}

const query = r'''
query custom {
  a
}
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      queryName: r'custom',
      queryType: r'Custom$QueryRoot',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'Custom$QueryRoot'),
            properties: [
              ClassProperty(
                  type: r'String',
                  name: VariableName(name: r'a'),
                  isNonNull: false,
                  isResolveType: false)
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
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot with EquatableMixin {
  Custom$QueryRoot();

  factory Custom$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRootFromJson(json);

  String a;

  @override
  List<Object> get props => [a];
  Map<String, dynamic> toJson() => _$Custom$QueryRootToJson(this);
}
''';
