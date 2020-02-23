import 'package:artemis/generator/data.dart';
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
          generateHelpers: true),
    );
  });
}

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query', queries: [
  QueryDefinition(
      queryName: r'VoyagesData',
      queryType: r'VoyagesData$Query',
      classes: [
        FragmentClassDefinition(name: r'VoyagesData$DstMixin', properties: [
          ClassProperty(
              type: r'String',
              name: r'id',
              isOverride: false,
              isNonNull: true,
              isResolveType: false),
          ClassProperty(
              type: r'String',
              name: r'name',
              isOverride: false,
              isNonNull: true,
              isResolveType: false)
        ]),
        FragmentClassDefinition(
            name: r'VoyagesData$DepartureMixin',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r'id',
                  isOverride: false,
                  isNonNull: true,
                  isResolveType: false)
            ]),
        ClassDefinition(
            name: r'VoyagesData$Query$VoyageList$VoyageDetails$Voyage',
            properties: [
              ClassProperty(
                  type: r'DateTime',
                  name: r'dateFrom',
                  isOverride: false,
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: r'DateTime',
                  name: r'dateTo',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: r'String',
                  name: r'id',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: r'String',
                  name: r'voyageNumber',
                  isOverride: false,
                  isNonNull: true,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'VoyagesData$Query$VoyageList$VoyageDetails',
            properties: [
              ClassProperty(
                  type: r'int',
                  name: r'numberOfReports',
                  isOverride: false,
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: r'VoyagesData$Query$VoyageList$VoyageDetails$Voyage',
                  name: r'voyage',
                  isOverride: false,
                  isNonNull: true,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'VoyagesData$Query$VoyageList',
            properties: [
              ClassProperty(
                  type: r'List<VoyagesData$Query$VoyageList$VoyageDetails>',
                  name: r'voyages',
                  isOverride: false,
                  isNonNull: true,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'VoyagesData$Query',
            properties: [
              ClassProperty(
                  type: r'VoyagesData$Query$VoyageList',
                  name: r'voyages',
                  isOverride: false,
                  isNonNull: true,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'PaginationInput',
            properties: [
              ClassProperty(
                  type: r'int',
                  name: r'limit',
                  isOverride: false,
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: r'int',
                  name: r'offset',
                  isOverride: false,
                  isNonNull: true,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: true)
      ],
      inputs: [
        QueryInput(type: r'PaginationInput', name: r'input', isNonNull: true)
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
part 'query.g.dart';

mixin VoyagesData$DstMixin {
  String id;
  String name;
}
mixin VoyagesData$DepartureMixin {
  String id;
}

@JsonSerializable(explicitToJson: true)
class VoyagesData$Query$VoyageList$VoyageDetails$Voyage with EquatableMixin {
  VoyagesData$Query$VoyageList$VoyageDetails$Voyage();

  factory VoyagesData$Query$VoyageList$VoyageDetails$Voyage.fromJson(
          Map<String, dynamic> json) =>
      _$VoyagesData$Query$VoyageList$VoyageDetails$VoyageFromJson(json);

  DateTime dateFrom;

  DateTime dateTo;

  String id;

  String voyageNumber;

  @override
  List<Object> get props => [dateFrom, dateTo, id, voyageNumber];
  Map<String, dynamic> toJson() =>
      _$VoyagesData$Query$VoyageList$VoyageDetails$VoyageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VoyagesData$Query$VoyageList$VoyageDetails with EquatableMixin {
  VoyagesData$Query$VoyageList$VoyageDetails();

  factory VoyagesData$Query$VoyageList$VoyageDetails.fromJson(
          Map<String, dynamic> json) =>
      _$VoyagesData$Query$VoyageList$VoyageDetailsFromJson(json);

  int numberOfReports;

  VoyagesData$Query$VoyageList$VoyageDetails$Voyage voyage;

  @override
  List<Object> get props => [numberOfReports, voyage];
  Map<String, dynamic> toJson() =>
      _$VoyagesData$Query$VoyageList$VoyageDetailsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VoyagesData$Query$VoyageList with EquatableMixin {
  VoyagesData$Query$VoyageList();

  factory VoyagesData$Query$VoyageList.fromJson(Map<String, dynamic> json) =>
      _$VoyagesData$Query$VoyageListFromJson(json);

  List<VoyagesData$Query$VoyageList$VoyageDetails> voyages;

  @override
  List<Object> get props => [voyages];
  Map<String, dynamic> toJson() => _$VoyagesData$Query$VoyageListToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VoyagesData$Query with EquatableMixin {
  VoyagesData$Query();

  factory VoyagesData$Query.fromJson(Map<String, dynamic> json) =>
      _$VoyagesData$QueryFromJson(json);

  VoyagesData$Query$VoyageList voyages;

  @override
  List<Object> get props => [voyages];
  Map<String, dynamic> toJson() => _$VoyagesData$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PaginationInput with EquatableMixin {
  PaginationInput({@required this.limit, @required this.offset});

  factory PaginationInput.fromJson(Map<String, dynamic> json) =>
      _$PaginationInputFromJson(json);

  int limit;

  int offset;

  @override
  List<Object> get props => [limit, offset];
  Map<String, dynamic> toJson() => _$PaginationInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VoyagesDataArguments extends JsonSerializable with EquatableMixin {
  VoyagesDataArguments({@required this.input});

  factory VoyagesDataArguments.fromJson(Map<String, dynamic> json) =>
      _$VoyagesDataArgumentsFromJson(json);

  final PaginationInput input;

  @override
  List<Object> get props => [input];
  Map<String, dynamic> toJson() => _$VoyagesDataArgumentsToJson(this);
}

class VoyagesDataQuery
    extends GraphQLQuery<VoyagesData$Query, VoyagesDataArguments> {
  VoyagesDataQuery({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
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

  @override
  final String operationName = 'VoyagesData';

  @override
  final VoyagesDataArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  VoyagesData$Query parse(Map<String, dynamic> json) =>
      VoyagesData$Query.fromJson(json);
}
''';
