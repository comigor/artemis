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
            _mut(input: _Input!): _MutationResponse
          }

          type MutationResponse {
            s: String
          }

          type _MutationResponse {
            _s: String
          }

          input Input {
            s: String!
          }

          input _Input {
            _s: String!
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        generateHelpers: true,
        sourceAssetsMap: {
          'a|queries/another_query.graphql': anotherQuery,
        },
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
mutation _custom($input: _Input!) {
  _mut(input: $input) {
    _s
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
                  type: DartTypeName(name: r'String'),
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
      name: QueryName(name: r'$custom$_MutationRoot'),
      operationName: r'_custom',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'$custom$_MutationRoot$_$MutationResponse'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r'_s'),
                  annotations: [r'''JsonKey(name: '_s')'''],
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'$custom$_MutationRoot'),
            properties: [
              ClassProperty(
                  type: TypeName(
                      name: r'$custom$_MutationRoot$_$MutationResponse'),
                  name: ClassPropertyName(name: r'_mut'),
                  annotations: [r'''JsonKey(name: '_mut')'''],
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'_Input'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'_s'),
                  annotations: [r'''JsonKey(name: '_s')'''],
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: true)
      ],
      inputs: [
        QueryInput(
            type: TypeName(name: r'_Input', isNonNull: true),
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
  Input({required this.s});

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);

  late String s;

  @override
  List<Object?> get props => [s];
  @override
  Map<String, dynamic> toJson() => _$InputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class $custom$MutationRoot$$MutationResponse extends JsonSerializable
    with EquatableMixin {
  $custom$MutationRoot$$MutationResponse();

  factory $custom$MutationRoot$$MutationResponse.fromJson(
          Map<String, dynamic> json) =>
      _$$custom$MutationRoot$$MutationResponseFromJson(json);

  @JsonKey(name: '_s')
  String? $s;

  @override
  List<Object?> get props => [$s];
  @override
  Map<String, dynamic> toJson() =>
      _$$custom$MutationRoot$$MutationResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class $custom$MutationRoot extends JsonSerializable with EquatableMixin {
  $custom$MutationRoot();

  factory $custom$MutationRoot.fromJson(Map<String, dynamic> json) =>
      _$$custom$MutationRootFromJson(json);

  @JsonKey(name: '_mut')
  $custom$MutationRoot$$MutationResponse? $mut;

  @override
  List<Object?> get props => [$mut];
  @override
  Map<String, dynamic> toJson() => _$$custom$MutationRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class $Input extends JsonSerializable with EquatableMixin {
  $Input({required this.$s});

  factory $Input.fromJson(Map<String, dynamic> json) => _$$InputFromJson(json);

  @JsonKey(name: '_s')
  late String $s;

  @override
  List<Object?> get props => [$s];
  @override
  Map<String, dynamic> toJson() => _$$InputToJson(this);
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

@JsonSerializable(explicitToJson: true)
class $customArguments extends JsonSerializable with EquatableMixin {
  $customArguments({required this.input});

  @override
  factory $customArguments.fromJson(Map<String, dynamic> json) =>
      _$$customArgumentsFromJson(json);

  late $Input input;

  @override
  List<Object?> get props => [input];
  @override
  Map<String, dynamic> toJson() => _$$customArgumentsToJson(this);
}

final $CUSTOM_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: '_custom'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'input')),
            type:
                NamedTypeNode(name: NameNode(value: '_Input'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '_mut'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'input'),
                  value: VariableNode(name: NameNode(value: 'input')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: '_s'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class $customMutation
    extends GraphQLQuery<$custom$MutationRoot, $customArguments> {
  $customMutation({required this.variables});

  @override
  final DocumentNode document = $CUSTOM_MUTATION_DOCUMENT;

  @override
  final String operationName = '_custom';

  @override
  final $customArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  $custom$MutationRoot parse(Map<String, dynamic> json) =>
      $custom$MutationRoot.fromJson(json);
}
''';
