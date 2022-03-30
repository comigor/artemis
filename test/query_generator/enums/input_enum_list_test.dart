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
                  type: DartTypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'id'),
                  isResolveType: false),
              ClassProperty(
                  type: DartTypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'title'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'ArticleType', isNonNull: true),
                  name: ClassPropertyName(name: r'article_type'),
                  annotations: [
                    r'''JsonKey(name: 'article_type', unknownEnumValue: ArticleType.artemisUnknown)'''
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
                          name: r'BrowseArticles$_Query$_Article',
                          isNonNull: true),
                      isNonNull: false),
                  name: ClassPropertyName(name: r'articles'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false)
      ],
      inputs: [
        QueryInput(
            type: ListOfTypeName(
                typeName: TypeName(name: r'ArticleType', isNonNull: true),
                isNonNull: false),
            name: QueryInputName(name: r'article_type_in'),
            annotations: [
              r'JsonKey(unknownEnumValue: ArticleType.artemisUnknown)'
            ])
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
class BrowseArticles$Query$Article extends JsonSerializable
    with EquatableMixin {
  BrowseArticles$Query$Article();

  factory BrowseArticles$Query$Article.fromJson(Map<String, dynamic> json) =>
      _$BrowseArticles$Query$ArticleFromJson(json);

  late String id;

  late String title;

  @JsonKey(name: 'article_type', unknownEnumValue: ArticleType.artemisUnknown)
  late ArticleType articleType;

  @override
  List<Object?> get props => [id, title, articleType];
  @override
  Map<String, dynamic> toJson() => _$BrowseArticles$Query$ArticleToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BrowseArticles$Query extends JsonSerializable with EquatableMixin {
  BrowseArticles$Query();

  factory BrowseArticles$Query.fromJson(Map<String, dynamic> json) =>
      _$BrowseArticles$QueryFromJson(json);

  List<BrowseArticles$Query$Article>? articles;

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

@JsonSerializable(explicitToJson: true)
class BrowseArticlesArguments extends JsonSerializable with EquatableMixin {
  BrowseArticlesArguments({this.article_type_in});

  @override
  factory BrowseArticlesArguments.fromJson(Map<String, dynamic> json) =>
      _$BrowseArticlesArgumentsFromJson(json);

  @JsonKey(unknownEnumValue: ArticleType.artemisUnknown)
  final List<ArticleType>? article_type_in;

  @override
  List<Object?> get props => [article_type_in];
  @override
  Map<String, dynamic> toJson() => _$BrowseArticlesArgumentsToJson(this);
}

final BROWSE_ARTICLES_QUERY_DOCUMENT_OPERATION_NAME = 'BrowseArticles';
final BROWSE_ARTICLES_QUERY_DOCUMENT = DocumentNode(definitions: [
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
                  value: VariableNode(name: NameNode(value: 'article_type_in')))
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

class BrowseArticlesQuery
    extends GraphQLQuery<BrowseArticles$Query, BrowseArticlesArguments> {
  BrowseArticlesQuery({required this.variables});

  @override
  final DocumentNode document = BROWSE_ARTICLES_QUERY_DOCUMENT;

  @override
  final String operationName = BROWSE_ARTICLES_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  final BrowseArticlesArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  BrowseArticles$Query parse(Map<String, dynamic> json) =>
      BrowseArticles$Query.fromJson(json);
}
''';
