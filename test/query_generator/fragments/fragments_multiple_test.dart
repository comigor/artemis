import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On fragments multiple', () {
    test(
      'Fragments will have their own classes multiple',
      () async => testGenerator(
        query: r'''
          fragment Dst on Destination {
            id
            name
          }

          fragment Departure on Destination {
            id
          }

          query VoyagesData($input: PaginationInput!) {
            voyages(pagination: $input) {
              voyages {
                numberOfReports
                voyage {
                  dateFrom
                  dateTo
                  id
                  voyageNumber
                }
              }
            }
          }
        ''',
        schema: r'''
          schema {
            query: Query
          }

          scalar DateTime

          type Query {
            voyages(pagination: PaginationInput!): VoyageList!
          }

          type VoyageList {
            voyages: [VoyageDetails!]!
          }

          type VoyageDetails {
            numberOfReports: Int!
            voyage: Voyage!
          }

          type Voyage {
            arrival: Destination!
            dateFrom: DateTime!
            dateTo: DateTime
            departure: Destination!
            visitPoint: Destination!
            id: ID
            voyageNumber: String!
          }

          type Destination {
            id: ID!
            name: String!
          }
          
          input PaginationInput {
            limit: Int!
            offset: Int!
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        generateHelpers: true,
        builderOptionsMap: {
          'scalar_mapping': [
            {
              'graphql_type': 'DateTime',
              'dart_type': 'DateTime',
            },
          ],
        },
      ),
    );
  });
}

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'VoyagesData$_Query'),
      operationName: r'VoyagesData',
      classes: [
        FragmentClassDefinition(
            name: FragmentName(name: r'DstMixin'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'id'),
                  isResolveType: false),
              ClassProperty(
                  type: DartTypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'name'),
                  isResolveType: false)
            ]),
        FragmentClassDefinition(
            name: FragmentName(name: r'DepartureMixin'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'id'),
                  isResolveType: false)
            ]),
        ClassDefinition(
            name: ClassName(
                name: r'VoyagesData$_Query$_VoyageList$_VoyageDetails$_Voyage'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'DateTime', isNonNull: true),
                  name: ClassPropertyName(name: r'dateFrom'),
                  isResolveType: false),
              ClassProperty(
                  type: DartTypeName(name: r'DateTime'),
                  name: ClassPropertyName(name: r'dateTo'),
                  isResolveType: false),
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r'id'),
                  isResolveType: false),
              ClassProperty(
                  type: DartTypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'voyageNumber'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(
                name: r'VoyagesData$_Query$_VoyageList$_VoyageDetails'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'int', isNonNull: true),
                  name: ClassPropertyName(name: r'numberOfReports'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(
                      name:
                          r'VoyagesData$_Query$_VoyageList$_VoyageDetails$_Voyage',
                      isNonNull: true),
                  name: ClassPropertyName(name: r'voyage'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'VoyagesData$_Query$_VoyageList'),
            properties: [
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: TypeName(
                          name:
                              r'VoyagesData$_Query$_VoyageList$_VoyageDetails',
                          isNonNull: true),
                      isNonNull: true),
                  name: ClassPropertyName(name: r'voyages'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'VoyagesData$_Query'),
            properties: [
              ClassProperty(
                  type: TypeName(
                      name: r'VoyagesData$_Query$_VoyageList', isNonNull: true),
                  name: ClassPropertyName(name: r'voyages'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'PaginationInput'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'int', isNonNull: true),
                  name: ClassPropertyName(name: r'limit'),
                  isResolveType: false),
              ClassProperty(
                  type: DartTypeName(name: r'int', isNonNull: true),
                  name: ClassPropertyName(name: r'offset'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: true)
      ],
      inputs: [
        QueryInput(
            type: TypeName(name: r'PaginationInput', isNonNull: true),
            name: QueryInputName(name: r'input'))
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

mixin DstMixin {
  late String id;
  late String name;
}
mixin DepartureMixin {
  late String id;
}

@JsonSerializable(explicitToJson: true)
class VoyagesData$Query$VoyageList$VoyageDetails$Voyage extends JsonSerializable
    with EquatableMixin {
  VoyagesData$Query$VoyageList$VoyageDetails$Voyage();

  factory VoyagesData$Query$VoyageList$VoyageDetails$Voyage.fromJson(
          Map<String, dynamic> json) =>
      _$VoyagesData$Query$VoyageList$VoyageDetails$VoyageFromJson(json);

  late DateTime dateFrom;

  DateTime? dateTo;

  String? id;

  late String voyageNumber;

  @override
  List<Object?> get props => [dateFrom, dateTo, id, voyageNumber];
  @override
  Map<String, dynamic> toJson() =>
      _$VoyagesData$Query$VoyageList$VoyageDetails$VoyageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VoyagesData$Query$VoyageList$VoyageDetails extends JsonSerializable
    with EquatableMixin {
  VoyagesData$Query$VoyageList$VoyageDetails();

  factory VoyagesData$Query$VoyageList$VoyageDetails.fromJson(
          Map<String, dynamic> json) =>
      _$VoyagesData$Query$VoyageList$VoyageDetailsFromJson(json);

  late int numberOfReports;

  late VoyagesData$Query$VoyageList$VoyageDetails$Voyage voyage;

  @override
  List<Object?> get props => [numberOfReports, voyage];
  @override
  Map<String, dynamic> toJson() =>
      _$VoyagesData$Query$VoyageList$VoyageDetailsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VoyagesData$Query$VoyageList extends JsonSerializable
    with EquatableMixin {
  VoyagesData$Query$VoyageList();

  factory VoyagesData$Query$VoyageList.fromJson(Map<String, dynamic> json) =>
      _$VoyagesData$Query$VoyageListFromJson(json);

  late List<VoyagesData$Query$VoyageList$VoyageDetails> voyages;

  @override
  List<Object?> get props => [voyages];
  @override
  Map<String, dynamic> toJson() => _$VoyagesData$Query$VoyageListToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VoyagesData$Query extends JsonSerializable with EquatableMixin {
  VoyagesData$Query();

  factory VoyagesData$Query.fromJson(Map<String, dynamic> json) =>
      _$VoyagesData$QueryFromJson(json);

  late VoyagesData$Query$VoyageList voyages;

  @override
  List<Object?> get props => [voyages];
  @override
  Map<String, dynamic> toJson() => _$VoyagesData$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PaginationInput extends JsonSerializable with EquatableMixin {
  PaginationInput({required this.limit, required this.offset});

  factory PaginationInput.fromJson(Map<String, dynamic> json) =>
      _$PaginationInputFromJson(json);

  late int limit;

  late int offset;

  @override
  List<Object?> get props => [limit, offset];
  @override
  Map<String, dynamic> toJson() => _$PaginationInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VoyagesDataArguments extends JsonSerializable with EquatableMixin {
  VoyagesDataArguments({required this.input});

  @override
  factory VoyagesDataArguments.fromJson(Map<String, dynamic> json) =>
      _$VoyagesDataArgumentsFromJson(json);

  late PaginationInput input;

  @override
  List<Object?> get props => [input];
  @override
  Map<String, dynamic> toJson() => _$VoyagesDataArgumentsToJson(this);
}

final VOYAGES_DATA_QUERY_DOCUMENT = DocumentNode(definitions: [
  FragmentDefinitionNode(
      name: NameNode(value: 'Dst'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'Destination'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'Departure'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'Destination'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'VoyagesData'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'input')),
            type: NamedTypeNode(
                name: NameNode(value: 'PaginationInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'voyages'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'pagination'),
                  value: VariableNode(name: NameNode(value: 'input')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'voyages'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'numberOfReports'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'voyage'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'dateFrom'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'dateTo'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'id'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'voyageNumber'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ]))
                  ]))
            ]))
      ]))
]);

class VoyagesDataQuery
    extends GraphQLQuery<VoyagesData$Query, VoyagesDataArguments> {
  VoyagesDataQuery({required this.variables});

  @override
  final DocumentNode document = VOYAGES_DATA_QUERY_DOCUMENT;

  @override
  final String operationName = 'VoyagesData';

  @override
  final VoyagesDataArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  VoyagesData$Query parse(Map<String, dynamic> json) =>
      VoyagesData$Query.fromJson(json);
}
''';
