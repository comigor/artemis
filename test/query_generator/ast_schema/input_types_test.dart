import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On AST schema', () {
    test(
      'Input object was not generated',
      () async => testGenerator(
        query: query,
        schema: r'''
          schema {
            mutation: MutationRoot
          }

          input OtherObjectInput {
            id: ID!
          }

          input CreateThingInput {
            clientId: ID!
            message: String
            shares: [OtherObjectInput!]
          }

          type Thing {
            id: ID!
            message: String
          }

          type CreateThingResponse {
            thing: Thing
          }

          type MutationRoot {
            createThing(input: CreateThingInput): CreateThingResponse
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
      ),
    );
  });
}

const query = r'''
mutation createThing($createThingInput: CreateThingInput) {
  createThing(input: $createThingInput) {
    thing {
      id
      message
    }
  }
}
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'CreateThing$_MutationRoot'),
      operationName: r'createThing',
      classes: [
        ClassDefinition(
            name: ClassName(
                name: r'CreateThing$_MutationRoot$_CreateThingResponse$_Thing'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'id'),
                  isResolveType: false),
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r'message'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(
                name: r'CreateThing$_MutationRoot$_CreateThingResponse'),
            properties: [
              ClassProperty(
                  type: TypeName(
                      name:
                          r'CreateThing$_MutationRoot$_CreateThingResponse$_Thing'),
                  name: ClassPropertyName(name: r'thing'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'CreateThing$_MutationRoot'),
            properties: [
              ClassProperty(
                  type: TypeName(
                      name: r'CreateThing$_MutationRoot$_CreateThingResponse'),
                  name: ClassPropertyName(name: r'createThing'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'CreateThingInput'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'clientId'),
                  isResolveType: false),
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r'message'),
                  isResolveType: false),
              ClassProperty(
                  type: ListOfTypeName(
                      typeName:
                          TypeName(name: r'OtherObjectInput', isNonNull: true),
                      isNonNull: false),
                  name: ClassPropertyName(name: r'shares'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: true),
        ClassDefinition(
            name: ClassName(name: r'OtherObjectInput'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'id'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: true)
      ],
      inputs: [
        QueryInput(
            type: TypeName(name: r'CreateThingInput'),
            name: QueryInputName(name: r'createThingInput'))
      ],
      generateHelpers: false,
      suffix: r'Mutation')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateThing$MutationRoot$CreateThingResponse$Thing
    extends JsonSerializable with EquatableMixin {
  CreateThing$MutationRoot$CreateThingResponse$Thing();

  factory CreateThing$MutationRoot$CreateThingResponse$Thing.fromJson(
          Map<String, dynamic> json) =>
      _$CreateThing$MutationRoot$CreateThingResponse$ThingFromJson(json);

  late String id;

  String? message;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [id, message, $$typename];
  @override
  Map<String, dynamic> toJson() =>
      _$CreateThing$MutationRoot$CreateThingResponse$ThingToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateThing$MutationRoot$CreateThingResponse extends JsonSerializable
    with EquatableMixin {
  CreateThing$MutationRoot$CreateThingResponse();

  factory CreateThing$MutationRoot$CreateThingResponse.fromJson(
          Map<String, dynamic> json) =>
      _$CreateThing$MutationRoot$CreateThingResponseFromJson(json);

  CreateThing$MutationRoot$CreateThingResponse$Thing? thing;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [thing, $$typename];
  @override
  Map<String, dynamic> toJson() =>
      _$CreateThing$MutationRoot$CreateThingResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateThing$MutationRoot extends JsonSerializable with EquatableMixin {
  CreateThing$MutationRoot();

  factory CreateThing$MutationRoot.fromJson(Map<String, dynamic> json) =>
      _$CreateThing$MutationRootFromJson(json);

  CreateThing$MutationRoot$CreateThingResponse? createThing;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [createThing, $$typename];
  @override
  Map<String, dynamic> toJson() => _$CreateThing$MutationRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateThingInput extends JsonSerializable with EquatableMixin {
  CreateThingInput({required this.clientId, this.message, this.shares});

  factory CreateThingInput.fromJson(Map<String, dynamic> json) =>
      _$CreateThingInputFromJson(json);

  late String clientId;

  String? message;

  List<OtherObjectInput>? shares;

  @override
  List<Object?> get props => [clientId, message, shares];
  @override
  Map<String, dynamic> toJson() => _$CreateThingInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OtherObjectInput extends JsonSerializable with EquatableMixin {
  OtherObjectInput({required this.id});

  factory OtherObjectInput.fromJson(Map<String, dynamic> json) =>
      _$OtherObjectInputFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$OtherObjectInputToJson(this);
}
''';
