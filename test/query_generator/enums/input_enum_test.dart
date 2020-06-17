// @dart = 2.8

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
            q(input: Input!, o: OtherEnum!): QueryResponse
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
  query custom($input: Input!, $o: OtherEnum!) {
    q(input: $input, o: $o) {
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
          EnumValueDefinition(
            name: EnumValueName(name: r'A'),
          ),
          EnumValueDefinition(
            name: EnumValueName(name: r'B'),
          ),
          EnumValueDefinition(
              name: EnumValueName(
            name: r'ARTEMIS_UNKNOWN',
          ))
        ]),
        EnumDefinition(name: EnumName(name: r'OtherEnum'), values: [
          EnumValueDefinition(
            name: EnumValueName(name: r'O1'),
          ),
          EnumValueDefinition(
            name: EnumValueName(name: r'O2'),
          ),
          EnumValueDefinition(
              name: EnumValueName(
            name: r'ARTEMIS_UNKNOWN',
          ))
        ]),
        ClassDefinition(
            name: ClassName(name: r'Custom$_QueryRoot$_QueryResponse'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r's'),
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'MyEnum'),
                  name: ClassPropertyName(name: r'my'),
                  annotations: [
                    r'JsonKey(unknownEnumValue: MyEnum.artemisUnknown)'
                  ],
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'OtherEnum'),
                  name: ClassPropertyName(name: r'other'),
                  annotations: [
                    r'JsonKey(unknownEnumValue: OtherEnum.artemisUnknown)'
                  ],
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Custom$_QueryRoot'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'Custom$_QueryRoot$_QueryResponse'),
                  name: ClassPropertyName(name: r'q'),
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
                  type: TypeName(name: r'MyEnum'),
                  name: ClassPropertyName(name: r'e'),
                  annotations: [
                    r'JsonKey(unknownEnumValue: MyEnum.artemisUnknown)'
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
            type: TypeName(name: r'OtherEnum'),
            name: QueryInputName(name: r'o'),
            isNonNull: true,
            annotations: [
              r'JsonKey(unknownEnumValue: OtherEnum.artemisUnknown)'
            ])
      ],
      generateHelpers: true,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot$QueryResponse with EquatableMixin {
  Custom$QueryRoot$QueryResponse();

  factory Custom$QueryRoot$QueryResponse.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRoot$QueryResponseFromJson(json);

  String s;

  @JsonKey(unknownEnumValue: MyEnum.artemisUnknown)
  MyEnum my;

  @JsonKey(unknownEnumValue: OtherEnum.artemisUnknown)
  OtherEnum other;

  @override
  List<Object> get props => [s, my, other];
  Map<String, dynamic> toJson() => _$Custom$QueryRoot$QueryResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot with EquatableMixin {
  Custom$QueryRoot();

  factory Custom$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRootFromJson(json);

  Custom$QueryRoot$QueryResponse q;

  @override
  List<Object> get props => [q];
  Map<String, dynamic> toJson() => _$Custom$QueryRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Input with EquatableMixin {
  Input({@required this.e});

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);

  @JsonKey(unknownEnumValue: MyEnum.artemisUnknown)
  MyEnum e;

  @override
  List<Object> get props => [e];
  Map<String, dynamic> toJson() => _$InputToJson(this);
}

enum MyEnum {
  @JsonValue("A")
  a,
  @JsonValue("B")
  b,
  @JsonValue("ARTEMIS_UNKNOWN")
  artemisUnknown,
}
enum OtherEnum {
  @JsonValue("O1")
  o1,
  @JsonValue("O2")
  o2,
  @JsonValue("ARTEMIS_UNKNOWN")
  artemisUnknown,
}

@JsonSerializable(explicitToJson: true)
class CustomArguments extends JsonSerializable with EquatableMixin {
  CustomArguments({@required this.input, @required this.o});

  factory CustomArguments.fromJson(Map<String, dynamic> json) =>
      _$CustomArgumentsFromJson(json);

  final Input input;

  @JsonKey(unknownEnumValue: OtherEnum.artemisUnknown)
  final OtherEnum o;

  @override
  List<Object> get props => [input, o];
  Map<String, dynamic> toJson() => _$CustomArgumentsToJson(this);
}

class CustomQuery extends GraphQLQuery<Custom$QueryRoot, CustomArguments> {
  CustomQuery({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'custom'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'input')),
              type: NamedTypeNode(
                  name: NameNode(value: 'Input'), isNonNull: true),
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

  @override
  final String operationName = 'custom';

  @override
  final CustomArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  Custom$QueryRoot parse(Map<String, dynamic> json) =>
      Custom$QueryRoot.fromJson(json);
}
''';
