// @dart = 2.8

import 'package:artemis/generator/data/data.dart';
import 'package:artemis/generator/data/enum_value_definition.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('Simple naming', () {
    test(
      'Casing will be converted accordingly (and JsonKey names willb e populated accordingly)',
      () async => testGenerator(
        query: r'''
          query ClientEventsData {
            clientEvents {
              items {
                type
              }
            }
          }
          
         
''',
        schema: r'''
          type ClientEvent {
            type: Int!
          }
          
          type ClientEventItem {
            type: Int!
          }
          
          type ClientEventPage {
            items: [ClientEventItem!]!
            totalCount: Int!
          }
          
          type ClientPage {
            totalCount: Int!
          }
          
          type Query {
            clientEvents: ClientEventPage!
            clients: ClientPage!
          }

        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        generateHelpers: true,
        namingScheme: 'simple',
      ),
    );
  });
}

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'ClientEventsData$_Query'),
      operationName: r'ClientEventsData',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'ClientEventItem'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'int'),
                  name: ClassPropertyName(name: r'type'),
                  isNonNull: true,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'ClientEventPage'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'List<ClientEventItem>'),
                  name: ClassPropertyName(name: r'items'),
                  isNonNull: true,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'ClientEventsData$_Query'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'ClientEventPage'),
                  name: ClassPropertyName(name: r'clientEvents'),
                  isNonNull: true,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false)
      ],
      generateHelpers: true,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class ClientEventItem with EquatableMixin {
  ClientEventItem();

  factory ClientEventItem.fromJson(Map<String, dynamic> json) =>
      _$ClientEventItemFromJson(json);

  int type;

  @override
  List<Object> get props => [type];
  Map<String, dynamic> toJson() => _$ClientEventItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ClientEventPage with EquatableMixin {
  ClientEventPage();

  factory ClientEventPage.fromJson(Map<String, dynamic> json) =>
      _$ClientEventPageFromJson(json);

  List<ClientEventItem> items;

  @override
  List<Object> get props => [items];
  Map<String, dynamic> toJson() => _$ClientEventPageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ClientEventsData$Query with EquatableMixin {
  ClientEventsData$Query();

  factory ClientEventsData$Query.fromJson(Map<String, dynamic> json) =>
      _$ClientEventsData$QueryFromJson(json);

  ClientEventPage clientEvents;

  @override
  List<Object> get props => [clientEvents];
  Map<String, dynamic> toJson() => _$ClientEventsData$QueryToJson(this);
}

class ClientEventsDataQuery
    extends GraphQLQuery<ClientEventsData$Query, JsonSerializable> {
  ClientEventsDataQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'ClientEventsData'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'clientEvents'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'items'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                          name: NameNode(value: 'type'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null)
                    ]))
              ]))
        ]))
  ]);

  @override
  final String operationName = 'ClientEventsData';

  @override
  List<Object> get props => [document, operationName];
  @override
  ClientEventsData$Query parse(Map<String, dynamic> json) =>
      ClientEventsData$Query.fromJson(json);
}
''';
