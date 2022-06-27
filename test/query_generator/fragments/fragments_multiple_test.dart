import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On fragments multiple', () {
    test(
      'Fragments will have their own classes multiple',
      () async => testGenerator(
        namingScheme: 'pathedWithFields',
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
                  arrival {
                    ...Dst
                  }
                  departure {
                    ...Departure
                  }
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
        ClassDefinition(
            name: ClassName(
                name: r'VoyagesData$_Query$_voyages$_voyages$_voyage$_arrival'),
            mixins: [FragmentName(name: r'DstMixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(
                name:
                    r'VoyagesData$_Query$_voyages$_voyages$_voyage$_departure'),
            mixins: [FragmentName(name: r'DepartureMixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(
                name: r'VoyagesData$_Query$_voyages$_voyages$_voyage'),
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
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(
                      name:
                          r'VoyagesData$_Query$_voyages$_voyages$_voyage$_arrival',
                      isNonNull: true),
                  name: ClassPropertyName(name: r'arrival'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(
                      name:
                          r'VoyagesData$_Query$_voyages$_voyages$_voyage$_departure',
                      isNonNull: true),
                  name: ClassPropertyName(name: r'departure'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'VoyagesData$_Query$_voyages$_voyages'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'int', isNonNull: true),
                  name: ClassPropertyName(name: r'numberOfReports'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(
                      name: r'VoyagesData$_Query$_voyages$_voyages$_voyage',
                      isNonNull: true),
                  name: ClassPropertyName(name: r'voyage'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'VoyagesData$_Query$_voyages'),
            properties: [
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: TypeName(
                          name: r'VoyagesData$_Query$_voyages$_voyages',
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
                      name: r'VoyagesData$_Query$_voyages', isNonNull: true),
                  name: ClassPropertyName(name: r'voyages'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
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
  @JsonKey(name: '__typename')
  String? $$typename;
}
mixin DepartureMixin {
  late String id;
  @JsonKey(name: '__typename')
  String? $$typename;
}

@JsonSerializable(explicitToJson: true)
class VoyagesData$Query$Voyages$Voyages$Voyage$Arrival extends JsonSerializable
    with EquatableMixin, DstMixin {
  VoyagesData$Query$Voyages$Voyages$Voyage$Arrival();

  factory VoyagesData$Query$Voyages$Voyages$Voyage$Arrival.fromJson(
          Map<String, dynamic> json) =>
      _$VoyagesData$Query$Voyages$Voyages$Voyage$ArrivalFromJson(json);

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [id, name, $$typename];
  @override
  Map<String, dynamic> toJson() =>
      _$VoyagesData$Query$Voyages$Voyages$Voyage$ArrivalToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VoyagesData$Query$Voyages$Voyages$Voyage$Departure
    extends JsonSerializable with EquatableMixin, DepartureMixin {
  VoyagesData$Query$Voyages$Voyages$Voyage$Departure();

  factory VoyagesData$Query$Voyages$Voyages$Voyage$Departure.fromJson(
          Map<String, dynamic> json) =>
      _$VoyagesData$Query$Voyages$Voyages$Voyage$DepartureFromJson(json);

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [id, $$typename];
  @override
  Map<String, dynamic> toJson() =>
      _$VoyagesData$Query$Voyages$Voyages$Voyage$DepartureToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VoyagesData$Query$Voyages$Voyages$Voyage extends JsonSerializable
    with EquatableMixin {
  VoyagesData$Query$Voyages$Voyages$Voyage();

  factory VoyagesData$Query$Voyages$Voyages$Voyage.fromJson(
          Map<String, dynamic> json) =>
      _$VoyagesData$Query$Voyages$Voyages$VoyageFromJson(json);

  late DateTime dateFrom;

  DateTime? dateTo;

  String? id;

  late String voyageNumber;

  late VoyagesData$Query$Voyages$Voyages$Voyage$Arrival arrival;

  late VoyagesData$Query$Voyages$Voyages$Voyage$Departure departure;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props =>
      [dateFrom, dateTo, id, voyageNumber, arrival, departure, $$typename];
  @override
  Map<String, dynamic> toJson() =>
      _$VoyagesData$Query$Voyages$Voyages$VoyageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VoyagesData$Query$Voyages$Voyages extends JsonSerializable
    with EquatableMixin {
  VoyagesData$Query$Voyages$Voyages();

  factory VoyagesData$Query$Voyages$Voyages.fromJson(
          Map<String, dynamic> json) =>
      _$VoyagesData$Query$Voyages$VoyagesFromJson(json);

  late int numberOfReports;

  late VoyagesData$Query$Voyages$Voyages$Voyage voyage;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [numberOfReports, voyage, $$typename];
  @override
  Map<String, dynamic> toJson() =>
      _$VoyagesData$Query$Voyages$VoyagesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VoyagesData$Query$Voyages extends JsonSerializable with EquatableMixin {
  VoyagesData$Query$Voyages();

  factory VoyagesData$Query$Voyages.fromJson(Map<String, dynamic> json) =>
      _$VoyagesData$Query$VoyagesFromJson(json);

  late List<VoyagesData$Query$Voyages$Voyages> voyages;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [voyages, $$typename];
  @override
  Map<String, dynamic> toJson() => _$VoyagesData$Query$VoyagesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VoyagesData$Query extends JsonSerializable with EquatableMixin {
  VoyagesData$Query();

  factory VoyagesData$Query.fromJson(Map<String, dynamic> json) =>
      _$VoyagesData$QueryFromJson(json);

  late VoyagesData$Query$Voyages voyages;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [voyages, $$typename];
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

final VOYAGES_DATA_QUERY_DOCUMENT_OPERATION_NAME = 'VoyagesData';
final VOYAGES_DATA_QUERY_DOCUMENT = DocumentNode(definitions: [
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
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'arrival'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FragmentSpreadNode(
                                    name: NameNode(value: 'Dst'),
                                    directives: [])
                              ])),
                          FieldNode(
                              name: NameNode(value: 'departure'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FragmentSpreadNode(
                                    name: NameNode(value: 'Departure'),
                                    directives: [])
                              ]))
                        ]))
                  ]))
            ]))
      ])),
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
      ]))
]);

class VoyagesDataQuery
    extends GraphQLQuery<VoyagesData$Query, VoyagesDataArguments> {
  VoyagesDataQuery({required this.variables});

  @override
  final DocumentNode document = VOYAGES_DATA_QUERY_DOCUMENT;

  @override
  final String operationName = VOYAGES_DATA_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  final VoyagesDataArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  VoyagesData$Query parse(Map<String, dynamic> json) =>
      VoyagesData$Query.fromJson(json);
}
''';
