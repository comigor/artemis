import 'package:artemis/builder.dart';
import 'package:artemis/generator/data/annotation.dart';
import 'package:build/build.dart';
import 'package:artemis/generator/data/data.dart';
import 'package:artemis/generator/data/enum_value_definition.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

void main() {
  group('Multiple schema mapping', () {
    test(
      'Should search for definitions in correct schema',
      () async {
        final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
          'generate_helpers': true,
          'schema_mapping': [
            {
              'schema': 'schemaA.graphql',
              'queries_glob': 'queries/queryA.graphql',
              'output': 'lib/outputA.graphql.dart',
              'naming_scheme': 'pathedWithFields',
            },
            {
              'schema': 'schemaB.graphql',
              'queries_glob': 'queries/queryB.graphql',
              'output': 'lib/outputB.graphql.dart',
              'naming_scheme': 'pathedWithFields',
            }
          ],
        }));

        var count = 0;
        anotherBuilder.onBuild = expectAsync1((definition) {
          log.fine(definition);
          if (count == 0) {
            expect(definition, libraryDefinitionA);
          }

          if (count == 1) {
            expect(definition, libraryDefinitionB);
          }

          count++;
        }, count: 2);

        return await testBuilder(
          anotherBuilder,
          {
            'a|schemaA.graphql': schemaA,
            'a|schemaB.graphql': schemaB,
            'a|queries/queryA.graphql': queryA,
            'a|queries/queryB.graphql': queryB,
          },
          outputs: {
            'a|lib/outputA.graphql.dart': generatedFileA,
            'a|lib/outputB.graphql.dart': generatedFileB,
          },
          onLog: print,
        );
      },
    );
  });
}

const schemaA = r'''
  schema {
    query: Query
  }
  
  type Query {
      articles: [Article!]
  }
  
  type Article {
    id: ID!
    title: String!
    articleType: ArticleType!
  }
  
  enum ArticleType {
    NEWS
    TUTORIAL
  }
''';

const schemaB = r'''
  schema {
    query: Query
  }
  
  type Query {
      repositories(notificationTypes: [NotificationOptionInput]): [Repository!]
  }
  
  type Repository {
    id: ID!
    title: String!
    privacy: Privacy!
    status: Status!
  }
  
  enum Privacy {
    PRIVATE
    PUBLIC
  }
  
  enum Status {
    ARCHIVED
    NORMAL
  }
  
  input NotificationOptionInput {
    type: NotificationType
    enabled: Boolean
  }
  
  enum NotificationType {
    ACTIVITY_MESSAGE
    ACTIVITY_REPLY
    FOLLOWING
    ACTIVITY_MENTION
  }
''';

const queryA = r'''
  query BrowseArticles {
    articles {
        id
        title
        articleType
    }
  }
''';

const queryB = r'''
  query BrowseRepositories($notificationTypes: [NotificationOptionInput]) {
    repositories(notificationTypes: $notificationTypes) {
        id
        title
        privacy
        status
    }
  }
''';

final LibraryDefinition libraryDefinitionA =
    LibraryDefinition(basename: r'outputA.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'BrowseArticles$_Query'),
      operationName: r'BrowseArticles',
      classes: [
        EnumDefinition(name: EnumName(name: r'ArticleType'), values: [
          EnumValueDefinition(name: EnumValueName(name: r'NEWS')),
          EnumValueDefinition(name: EnumValueName(name: r'TUTORIAL')),
          EnumValueDefinition(name: EnumValueName(name: r'ARTEMIS_UNKNOWN'))
        ]),
        ClassDefinition(
            name: ClassName(name: r'BrowseArticles$_Query$_articles'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'id'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'title'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'ArticleType', isNonNull: true),
                  name: ClassPropertyName(name: r'articleType'),
                  annotations: [
                    JsonKeyAnnotation(
                        jsonKey: JsonKeyItem(
                            unknownEnumValue: r'ArticleType.artemisUnknown'))
                  ],
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'BrowseArticles$_Query'),
            properties: [
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: TypeName(
                          name: r'BrowseArticles$_Query$_articles',
                          isNonNull: true),
                      isNonNull: false),
                  name: ClassPropertyName(name: r'articles'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false)
      ],
      generateHelpers: true,
      suffix: r'Query')
]);

final libraryDefinitionB =
    LibraryDefinition(basename: r'outputB.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'BrowseRepositories$_Query'),
      operationName: r'BrowseRepositories',
      classes: [
        EnumDefinition(name: EnumName(name: r'Privacy'), values: [
          EnumValueDefinition(name: EnumValueName(name: r'PRIVATE')),
          EnumValueDefinition(name: EnumValueName(name: r'PUBLIC')),
          EnumValueDefinition(name: EnumValueName(name: r'ARTEMIS_UNKNOWN'))
        ]),
        EnumDefinition(name: EnumName(name: r'Status'), values: [
          EnumValueDefinition(name: EnumValueName(name: r'ARCHIVED')),
          EnumValueDefinition(name: EnumValueName(name: r'NORMAL')),
          EnumValueDefinition(name: EnumValueName(name: r'ARTEMIS_UNKNOWN'))
        ]),
        EnumDefinition(name: EnumName(name: r'NotificationType'), values: [
          EnumValueDefinition(name: EnumValueName(name: r'ACTIVITY_MESSAGE')),
          EnumValueDefinition(name: EnumValueName(name: r'ACTIVITY_REPLY')),
          EnumValueDefinition(name: EnumValueName(name: r'FOLLOWING')),
          EnumValueDefinition(name: EnumValueName(name: r'ACTIVITY_MENTION')),
          EnumValueDefinition(name: EnumValueName(name: r'ARTEMIS_UNKNOWN'))
        ]),
        ClassDefinition(
            name: ClassName(name: r'BrowseRepositories$_Query$_repositories'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'id'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'title'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'Privacy', isNonNull: true),
                  name: ClassPropertyName(name: r'privacy'),
                  annotations: [
                    JsonKeyAnnotation(
                        jsonKey: JsonKeyItem(
                            unknownEnumValue: r'Privacy.artemisUnknown'))
                  ],
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'Status', isNonNull: true),
                  name: ClassPropertyName(name: r'status'),
                  annotations: [
                    JsonKeyAnnotation(
                        jsonKey: JsonKeyItem(
                            unknownEnumValue: r'Status.artemisUnknown'))
                  ],
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'BrowseRepositories$_Query'),
            properties: [
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: TypeName(
                          name: r'BrowseRepositories$_Query$_repositories',
                          isNonNull: true),
                      isNonNull: false),
                  name: ClassPropertyName(name: r'repositories'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'NotificationOptionInput'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'NotificationType'),
                  name: ClassPropertyName(name: r'type'),
                  annotations: [
                    JsonKeyAnnotation(
                        jsonKey: JsonKeyItem(
                            unknownEnumValue:
                                r'NotificationType.artemisUnknown'))
                  ],
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'bool'),
                  name: ClassPropertyName(name: r'enabled'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: true)
      ],
      inputs: [
        QueryInput(
            type: ListOfTypeName(
                typeName: TypeName(name: r'NotificationOptionInput'),
                isNonNull: false),
            name: QueryInputName(name: r'notificationTypes'))
      ],
      generateHelpers: true,
      suffix: r'Query')
]);

const generatedFileA = r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'outputA.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class BrowseArticles$Query$Articles extends JsonSerializable
    with EquatableMixin {
  BrowseArticles$Query$Articles();

  factory BrowseArticles$Query$Articles.fromJson(Map<String, dynamic> json) =>
      _$BrowseArticles$Query$ArticlesFromJson(json);

  late String id;

  late String title;

  @JsonKey(unknownEnumValue: ArticleType.artemisUnknown)
  late ArticleType articleType;

  @override
  List<Object?> get props => [id, title, articleType];
  @override
  Map<String, dynamic> toJson() => _$BrowseArticles$Query$ArticlesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BrowseArticles$Query extends JsonSerializable with EquatableMixin {
  BrowseArticles$Query();

  factory BrowseArticles$Query.fromJson(Map<String, dynamic> json) =>
      _$BrowseArticles$QueryFromJson(json);

  List<BrowseArticles$Query$Articles>? articles;

  @override
  List<Object?> get props => [articles];
  @override
  Map<String, dynamic> toJson() => _$BrowseArticles$QueryToJson(this);
}

enum ArticleType {
  @JsonValue('NEWS')
  news,
  @JsonValue('TUTORIAL')
  tutorial,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}
final BROWSE_ARTICLES_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'BrowseArticles'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'articles'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'title'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'articleType'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class BrowseArticlesQuery
    extends GraphQLQuery<BrowseArticles$Query, JsonSerializable> {
  BrowseArticlesQuery();

  @override
  final DocumentNode document = BROWSE_ARTICLES_QUERY_DOCUMENT;

  @override
  final String operationName = 'BrowseArticles';

  @override
  List<Object?> get props => [document, operationName];
  @override
  BrowseArticles$Query parse(Map<String, dynamic> json) =>
      BrowseArticles$Query.fromJson(json);
}
''';

const generatedFileB = r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'outputB.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class BrowseRepositories$Query$Repositories extends JsonSerializable
    with EquatableMixin {
  BrowseRepositories$Query$Repositories();

  factory BrowseRepositories$Query$Repositories.fromJson(
          Map<String, dynamic> json) =>
      _$BrowseRepositories$Query$RepositoriesFromJson(json);

  late String id;

  late String title;

  @JsonKey(unknownEnumValue: Privacy.artemisUnknown)
  late Privacy privacy;

  @JsonKey(unknownEnumValue: Status.artemisUnknown)
  late Status status;

  @override
  List<Object?> get props => [id, title, privacy, status];
  @override
  Map<String, dynamic> toJson() =>
      _$BrowseRepositories$Query$RepositoriesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BrowseRepositories$Query extends JsonSerializable with EquatableMixin {
  BrowseRepositories$Query();

  factory BrowseRepositories$Query.fromJson(Map<String, dynamic> json) =>
      _$BrowseRepositories$QueryFromJson(json);

  List<BrowseRepositories$Query$Repositories>? repositories;

  @override
  List<Object?> get props => [repositories];
  @override
  Map<String, dynamic> toJson() => _$BrowseRepositories$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NotificationOptionInput extends JsonSerializable with EquatableMixin {
  NotificationOptionInput({this.type, this.enabled});

  factory NotificationOptionInput.fromJson(Map<String, dynamic> json) =>
      _$NotificationOptionInputFromJson(json);

  @JsonKey(unknownEnumValue: NotificationType.artemisUnknown)
  final NotificationType? type;

  final bool? enabled;

  @override
  List<Object?> get props => [type, enabled];
  @override
  Map<String, dynamic> toJson() => _$NotificationOptionInputToJson(this);
}

enum Privacy {
  @JsonValue('PRIVATE')
  private,
  @JsonValue('PUBLIC')
  public,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}
enum Status {
  @JsonValue('ARCHIVED')
  archived,
  @JsonValue('NORMAL')
  normal,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}
enum NotificationType {
  @JsonValue('ACTIVITY_MESSAGE')
  activityMessage,
  @JsonValue('ACTIVITY_REPLY')
  activityReply,
  @JsonValue('FOLLOWING')
  following,
  @JsonValue('ACTIVITY_MENTION')
  activityMention,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}

@JsonSerializable(explicitToJson: true)
class BrowseRepositoriesArguments extends JsonSerializable with EquatableMixin {
  BrowseRepositoriesArguments({this.notificationTypes});

  @override
  factory BrowseRepositoriesArguments.fromJson(Map<String, dynamic> json) =>
      _$BrowseRepositoriesArgumentsFromJson(json);

  final List<NotificationOptionInput?>? notificationTypes;

  @override
  List<Object?> get props => [notificationTypes];
  @override
  Map<String, dynamic> toJson() => _$BrowseRepositoriesArgumentsToJson(this);
}

final BROWSE_REPOSITORIES_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'BrowseRepositories'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'notificationTypes')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'NotificationOptionInput'),
                    isNonNull: false),
                isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'repositories'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'notificationTypes'),
                  value:
                      VariableNode(name: NameNode(value: 'notificationTypes')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'title'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'privacy'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'status'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class BrowseRepositoriesQuery extends GraphQLQuery<BrowseRepositories$Query,
    BrowseRepositoriesArguments> {
  BrowseRepositoriesQuery({required this.variables});

  @override
  final DocumentNode document = BROWSE_REPOSITORIES_QUERY_DOCUMENT;

  @override
  final String operationName = 'BrowseRepositories';

  @override
  final BrowseRepositoriesArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  BrowseRepositories$Query parse(Map<String, dynamic> json) =>
      BrowseRepositories$Query.fromJson(json);
}
''';
