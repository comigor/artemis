import 'package:artemis/generator/data.dart';
import 'package:artemis/schema/graphql.dart';
import 'package:test/test.dart';

import '../helpers.dart';

void main() {
  group('On mutations', () {
    testGenerator(
      description: 'The mutation class will be suffixed as Mutation',
      query: query,
      libraryDefinition: libraryDefinition,
      generatedFile: generatedFile,
      typedSchema: schema,
      generateHelpers: true,
    );
  });
}

const query = r'''
mutation custom {
  mut {
    s
  }
}
''';

final schema = GraphQLSchema(
    mutationType:
        GraphQLType(name: 'MutationRoot', kind: GraphQLTypeKind.OBJECT),
    types: [
      GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
      GraphQLType(
          name: 'MutationResponse',
          kind: GraphQLTypeKind.OBJECT,
          fields: [
            GraphQLField(
                name: 's',
                type:
                    GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR)),
          ]),
      GraphQLType(name: 'MutationRoot', kind: GraphQLTypeKind.OBJECT, fields: [
        GraphQLField(
            name: 'mut',
            type: GraphQLType(
                name: 'MutationResponse', kind: GraphQLTypeKind.SCALAR)),
      ]),
    ]);

final libraryDefinition = LibraryDefinition(basename: r'query', queries: [
  QueryDefinition(
      queryName: r'custom',
      queryType: r'Custom$MutationRoot',
      classes: [
        ClassDefinition(
            name: r'Custom$MutationRoot$MutationResponse',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r's',
                  isOverride: false,
                  isNonNull: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'Custom$MutationRoot',
            properties: [
              ClassProperty(
                  type: r'MutationResponse',
                  name: r'mut',
                  isOverride: false,
                  isNonNull: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false)
      ],
      generateHelpers: true,
      suffix: r'Mutation')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$MutationRoot$MutationResponse with EquatableMixin {
  Custom$MutationRoot$MutationResponse();

  factory Custom$MutationRoot$MutationResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Custom$MutationRoot$MutationResponseFromJson(json);

  String s;

  @override
  List<Object> get props => [s];
  Map<String, dynamic> toJson() =>
      _$Custom$MutationRoot$MutationResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$MutationRoot with EquatableMixin {
  Custom$MutationRoot();

  factory Custom$MutationRoot.fromJson(Map<String, dynamic> json) =>
      _$Custom$MutationRootFromJson(json);

  MutationResponse mut;

  @override
  List<Object> get props => [mut];
  Map<String, dynamic> toJson() => _$Custom$MutationRootToJson(this);
}

class CustomMutation
    extends GraphQLQuery<Custom$MutationRoot, JsonSerializable> {
  CustomMutation();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'custom'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'mut'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 's'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'custom';

  @override
  List<Object> get props => [document, operationName];
  @override
  Custom$MutationRoot parse(Map<String, dynamic> json) =>
      Custom$MutationRoot.fromJson(json);
}
''';
