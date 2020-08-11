// @dart = 2.8

import 'package:artemis/generator/data/data.dart';
import 'package:artemis/generator/data/enum_value_definition.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On enums', () {
    test(
      'List of enums as input',
      () async => testGenerator(
        query: query,
        schema: r'''
          schema {
            query: Query
          }
          
          type Query {
            articles(article_type_in: [ArticleType!]): [Article!]
          }
          
          type Article {
            id: ID!
            title: String!
            article_type: ArticleType!
          }
          
          enum ArticleType {
            NEWS
            TUTORIAL
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
  query BrowseArticles($article_type_in: [ArticleType!]) {
    articles(article_type_in: $article_type_in) {
        id
        title
        article_type
    }
  }
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
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
            name: ClassName(name: r'BrowseArticles$_Query$_Article'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'id'),
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'title'),
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'ArticleType'),
                  name: ClassPropertyName(name: r'article_type'),
                  annotations: [
                    r'JsonKey(unknownEnumValue: ArticleType.artemisUnknown)',
                    r'''JsonKey(name: 'article_type')'''
                  ],
                  isNonNull: true,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'BrowseArticles$_Query'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'List<BrowseArticles$Query$Article>'),
                  name: ClassPropertyName(name: r'articles'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false)
      ],
      inputs: [
        QueryInput(
            type: TypeName(name: r'List<ArticleType>'),
            name: QueryInputName(name: r'article_type_in'),
            isNonNull: false)
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
class BrowseArticles$Query$Article with EquatableMixin {
  BrowseArticles$Query$Article();

  factory BrowseArticles$Query$Article.fromJson(Map<String, dynamic> json) =>
      _$BrowseArticles$Query$ArticleFromJson(json);

  String id;

  String title;

  @JsonKey(unknownEnumValue: ArticleType.artemisUnknown)
  @JsonKey(name: 'article_type')
  ArticleType articleType;

  @override
  List<Object> get props => [id, title, articleType];
  Map<String, dynamic> toJson() => _$BrowseArticles$Query$ArticleToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BrowseArticles$Query with EquatableMixin {
  BrowseArticles$Query();

  factory BrowseArticles$Query.fromJson(Map<String, dynamic> json) =>
      _$BrowseArticles$QueryFromJson(json);

  List<BrowseArticles$Query$Article> articles;

  @override
  List<Object> get props => [articles];
  Map<String, dynamic> toJson() => _$BrowseArticles$QueryToJson(this);
}

enum ArticleType {
  @JsonValue("NEWS")
  news,
  @JsonValue("TUTORIAL")
  tutorial,
  @JsonValue("ARTEMIS_UNKNOWN")
  artemisUnknown,
}

@JsonSerializable(explicitToJson: true)
class BrowseArticlesArguments extends JsonSerializable with EquatableMixin {
  BrowseArticlesArguments({this.article_type_in});

  factory BrowseArticlesArguments.fromJson(Map<String, dynamic> json) =>
      _$BrowseArticlesArgumentsFromJson(json);

  final List<ArticleType> article_type_in;

  @override
  List<Object> get props => [article_type_in];
  Map<String, dynamic> toJson() => _$BrowseArticlesArgumentsToJson(this);
}

class BrowseArticlesQuery
    extends GraphQLQuery<BrowseArticles$Query, BrowseArticlesArguments> {
  BrowseArticlesQuery({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'BrowseArticles'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'article_type_in')),
              type: ListTypeNode(
                  type: NamedTypeNode(
                      name: NameNode(value: 'ArticleType'), isNonNull: true),
                  isNonNull: false),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'articles'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'article_type_in'),
                    value:
                        VariableNode(name: NameNode(value: 'article_type_in')))
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
                    name: NameNode(value: 'article_type'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'BrowseArticles';

  @override
  final BrowseArticlesArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  BrowseArticles$Query parse(Map<String, dynamic> json) =>
      BrowseArticles$Query.fromJson(json);
}
''';
