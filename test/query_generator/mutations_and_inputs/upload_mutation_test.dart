import 'package:artemis/generator/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On file upload mutations', () {
    test(
      'Upload mutation type will be processed correctly',
      () async => testGenerator(
        query: query,
        schema: r'''
          scalar Upload
          
          schema {
            mutation: MutationRoot
          }

          type MutationRoot {
            mut(input: Input!): MutationResponse
          }

          type MutationResponse {
            fileName: String
          }

          input Input {
            file: Upload!
            fileList: [Upload!]!
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        generateHelpers: true,
        builderOptionsMap: {
          'scalar_mapping': [
            {
              'graphql_type': 'Upload',
              'dart_type': {
                'name': 'File',
                'imports': ['dart:io'],
              }
            },
          ],
        },
      ),
    );
  });
}

const query = r'''
mutation custom($input: Input!) {
  mut(input: $input) {
    fileName
  }
}
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      queryName: r'custom',
      queryType: r'Custom$MutationRoot',
      classes: [
        ClassDefinition(
            name: r'Custom$MutationRoot$MutationResponse',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r'fileName',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'Custom$MutationRoot',
            properties: [
              ClassProperty(
                  type: r'Custom$MutationRoot$MutationResponse',
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
                  type: r'File',
                  name: r'file',
                  isOverride: false,
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: r'List<File>',
                  name: r'fileList',
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
      suffix: r'Mutation')
], customImports: [
  r'dart:io'
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'dart:io';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$MutationRoot$MutationResponse with EquatableMixin {
  Custom$MutationRoot$MutationResponse();

  factory Custom$MutationRoot$MutationResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Custom$MutationRoot$MutationResponseFromJson(json);

  String fileName;

  @override
  List<Object> get props => [fileName];
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
  Input({@required this.file, @required this.fileList});

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);

  @JsonKey(ignore: true)
  File file;

  @JsonKey(ignore: true)
  List<File> fileList;

  @override
  List<Object> get props => [file, fileList];
  Map<String, dynamic> toJson() => _$InputToJson(this);
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
                    name: NameNode(value: 'fileName'),
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
