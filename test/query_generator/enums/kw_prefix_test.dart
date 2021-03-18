// @dart = 2.8

import 'package:artemis/generator/data/data.dart';
import 'package:artemis/generator/data/enum_value_definition.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On enums', () {
    test(
      'Should correctly proceed enum fields with `kw` prefix',
      () async => testGenerator(
        query: query,
        schema: r'''
          type Query {
            articles(titleWhere: ArticleTitleWhereConditions): [Article!]
          }
          
          input ArticleTitleWhereConditions {
            operator: SQLOperator
            value: String
          }
          
          type Article {
            id: ID!
            title: String!
          }
          
          enum SQLOperator {
            EQ
            IN
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
      ),
    );
  });
}

const query = r'''
  query SearchArticles($titleWhere: ArticleTitleWhereConditions) {
    articles(titleWhere: $titleWhere) {
        id
        title
    }
  }
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'SearchArticles$_Query'),
      operationName: r'SearchArticles',
      classes: [
        EnumDefinition(name: EnumName(name: r'SQLOperator'), values: [
          EnumValueDefinition(name: EnumValueName(name: r'EQ')),
          EnumValueDefinition(name: EnumValueName(name: r'IN')),
          EnumValueDefinition(name: EnumValueName(name: r'ARTEMIS_UNKNOWN'))
        ]),
        ClassDefinition(
            name: ClassName(name: r'SearchArticles$_Query$_Article'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'id'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'title'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'SearchArticles$_Query'),
            properties: [
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: TypeName(
                          name: r'SearchArticles$_Query$_Article',
                          isNonNull: true),
                      isNonNull: false),
                  name: ClassPropertyName(name: r'articles'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'ArticleTitleWhereConditions'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'SQLOperator'),
                  name: ClassPropertyName(name: r'operator'),
                  annotations: [
                    r'''JsonKey(name: 'operator', unknownEnumValue: SQLOperator.artemisUnknown)'''
                  ],
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'value'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: true)
      ],
      inputs: [
        QueryInput(
            type: TypeName(name: r'ArticleTitleWhereConditions'),
            name: QueryInputName(name: r'titleWhere'))
      ],
      generateHelpers: false,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchArticles$Query$Article extends JsonSerializable
    with EquatableMixin {
  SearchArticles$Query$Article();

  factory SearchArticles$Query$Article.fromJson(Map<String, dynamic> json) =>
      _$SearchArticles$Query$ArticleFromJson(json);

  late String id;

  late String title;

  @override
  List<Object?> get props => [id, title];
  Map<String, dynamic> toJson() => _$SearchArticles$Query$ArticleToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SearchArticles$Query extends JsonSerializable with EquatableMixin {
  SearchArticles$Query();

  factory SearchArticles$Query.fromJson(Map<String, dynamic> json) =>
      _$SearchArticles$QueryFromJson(json);

  List<SearchArticles$Query$Article>? articles;

  @override
  List<Object?> get props => [articles];
  Map<String, dynamic> toJson() => _$SearchArticles$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ArticleTitleWhereConditions extends JsonSerializable with EquatableMixin {
  ArticleTitleWhereConditions({this.kw$operator, this.value});

  factory ArticleTitleWhereConditions.fromJson(Map<String, dynamic> json) =>
      _$ArticleTitleWhereConditionsFromJson(json);

  @JsonKey(name: 'operator', unknownEnumValue: SQLOperator.artemisUnknown)
  SQLOperator? kw$operator;

  String? value;

  @override
  List<Object?> get props => [kw$operator, value];
  Map<String, dynamic> toJson() => _$ArticleTitleWhereConditionsToJson(this);
}

enum SQLOperator {
  @JsonValue('EQ')
  eq,
  @JsonValue('IN')
  kw$IN,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}
''';
