import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('Simple naming', () {
    test(
      'Casing will be converted accordingly (and JsonKey names will be populated accordingly)',
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
                  type: DartTypeName(name: r'int', isNonNull: true),
                  name: ClassPropertyName(name: r'type'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'ClientEventPage'),
            properties: [
              ClassProperty(
                  type: ListOfTypeName(
                      typeName:
                          TypeName(name: r'ClientEventItem', isNonNull: true),
                      isNonNull: true),
                  name: ClassPropertyName(name: r'items'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'ClientEventsData$_Query'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'ClientEventPage', isNonNull: true),
                  name: ClassPropertyName(name: r'clientEvents'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false)
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
class ClientEventItem extends JsonSerializable with EquatableMixin {
  ClientEventItem();

  factory ClientEventItem.fromJson(Map<String, dynamic> json) =>
      _$ClientEventItemFromJson(json);

  late int type;

  @override
  List<Object?> get props => [type];
  @override
  Map<String, dynamic> toJson() => _$ClientEventItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ClientEventPage extends JsonSerializable with EquatableMixin {
  ClientEventPage();

  factory ClientEventPage.fromJson(Map<String, dynamic> json) =>
      _$ClientEventPageFromJson(json);

  late List<ClientEventItem> items;

  @override
  List<Object?> get props => [items];
  @override
  Map<String, dynamic> toJson() => _$ClientEventPageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ClientEventsData$Query extends JsonSerializable with EquatableMixin {
  ClientEventsData$Query();

  factory ClientEventsData$Query.fromJson(Map<String, dynamic> json) =>
      _$ClientEventsData$QueryFromJson(json);

  late ClientEventPage clientEvents;

  @override
  List<Object?> get props => [clientEvents];
  @override
  Map<String, dynamic> toJson() => _$ClientEventsData$QueryToJson(this);
}

final CLIENT_EVENTS_DATA_QUERY_DOCUMENT_OPERATION_NAME = 'ClientEventsData';
final CLIENT_EVENTS_DATA_QUERY_DOCUMENT = DocumentNode(definitions: [
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

class ClientEventsDataQuery
    extends GraphQLQuery<ClientEventsData$Query, JsonSerializable> {
  ClientEventsDataQuery();

  @override
  final DocumentNode document = CLIENT_EVENTS_DATA_QUERY_DOCUMENT;

  @override
  final String operationName = CLIENT_EVENTS_DATA_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  List<Object?> get props => [document, operationName];
  @override
  ClientEventsData$Query parse(Map<String, dynamic> json) =>
      ClientEventsData$Query.fromJson(json);
}
''';
