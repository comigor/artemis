import 'package:artemis/builder.dart';
import 'package:artemis/generator/data.dart';
import 'package:artemis/schema/graphql.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import '../helpers.dart';

void main() {
  test('On complex input objects', () async {
    final GraphQLQueryBuilder anotherBuilder =
        graphQLQueryBuilder(BuilderOptions({
      'generate_helpers': false,
      'schema_mapping': [
        {
          'schema': 'api.schema.json',
          'queries_glob': '**.graphql',
          'output': 'lib/some_query.dart',
        }
      ]
    }));
    final GraphQLSchema schema = GraphQLSchema(
      queryType: GraphQLType(name: 'QueryRoot', kind: GraphQLTypeKind.OBJECT),
      types: [
        GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
        GraphQLType(name: 'MyEnum', kind: GraphQLTypeKind.ENUM, enumValues: [
          GraphQLEnumValue(name: 'value1'),
          GraphQLEnumValue(name: 'value2'),
        ]),
        GraphQLType(
            name: 'ComplexType',
            kind: GraphQLTypeKind.INPUT_OBJECT,
            inputFields: [
              GraphQLInputValue(
                  name: 's',
                  type: GraphQLType(
                      name: 'String', kind: GraphQLTypeKind.SCALAR)),
              GraphQLInputValue(
                  name: 'e',
                  type:
                      GraphQLType(name: 'MyEnum', kind: GraphQLTypeKind.ENUM)),
              GraphQLInputValue(
                  name: 'ls',
                  type: GraphQLType(
                      kind: GraphQLTypeKind.LIST,
                      ofType: GraphQLType(
                          name: 'String', kind: GraphQLTypeKind.SCALAR))),
            ]),
        GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT, fields: [
          GraphQLField(
              name: 's',
              type: GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR)),
        ]),
        GraphQLType(name: 'QueryRoot', kind: GraphQLTypeKind.OBJECT, fields: [
          GraphQLField(
              name: 'o',
              type: GraphQLType(
                  name: 'SomeObject', kind: GraphQLTypeKind.OBJECT)),
        ]),
      ],
    );

    anotherBuilder.onBuild = expectAsync1((definition) {
      final libraryDefinition =
          LibraryDefinition(basename: r'some_query', queries: [
        QueryDefinition(
            queryName: r'some_query',
            queryType: r'QueryRoot',
            classes: [
              ClassDefinition(
                  name: r'QueryRoot$SomeObject',
                  properties: [
                    ClassProperty(
                        type: r'String', name: r's', isOverride: false)
                  ],
                  resolveTypeField: r'__resolveType'),
              ClassDefinition(
                  name: r'QueryRoot',
                  properties: [
                    ClassProperty(
                        type: r'QueryRoot$SomeObject',
                        name: r'o',
                        isOverride: false)
                  ],
                  resolveTypeField: r'__resolveType'),
              EnumDefinition(name: r'MyEnum', values: [r'value1', r'value2']),
              ClassDefinition(
                  name: r'ComplexType',
                  properties: [
                    ClassProperty(
                        type: r'String', name: r's', isOverride: false),
                    ClassProperty(
                        type: r'MyEnum', name: r'e', isOverride: false),
                    ClassProperty(
                        type: r'List<String>', name: r'ls', isOverride: false)
                  ],
                  resolveTypeField: r'__resolveType')
            ],
            inputs: [QueryInput(type: r'ComplexType', name: r'filter')],
            generateHelpers: false)
      ]);

      expect(definition, libraryDefinition);
    }, count: 1);

    await testBuilder(
      anotherBuilder,
      {
        'a|api.schema.json': jsonFromSchema(schema),
        'a|some_query.query.graphql':
            'query some_query(\$filter: ComplexType!) { o(filter: \$filter) { s } }',
      },
      outputs: {
        'a|lib/some_query.dart': r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'some_query.g.dart';

@JsonSerializable(explicitToJson: true)
class QueryRoot$SomeObject with EquatableMixin {
  QueryRoot$SomeObject();

  factory QueryRoot$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$QueryRoot$SomeObjectFromJson(json);

  String s;

  @override
  List<Object> get props => [s];
  Map<String, dynamic> toJson() => _$QueryRoot$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class QueryRoot with EquatableMixin {
  QueryRoot();

  factory QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$QueryRootFromJson(json);

  QueryRoot$SomeObject o;

  @override
  List<Object> get props => [o];
  Map<String, dynamic> toJson() => _$QueryRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ComplexType with EquatableMixin {
  ComplexType();

  factory ComplexType.fromJson(Map<String, dynamic> json) =>
      _$ComplexTypeFromJson(json);

  String s;

  MyEnum e;

  List<String> ls;

  @override
  List<Object> get props => [s, e, ls];
  Map<String, dynamic> toJson() => _$ComplexTypeToJson(this);
}

enum MyEnum {
  value1,
  value2,
}

@JsonSerializable(explicitToJson: true)
class SomeQueryArguments extends JsonSerializable with EquatableMixin {
  SomeQueryArguments({this.filter});

  factory SomeQueryArguments.fromJson(Map<String, dynamic> json) =>
      _$SomeQueryArgumentsFromJson(json);

  final ComplexType filter;

  @override
  List<Object> get props => [filter];
  Map<String, dynamic> toJson() => _$SomeQueryArgumentsToJson(this);
}
''',
      },
      onLog: debug,
    );
  });
}
