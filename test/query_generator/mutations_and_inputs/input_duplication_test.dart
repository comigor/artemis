import 'package:artemis/generator/data/data.dart';
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
      name: QueryName(name: r'Custom$_Mutation'),
      operationName: r'custom',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'Custom$_Mutation$_mut'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r's'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Custom$_Mutation'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'Custom$_Mutation$_mut'),
                  name: ClassPropertyName(name: r'mut'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Input'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r's'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: true)
      ],
      inputs: [
        QueryInput(
            type: TypeName(name: r'Input', isNonNull: true),
            name: QueryInputName(name: r'input'))
      ],
      generateHelpers: true,
      suffix: r'Mutation'),
  QueryDefinition(
      name: QueryName(name: r'CustomList$_Mutation'),
      operationName: r'customList',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'CustomList$_Mutation$_mutList'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r's'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'CustomList$_Mutation'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'CustomList$_Mutation$_mutList'),
                  name: ClassPropertyName(name: r'mutList'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Input'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r's'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: true)
      ],
      inputs: [
        QueryInput(
            type: ListOfTypeName(
                typeName: TypeName(name: r'Input', isNonNull: true),
                isNonNull: true),
            name: QueryInputName(name: r'input'))
      ],
      generateHelpers: true,
      suffix: r'Mutation')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$Mutation$Mut extends JsonSerializable with EquatableMixin {
  Custom$Mutation$Mut();

  factory Custom$Mutation$Mut.fromJson(Map<String, dynamic> json) =>
      _$Custom$Mutation$MutFromJson(json);

  String? s;

  @override
  List<Object?> get props => [s];
  @override
  Map<String, dynamic> toJson() => _$Custom$Mutation$MutToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$Mutation extends JsonSerializable with EquatableMixin {
  Custom$Mutation();

  factory Custom$Mutation.fromJson(Map<String, dynamic> json) =>
      _$Custom$MutationFromJson(json);

  Custom$Mutation$Mut? mut;

  @override
  List<Object?> get props => [mut];
  @override
  Map<String, dynamic> toJson() => _$Custom$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Input extends JsonSerializable with EquatableMixin {
  Input({required this.s});

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);

  late String s;

  @override
  List<Object?> get props => [s];
  @override
  Map<String, dynamic> toJson() => _$InputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CustomList$Mutation$MutList extends JsonSerializable with EquatableMixin {
  CustomList$Mutation$MutList();

  factory CustomList$Mutation$MutList.fromJson(Map<String, dynamic> json) =>
      _$CustomList$Mutation$MutListFromJson(json);

  String? s;

  @override
  List<Object?> get props => [s];
  @override
  Map<String, dynamic> toJson() => _$CustomList$Mutation$MutListToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CustomList$Mutation extends JsonSerializable with EquatableMixin {
  CustomList$Mutation();

  factory CustomList$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CustomList$MutationFromJson(json);

  CustomList$Mutation$MutList? mutList;

  @override
  List<Object?> get props => [mutList];
  @override
  Map<String, dynamic> toJson() => _$CustomList$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CustomArguments extends JsonSerializable with EquatableMixin {
  CustomArguments({required this.input});

  @override
  factory CustomArguments.fromJson(Map<String, dynamic> json) =>
      _$CustomArgumentsFromJson(json);

  late Input input;

  @override
  List<Object?> get props => [input];
  @override
  Map<String, dynamic> toJson() => _$CustomArgumentsToJson(this);
}

final CUSTOM_MUTATION_DOCUMENT_OPERATION_NAME = 'custom';
final CUSTOM_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'custom'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'input')),
            type:
                NamedTypeNode(name: NameNode(value: 'Input'), isNonNull: true),
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

class CustomMutation extends GraphQLQuery<Custom$Mutation, CustomArguments> {
  CustomMutation({required this.variables});

  @override
  final DocumentNode document = CUSTOM_MUTATION_DOCUMENT;

  @override
  final String operationName = CUSTOM_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final CustomArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  Custom$Mutation parse(Map<String, dynamic> json) =>
      Custom$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CustomListArguments extends JsonSerializable with EquatableMixin {
  CustomListArguments({required this.input});

  @override
  factory CustomListArguments.fromJson(Map<String, dynamic> json) =>
      _$CustomListArgumentsFromJson(json);

  late List<Input> input;

  @override
  List<Object?> get props => [input];
  @override
  Map<String, dynamic> toJson() => _$CustomListArgumentsToJson(this);
}

final CUSTOM_LIST_MUTATION_DOCUMENT_OPERATION_NAME = 'customList';
final CUSTOM_LIST_MUTATION_DOCUMENT = DocumentNode(definitions: [
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

class CustomListMutation
    extends GraphQLQuery<CustomList$Mutation, CustomListArguments> {
  CustomListMutation({required this.variables});

  @override
  final DocumentNode document = CUSTOM_LIST_MUTATION_DOCUMENT;

  @override
  final String operationName = CUSTOM_LIST_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final CustomListArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CustomList$Mutation parse(Map<String, dynamic> json) =>
      CustomList$Mutation.fromJson(json);
}
''';
