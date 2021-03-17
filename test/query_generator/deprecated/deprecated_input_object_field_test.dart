// @dart = 2.8

import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On mutations', () {
    test(
      'The mutation class will be suffixed as Mutation',
      () async => testGenerator(
        query: query,
        schema: r'''
          schema {
            mutation: MutationRoot
          }
          
          type MutationRoot {
            mut(input: Input!): MutationResponse
          }
          
          type MutationResponse {
            s: String
          }
          
          input Input {
            s: String!
            d: String @deprecated(reason: "deprecated input field")
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
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

final LibraryDefinition libraryDefinition = LibraryDefinition(
  basename: r'query.graphql',
  queries: [
    QueryDefinition(
      operationName: r'custom',
      name: QueryName(name: r'Custom$_MutationRoot'),
      classes: [
        ClassDefinition(
          name: ClassName(name: r'Custom$_MutationRoot$_MutationResponse'),
          properties: [
            ClassProperty(
              type: TypeName(name: r'String'),
              name: ClassPropertyName(name: r's'),
            ),
          ],
          factoryPossibilities: {},
          typeNameField: ClassPropertyName(name: r'__typename'),
          isInput: false,
        ),
        ClassDefinition(
          name: ClassName(name: r'Custom$_MutationRoot'),
          properties: [
            ClassProperty(
              type: TypeName(name: r'Custom$_MutationRoot$_MutationResponse'),
              name: ClassPropertyName(name: r'mut'),
            ),
          ],
          factoryPossibilities: {},
          typeNameField: ClassPropertyName(name: r'__typename'),
          isInput: false,
        ),
        ClassDefinition(
          name: ClassName(name: r'Input'),
          properties: [
            ClassProperty(
              type: TypeName(name: r'String'),
              name: ClassPropertyName(name: r's'),
            ),
            ClassProperty(
              type: TypeName(name: r'String'),
              name: ClassPropertyName(name: r'd'),
              annotations: [
                r"Deprecated('deprecated input field')",
              ],
            ),
          ],
          factoryPossibilities: {},
          typeNameField: ClassPropertyName(name: r'__typename'),
          isInput: true,
        ),
      ],
      inputs: [
        QueryInput(
          type: TypeName(name: r'Input'),
          name: QueryInputName(name: r'input'),
        ),
      ],
      generateHelpers: true,
      suffix: r'Mutation',
    ),
  ],
);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$MutationRoot$MutationResponse extends JsonSerializable
    with EquatableMixin {
  Custom$MutationRoot$MutationResponse();

  factory Custom$MutationRoot$MutationResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Custom$MutationRoot$MutationResponseFromJson(json);

  String s;

  @override
  List<Object?> get props => [s];
  Map<String, dynamic> toJson() =>
      _$Custom$MutationRoot$MutationResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$MutationRoot extends JsonSerializable with EquatableMixin {
  Custom$MutationRoot();

  factory Custom$MutationRoot.fromJson(Map<String, dynamic> json) =>
      _$Custom$MutationRootFromJson(json);

  Custom$MutationRoot$MutationResponse mut;

  @override
  List<Object?> get props => [mut];
  Map<String, dynamic> toJson() => _$Custom$MutationRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Input extends JsonSerializable with EquatableMixin {
  Input({@required this.s, this.d});

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);

  String s;

  @Deprecated('deprecated input field')
  String d;

  @override
  List<Object?> get props => [s, d];
  Map<String, dynamic> toJson() => _$InputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CustomArguments extends JsonSerializable with EquatableMixin {
  CustomArguments({@required this.input});

  @override
  factory CustomArguments.fromJson(Map<String, dynamic> json) =>
      _$CustomArgumentsFromJson(json);

  final Input input;

  @override
  List<Object?> get props => [input];
  @override
  Map<String, dynamic> toJson() => _$CustomArgumentsToJson(this);
}

class CustomMutation
    extends GraphQLQuery<Custom$MutationRoot, CustomArguments> {
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
                  name: NameNode(value: 'Input'), ),
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
  List<Object?> get props => [document, operationName, variables];
  @override
  Custom$MutationRoot parse(Map<String, dynamic> json) =>
      Custom$MutationRoot.fromJson(json);
}
''';
