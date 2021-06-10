import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On input objects', () {
    test(
      'Custom scalars should be coerced',
      () async => testGenerator(
        query: query,
        schema: r'''
          scalar MyUuid

          schema {
            mutation: MutationRoot
          }

          type MutationRoot {
            mut(input: Input!, previousId: MyUuid, listIds: [MyUuid]): MutationResponse
          } 

          type MutationResponse {
            s: String
          }

          input Input {
            id: MyUuid!
            idNullabe: MyUuid
          }
          ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        generateHelpers: true,
        builderOptionsMap: {
          'scalar_mapping': [
            {
              'graphql_type': 'MyUuid',
              'custom_parser_import': 'package:example/src/custom_parser.dart',
              'dart_type': {
                'name': 'MyUuid',
                'imports': ['package:uuid/uuid.dart'],
              }
            },
          ],
        },
      ),
    );
  });
}

const query = r'''
mutation custom($input: Input!, $previousId: MyUuid, $listIds: [MyUuid]) {
  mut(input: $input, previousId: $previousId, listIds: $listIds) {
    s
  }
}
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'Custom$_MutationRoot'),
      operationName: r'custom',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'Custom$_MutationRoot$_MutationResponse'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r's'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Custom$_MutationRoot'),
            properties: [
              ClassProperty(
                  type:
                      TypeName(name: r'Custom$_MutationRoot$_MutationResponse'),
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
                  type: TypeName(name: r'MyUuid', isNonNull: true),
                  name: ClassPropertyName(name: r'id'),
                  annotations: [
                    r'JsonKey(fromJson: fromGraphQLMyUuidToDartMyUuid, toJson: fromDartMyUuidToGraphQLMyUuid)'
                  ],
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'MyUuid'),
                  name: ClassPropertyName(name: r'idNullabe'),
                  annotations: [
                    r'JsonKey(fromJson: fromGraphQLMyUuidToDartMyUuidNullable, toJson: fromDartMyUuidToGraphQLMyUuidNullable)'
                  ],
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: true)
      ],
      inputs: [
        QueryInput(
            type: TypeName(name: r'Input', isNonNull: true),
            name: QueryInputName(name: r'input')),
        QueryInput(
            type: TypeName(name: r'MyUuid'),
            name: QueryInputName(name: r'previousId'),
            annotations: [
              r'JsonKey(fromJson: fromGraphQLMyUuidToDartMyUuidNullable, toJson: fromDartMyUuidToGraphQLMyUuidNullable)'
            ]),
        QueryInput(
            type: ListOfTypeName(
                typeName: TypeName(name: r'MyUuid'), isNonNull: false),
            name: QueryInputName(name: r'listIds'),
            annotations: [
              r'JsonKey(fromJson: fromGraphQLListMyUuidToDartListMyUuidNullable, toJson: fromDartListMyUuidToGraphQLListMyUuidNullable)'
            ])
      ],
      generateHelpers: true,
      suffix: r'Mutation')
], customImports: [
  r'package:uuid/uuid.dart',
  r'package:example/src/custom_parser.dart'
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:uuid/uuid.dart';
import 'package:example/src/custom_parser.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$MutationRoot$MutationResponse extends JsonSerializable
    with EquatableMixin {
  Custom$MutationRoot$MutationResponse();

  factory Custom$MutationRoot$MutationResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Custom$MutationRoot$MutationResponseFromJson(json);

  String? s;

  @override
  List<Object?> get props => [s];
  @override
  Map<String, dynamic> toJson() =>
      _$Custom$MutationRoot$MutationResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$MutationRoot extends JsonSerializable with EquatableMixin {
  Custom$MutationRoot();

  factory Custom$MutationRoot.fromJson(Map<String, dynamic> json) =>
      _$Custom$MutationRootFromJson(json);

  Custom$MutationRoot$MutationResponse? mut;

  @override
  List<Object?> get props => [mut];
  @override
  Map<String, dynamic> toJson() => _$Custom$MutationRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Input extends JsonSerializable with EquatableMixin {
  Input({required this.id, this.idNullabe});

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);

  @JsonKey(
      fromJson: fromGraphQLMyUuidToDartMyUuid,
      toJson: fromDartMyUuidToGraphQLMyUuid)
  late MyUuid id;

  @JsonKey(
      fromJson: fromGraphQLMyUuidToDartMyUuidNullable,
      toJson: fromDartMyUuidToGraphQLMyUuidNullable)
  MyUuid? idNullabe;

  @override
  List<Object?> get props => [id, idNullabe];
  @override
  Map<String, dynamic> toJson() => _$InputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CustomArguments extends JsonSerializable with EquatableMixin {
  CustomArguments({required this.input, this.previousId, this.listIds});

  @override
  factory CustomArguments.fromJson(Map<String, dynamic> json) =>
      _$CustomArgumentsFromJson(json);

  late Input input;

  @JsonKey(
      fromJson: fromGraphQLMyUuidToDartMyUuidNullable,
      toJson: fromDartMyUuidToGraphQLMyUuidNullable)
  final MyUuid? previousId;

  @JsonKey(
      fromJson: fromGraphQLListMyUuidToDartListMyUuidNullable,
      toJson: fromDartListMyUuidToGraphQLListMyUuidNullable)
  final List<MyUuid?>? listIds;

  @override
  List<Object?> get props => [input, previousId, listIds];
  @override
  Map<String, dynamic> toJson() => _$CustomArgumentsToJson(this);
}

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
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'previousId')),
            type: NamedTypeNode(
                name: NameNode(value: 'MyUuid'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'listIds')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'MyUuid'), isNonNull: false),
                isNonNull: false),
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
                  value: VariableNode(name: NameNode(value: 'input'))),
              ArgumentNode(
                  name: NameNode(value: 'previousId'),
                  value: VariableNode(name: NameNode(value: 'previousId'))),
              ArgumentNode(
                  name: NameNode(value: 'listIds'),
                  value: VariableNode(name: NameNode(value: 'listIds')))
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

class CustomMutation
    extends GraphQLQuery<Custom$MutationRoot, CustomArguments> {
  CustomMutation({required this.variables});

  @override
  final DocumentNode document = CUSTOM_MUTATION_DOCUMENT;

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
