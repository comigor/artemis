import 'package:artemis/generator/data/data.dart';
import 'package:artemis/generator/data/enum_value_definition.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On enums', () {
    test(
      'Enums can be part of input objects',
      () async => testGenerator(
        query: query,
        schema: r'''
          schema {
            query: QueryRoot
          }
          
          type QueryRoot {
            q(_id: ID!, input: Input!, o: OtherEnum!): QueryResponse
          }
          
          type QueryResponse {
            s: String
            my: MyEnum
            other: OtherEnum
          }
          
          input Input {
            e: MyEnum!
          }
          
          enum MyEnum {
            A
            B
          }
          
          enum OtherEnum {
            O1
            O2
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
  query custom($_id: ID!, $input: Input!, $o: OtherEnum!) {
    q(_id: $_id, input: $input, o: $o) {
      s
      my
      other
    }
  }
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'Custom$_QueryRoot'),
      operationName: r'custom',
      classes: [
        EnumDefinition(name: EnumName(name: r'MyEnum'), values: [
          EnumValueDefinition(name: EnumValueName(name: r'A')),
          EnumValueDefinition(name: EnumValueName(name: r'B')),
          EnumValueDefinition(name: EnumValueName(name: r'ARTEMIS_UNKNOWN'))
        ]),
        EnumDefinition(name: EnumName(name: r'OtherEnum'), values: [
          EnumValueDefinition(name: EnumValueName(name: r'O1')),
          EnumValueDefinition(name: EnumValueName(name: r'O2')),
          EnumValueDefinition(name: EnumValueName(name: r'ARTEMIS_UNKNOWN'))
        ]),
        ClassDefinition(
            name: ClassName(name: r'Custom$_QueryRoot$_QueryResponse'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r's'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'MyEnum'),
                  name: ClassPropertyName(name: r'my'),
                  annotations: [
                    r'JsonKey(unknownEnumValue: MyEnum.artemisUnknown)'
                  ],
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'OtherEnum'),
                  name: ClassPropertyName(name: r'other'),
                  annotations: [
                    r'JsonKey(unknownEnumValue: OtherEnum.artemisUnknown)'
                  ],
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Custom$_QueryRoot'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'Custom$_QueryRoot$_QueryResponse'),
                  name: ClassPropertyName(name: r'q'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Input'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'MyEnum', isNonNull: true),
                  name: ClassPropertyName(name: r'e'),
                  annotations: [
                    r'JsonKey(unknownEnumValue: MyEnum.artemisUnknown)'
                  ],
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: true)
      ],
      inputs: [
        QueryInput(
            type: DartTypeName(name: r'String', isNonNull: true),
            name: QueryInputName(name: r'_id'),
            annotations: [r'''JsonKey(name: '_id')''']),
        QueryInput(
            type: TypeName(name: r'Input', isNonNull: true),
            name: QueryInputName(name: r'input')),
        QueryInput(
            type: TypeName(name: r'OtherEnum', isNonNull: true),
            name: QueryInputName(name: r'o'),
            annotations: [
              r'JsonKey(unknownEnumValue: OtherEnum.artemisUnknown)'
            ])
      ],
      generateHelpers: true,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot$QueryResponse extends JsonSerializable
    with EquatableMixin {
  Custom$QueryRoot$QueryResponse();

  factory Custom$QueryRoot$QueryResponse.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRoot$QueryResponseFromJson(json);

  String? s;

  @JsonKey(unknownEnumValue: MyEnum.artemisUnknown)
  MyEnum? my;

  @JsonKey(unknownEnumValue: OtherEnum.artemisUnknown)
  OtherEnum? other;

  @override
  List<Object?> get props => [s, my, other];
  @override
  Map<String, dynamic> toJson() => _$Custom$QueryRoot$QueryResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot extends JsonSerializable with EquatableMixin {
  Custom$QueryRoot();

  factory Custom$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRootFromJson(json);

  Custom$QueryRoot$QueryResponse? q;

  @override
  List<Object?> get props => [q];
  @override
  Map<String, dynamic> toJson() => _$Custom$QueryRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Input extends JsonSerializable with EquatableMixin {
  Input({required this.e});

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);

  @JsonKey(unknownEnumValue: MyEnum.artemisUnknown)
  late MyEnum e;

  @override
  List<Object?> get props => [e];
  @override
  Map<String, dynamic> toJson() => _$InputToJson(this);
}

enum MyEnum {
  @JsonValue('A')
  a,
  @JsonValue('B')
  b,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}

enum OtherEnum {
  @JsonValue('O1')
  o1,
  @JsonValue('O2')
  o2,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}

@JsonSerializable(explicitToJson: true)
class CustomArguments extends JsonSerializable with EquatableMixin {
  CustomArguments({required this.$id, required this.input, required this.o});

  @override
  factory CustomArguments.fromJson(Map<String, dynamic> json) =>
      _$CustomArgumentsFromJson(json);

  @JsonKey(name: '_id')
  late String $id;

  late Input input;

  @JsonKey(unknownEnumValue: OtherEnum.artemisUnknown)
  late OtherEnum o;

  @override
  List<Object?> get props => [$id, input, o];
  @override
  Map<String, dynamic> toJson() => _$CustomArgumentsToJson(this);
}

final CUSTOM_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'custom'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: '_id')),
            type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'input')),
            type:
                NamedTypeNode(name: NameNode(value: 'Input'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'o')),
            type: NamedTypeNode(
                name: NameNode(value: 'OtherEnum'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'q'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: '_id'),
                  value: VariableNode(name: NameNode(value: '_id'))),
              ArgumentNode(
                  name: NameNode(value: 'input'),
                  value: VariableNode(name: NameNode(value: 'input'))),
              ArgumentNode(
                  name: NameNode(value: 'o'),
                  value: VariableNode(name: NameNode(value: 'o')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 's'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'my'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'other'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class CustomQuery extends GraphQLQuery<Custom$QueryRoot, CustomArguments> {
  CustomQuery({required this.variables});

  @override
  final DocumentNode document = CUSTOM_QUERY_DOCUMENT;

  @override
  final String operationName = 'custom';

  @override
  final CustomArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  Custom$QueryRoot parse(Map<String, dynamic> json) =>
      Custom$QueryRoot.fromJson(json);
}
''';
