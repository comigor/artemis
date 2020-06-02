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
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Custom$_MutationRoot'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'Custom$MutationRoot$MutationResponse'),
                  name: ClassPropertyName(name: r'mut'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Input'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'MyUuid'),
                  name: ClassPropertyName(name: r'id'),
                  annotations: [
                    r'JsonKey(fromJson: fromGraphQLMyUuidToDartMyUuid, toJson: fromDartMyUuidToGraphQLMyUuid,)'
                  ],
                  isNonNull: true,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: true)
      ],
      inputs: [
        QueryInput(
            type: TypeName(name: r'Input'),
            name: QueryInputName(name: r'input'),
            isNonNull: true),
        QueryInput(
            type: TypeName(name: r'MyUuid'),
            name: QueryInputName(name: r'previousId'),
            isNonNull: false,
            annotations: [
              r'JsonKey(fromJson: fromGraphQLMyUuidToDartMyUuid, toJson: fromDartMyUuidToGraphQLMyUuid,)'
            ]),
        QueryInput(
            type: TypeName(name: r'List<MyUuid>'),
            name: QueryInputName(name: r'listIds'),
            isNonNull: false,
            annotations: [
              r'JsonKey(fromJson: fromGraphQLListMyUuidToDartListMyUuid, toJson: fromDartListMyUuidToGraphQLListMyUuid,)'
            ])
      ],
      generateHelpers: true,
      suffix: r'Mutation')
], customImports: [
  r'package:uuid/uuid.dart',
  r'package:example/src/custom_parser.dart'
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:uuid/uuid.dart';
import 'package:example/src/custom_parser.dart';
part 'query.graphql.g.dart';

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

  Custom$MutationRoot$MutationResponse mut;

  @override
  List<Object> get props => [mut];
  Map<String, dynamic> toJson() => _$Custom$MutationRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Input with EquatableMixin {
  Input({@required this.id});

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);

  @JsonKey(
    fromJson: fromGraphQLMyUuidToDartMyUuid,
    toJson: fromDartMyUuidToGraphQLMyUuid,
  )
  MyUuid id;

  @override
  List<Object> get props => [id];
  Map<String, dynamic> toJson() => _$InputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CustomArguments extends JsonSerializable with EquatableMixin {
  CustomArguments({@required this.input, this.previousId, this.listIds});

  factory CustomArguments.fromJson(Map<String, dynamic> json) =>
      _$CustomArgumentsFromJson(json);

  final Input input;

  @JsonKey(
    fromJson: fromGraphQLMyUuidToDartMyUuid,
    toJson: fromDartMyUuidToGraphQLMyUuid,
  )
  final MyUuid previousId;

  @JsonKey(
    fromJson: fromGraphQLListMyUuidToDartListMyUuid,
    toJson: fromDartListMyUuidToGraphQLListMyUuid,
  )
  final List<MyUuid> listIds;

  @override
  List<Object> get props => [input, previousId, listIds];
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
                  name: NameNode(value: 'Input'), isNonNull: true),
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

  @override
  final String operationName = 'custom';

  @override
  final CustomArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  Custom$MutationRoot parse(Map<String, dynamic> json) =>
      Custom$MutationRoot.fromJson(json);
}
''';
