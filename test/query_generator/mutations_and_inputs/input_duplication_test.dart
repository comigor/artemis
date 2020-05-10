import 'package:artemis/generator/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('Input duplication', () {
    test(
      'The input objects should not duplicate',
      () async => testGenerator(
        query: query,
        namingScheme: 'pathedWithFields',
        schema: r'''
          schema {
            mutation: Mutation
          }

          type Mutation {
            mut(input: Input!): MutationResponse
            mutList(input: [Input!]!): MutationResponse
          }

          type MutationResponse {
            s: String
          }

          input Input {
            s: String!
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        generatedCanonicalFile: generatedCanonicalFile,
        sourceAssetsMap: {
          'a|queries/another_query.graphql': anotherQuery,
        },
        generateHelpers: true,
      ),
    );
  });
}

const query = r'''
mutation custom($input: Input!) {
  mut(input: $input) {
    s
  }
}
''';

const anotherQuery = r'''
mutation customList($input: [Input!]!) {
  mutList(input: $input) {
    s
  }
}
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      queryName: r'custom',
      queryType: r'Custom$Mutation',
      classes: [
        ClassDefinition(
            name: r'Custom$Mutation$Mut',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r's',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'Custom$Mutation',
            properties: [
              ClassProperty(
                  type: r'Custom$Mutation$Mut',
                  name: r'mut',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'Input',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r's',
                  isOverride: false,
                  isNonNull: true,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: true)
      ],
      inputs: [QueryInput(type: r'Input', name: r'input', isNonNull: true)],
      generateHelpers: true,
      suffix: r'Mutation'),
  QueryDefinition(
      queryName: r'customList',
      queryType: r'CustomList$Mutation',
      classes: [
        ClassDefinition(
            name: r'CustomList$Mutation$MutList',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r's',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'CustomList$Mutation',
            properties: [
              ClassProperty(
                  type: r'CustomList$Mutation$MutList',
                  name: r'mutList',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'Input',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r's',
                  isOverride: false,
                  isNonNull: true,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: true)
      ],
      inputs: [
        QueryInput(type: r'List<Input>', name: r'input', isNonNull: true)
      ],
      generateHelpers: true,
      suffix: r'Mutation')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'canonical.graphql.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$Mutation$Mut with EquatableMixin {
  Custom$Mutation$Mut();

  factory Custom$Mutation$Mut.fromJson(Map<String, dynamic> json) =>
      _$Custom$Mutation$MutFromJson(json);

  String s;

  @override
  List<Object> get props => [s];
  Map<String, dynamic> toJson() => _$Custom$Mutation$MutToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$Mutation with EquatableMixin {
  Custom$Mutation();

  factory Custom$Mutation.fromJson(Map<String, dynamic> json) =>
      _$Custom$MutationFromJson(json);

  Custom$Mutation$Mut mut;

  @override
  List<Object> get props => [mut];
  Map<String, dynamic> toJson() => _$Custom$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CustomArguments extends JsonSerializable with EquatableMixin {
  CustomArguments({@required this.input});

  factory CustomArguments.fromJson(Map<String, dynamic> json) =>
      _$CustomArgumentsFromJson(json);

  final Input input;

  @override
  List<Object> get props => [input];
  Map<String, dynamic> toJson() => _$CustomArgumentsToJson(this);
}

class CustomMutation extends GraphQLQuery<Custom$Mutation, CustomArguments> {
  CustomMutation({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'custom'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'input')),
              type: NamedTypeNode(
                  name: NameNode(value: 'Input'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'mut'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'input'),
                    value: VariableNode(name: NameNode(value: 'input')))
              ],
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
  final CustomArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  Custom$Mutation parse(Map<String, dynamic> json) =>
      Custom$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CustomList$Mutation$MutList with EquatableMixin {
  CustomList$Mutation$MutList();

  factory CustomList$Mutation$MutList.fromJson(Map<String, dynamic> json) =>
      _$CustomList$Mutation$MutListFromJson(json);

  String s;

  @override
  List<Object> get props => [s];
  Map<String, dynamic> toJson() => _$CustomList$Mutation$MutListToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CustomList$Mutation with EquatableMixin {
  CustomList$Mutation();

  factory CustomList$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CustomList$MutationFromJson(json);

  CustomList$Mutation$MutList mutList;

  @override
  List<Object> get props => [mutList];
  Map<String, dynamic> toJson() => _$CustomList$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CustomListArguments extends JsonSerializable with EquatableMixin {
  CustomListArguments({@required this.input});

  factory CustomListArguments.fromJson(Map<String, dynamic> json) =>
      _$CustomListArgumentsFromJson(json);

  final List<Input> input;

  @override
  List<Object> get props => [input];
  Map<String, dynamic> toJson() => _$CustomListArgumentsToJson(this);
}

class CustomListMutation
    extends GraphQLQuery<CustomList$Mutation, CustomListArguments> {
  CustomListMutation({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'customList'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'input')),
              type: ListTypeNode(
                  type: NamedTypeNode(
                      name: NameNode(value: 'Input'), isNonNull: true),
                  isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'mutList'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'input'),
                    value: VariableNode(name: NameNode(value: 'input')))
              ],
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
  final String operationName = 'customList';

  @override
  final CustomListArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  CustomList$Mutation parse(Map<String, dynamic> json) =>
      CustomList$Mutation.fromJson(json);
}
''';

String generatedCanonicalFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

@JsonSerializable(explicitToJson: true)
class Input with EquatableMixin {
  Input({@required this.s});

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);

  String s;

  @override
  List<Object> get props => [s];
  Map<String, dynamic> toJson() => _$InputToJson(this);
}
''';
