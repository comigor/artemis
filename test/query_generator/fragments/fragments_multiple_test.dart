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
      queryName: r'some_query',
      queryType: r'SomeQuery$SomeObject',
      classes: [
        FragmentClassDefinition(
            name: r'SomeQuery$MyFragmentMixin',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r's',
                  isOverride: false,
                  isNonNull: false),
              ClassProperty(
                  type: r'int', name: r'i', isOverride: false, isNonNull: false)
            ]),
        ClassDefinition(
            name: r'SomeQuery$SomeObject',
            mixins: [r'SomeQuery$MyFragmentMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false)
      ],
      generateHelpers: false,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

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
class VoyagesData$Query$VoyageList$VoyageDetails$Voyage$VoyagesData$DstMixin
    with EquatableMixin, VoyagesData$DstMixin {
  VoyagesData$Query$VoyageList$VoyageDetails$Voyage$VoyagesData$DstMixin();

  factory VoyagesData$Query$VoyageList$VoyageDetails$Voyage$VoyagesData$DstMixin.fromJson(
          Map<String, dynamic> json) =>
      _$VoyagesData$Query$VoyageList$VoyageDetails$Voyage$VoyagesData$DstMixinFromJson(
          json);

  @override
  List<Object> get props => [id, name];
  Map<String, dynamic> toJson() =>
      _$VoyagesData$Query$VoyageList$VoyageDetails$Voyage$VoyagesData$DstMixinToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class VoyagesData$Query$VoyageList$VoyageDetails$Voyage$VoyagesData$DepartureMixin
    with EquatableMixin, VoyagesData$DepartureMixin {
  VoyagesData$Query$VoyageList$VoyageDetails$Voyage$VoyagesData$DepartureMixin();

  factory VoyagesData$Query$VoyageList$VoyageDetails$Voyage$VoyagesData$DepartureMixin.fromJson(
          Map<String, dynamic> json) =>
      _$VoyagesData$Query$VoyageList$VoyageDetails$Voyage$VoyagesData$DepartureMixinFromJson(
          json);

  @override
  List<Object> get props => [id];
  Map<String, dynamic> toJson() =>
      _$VoyagesData$Query$VoyageList$VoyageDetails$Voyage$VoyagesData$DepartureMixinToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class VoyagesData$Query$VoyageList$VoyageDetails$ with EquatableMixin {
  VoyagesData$Query$VoyageList$VoyageDetails$();

  factory VoyagesData$Query$VoyageList$VoyageDetails$.fromJson(
          Map<String, dynamic> json) =>
      _$VoyagesData$Query$VoyageList$VoyageDetails$FromJson(json);

  VoyagesData$Query$VoyageList$VoyageDetails$Voyage$Destination arrival;

  VoyagesData$Query$VoyageList$VoyageDetails$Voyage$Destination visitPoint;

  DateTime dateFrom;

  DateTime dateTo;

  VoyagesData$Query$VoyageList$VoyageDetails$Voyage$Destination departure;

  String id;

  String voyageNumber;

  @override
  List<Object> get props =>
      [arrival, visitPoint, dateFrom, dateTo, departure, id, voyageNumber];
  Map<String, dynamic> toJson() =>
      _$VoyagesData$Query$VoyageList$VoyageDetails$ToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VoyagesData$Query$VoyageList$ with EquatableMixin {
  VoyagesData$Query$VoyageList$();

  factory VoyagesData$Query$VoyageList$.fromJson(Map<String, dynamic> json) =>
      _$VoyagesData$Query$VoyageList$FromJson(json);

  int numberOfReports;

  VoyagesData$Query$VoyageList$VoyageDetails$Voyage voyage;

  @override
  List<Object> get props => [numberOfReports, voyage];
  Map<String, dynamic> toJson() => _$VoyagesData$Query$VoyageList$ToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VoyagesData$Query$ with EquatableMixin {
  VoyagesData$Query$();

  factory VoyagesData$Query$.fromJson(Map<String, dynamic> json) =>
      _$VoyagesData$Query$FromJson(json);

  List<VoyagesData$Query$VoyageList$VoyageDetails> voyages;

  @override
  List<Object> get props => [voyages];
  Map<String, dynamic> toJson() => _$VoyagesData$Query$ToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VoyagesData$ with EquatableMixin {
  VoyagesData$();

  factory VoyagesData$.fromJson(Map<String, dynamic> json) =>
      _$VoyagesData$FromJson(json);

  VoyagesData$Query$VoyageList voyages;

  @override
  List<Object> get props => [voyages];
  Map<String, dynamic> toJson() => _$VoyagesData$ToJson(this);
}
''';
