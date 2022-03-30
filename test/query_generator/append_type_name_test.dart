import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../helpers.dart';

void main() {
  group('On query generation', () {
    test(
        'Appends typename',
        () async => testGenerator(
            appendTypeName: true,
            namingScheme: 'pathedWithFields',
            query: r'''
              query custom {
                q {
                  e
                }
              }
            ''',
            schema: r'''
            schema {
              query: QueryRoot
            }
            
            type QueryRoot {
              q: QueryResponse
            }
            
            type QueryResponse {
              e: String
            }
            ''',
            libraryDefinition:
                LibraryDefinition(basename: r'query.graphql', queries: [
              QueryDefinition(
                  name: QueryName(name: r'Custom$_QueryRoot'),
                  operationName: r'custom',
                  classes: [
                    ClassDefinition(
                        name: ClassName(name: r'Custom$_QueryRoot$_q'),
                        properties: [
                          ClassProperty(
                              type: DartTypeName(name: r'String'),
                              name: ClassPropertyName(name: r'e'),
                              isResolveType: false),
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'__typename'),
                              annotations: [r'''JsonKey(name: '__typename')'''],
                              isResolveType: true)
                        ],
                        factoryPossibilities: {},
                        typeNameField: ClassPropertyName(name: r'__typename'),
                        isInput: false),
                    ClassDefinition(
                        name: ClassName(name: r'Custom$_QueryRoot'),
                        properties: [
                          ClassProperty(
                              type: TypeName(name: r'Custom$_QueryRoot$_q'),
                              name: ClassPropertyName(name: r'q'),
                              isResolveType: false),
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'__typename'),
                              annotations: [r'''JsonKey(name: '__typename')'''],
                              isResolveType: true)
                        ],
                        factoryPossibilities: {},
                        typeNameField: ClassPropertyName(name: r'__typename'),
                        isInput: false)
                  ],
                  generateHelpers: false,
                  suffix: r'Query')
            ]),
            generatedFile: r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot$Q extends JsonSerializable with EquatableMixin {
  Custom$QueryRoot$Q();

  factory Custom$QueryRoot$Q.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRoot$QFromJson(json);

  String? e;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [e, $$typename];
  @override
  Map<String, dynamic> toJson() => _$Custom$QueryRoot$QToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot extends JsonSerializable with EquatableMixin {
  Custom$QueryRoot();

  factory Custom$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRootFromJson(json);

  Custom$QueryRoot$Q? q;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [q, $$typename];
  @override
  Map<String, dynamic> toJson() => _$Custom$QueryRootToJson(this);
}
''',
            generateHelpers: false));

    test(
        'Do not appends typename if it exist',
        () async => testGenerator(
            appendTypeName: true,
            namingScheme: 'pathedWithFields',
            query: r'''
              query custom {
                q {
                  e
                  __typename
                }
                __typename
              }
            ''',
            schema: r'''
            schema {
              query: QueryRoot
            }
            
            type QueryRoot {
              q: QueryResponse
            }
            
            type QueryResponse {
              e: String
            }
            ''',
            libraryDefinition:
                LibraryDefinition(basename: r'query.graphql', queries: [
              QueryDefinition(
                  name: QueryName(name: r'Custom$_QueryRoot'),
                  operationName: r'custom',
                  classes: [
                    ClassDefinition(
                        name: ClassName(name: r'Custom$_QueryRoot$_q'),
                        properties: [
                          ClassProperty(
                              type: DartTypeName(name: r'String'),
                              name: ClassPropertyName(name: r'e'),
                              isResolveType: false),
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'__typename'),
                              annotations: [r'''JsonKey(name: '__typename')'''],
                              isResolveType: true)
                        ],
                        factoryPossibilities: {},
                        typeNameField: ClassPropertyName(name: r'__typename'),
                        isInput: false),
                    ClassDefinition(
                        name: ClassName(name: r'Custom$_QueryRoot'),
                        properties: [
                          ClassProperty(
                              type: TypeName(name: r'Custom$_QueryRoot$_q'),
                              name: ClassPropertyName(name: r'q'),
                              isResolveType: false),
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'__typename'),
                              annotations: [r'''JsonKey(name: '__typename')'''],
                              isResolveType: true)
                        ],
                        factoryPossibilities: {},
                        typeNameField: ClassPropertyName(name: r'__typename'),
                        isInput: false)
                  ],
                  generateHelpers: false,
                  suffix: r'Query')
            ]),
            generatedFile: r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot$Q extends JsonSerializable with EquatableMixin {
  Custom$QueryRoot$Q();

  factory Custom$QueryRoot$Q.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRoot$QFromJson(json);

  String? e;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [e, $$typename];
  @override
  Map<String, dynamic> toJson() => _$Custom$QueryRoot$QToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot extends JsonSerializable with EquatableMixin {
  Custom$QueryRoot();

  factory Custom$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRootFromJson(json);

  Custom$QueryRoot$Q? q;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [q, $$typename];
  @override
  Map<String, dynamic> toJson() => _$Custom$QueryRootToJson(this);
}
''',
            generateHelpers: false));

    test(
        'Appends typename on fragment',
        () async => testGenerator(
            appendTypeName: true,
            namingScheme: 'pathedWithFields',
            query: r'''
              query custom {
                q {
                  ...QueryResponse
                }
              }
              
              fragment QueryResponse on QueryResponse {
                e
              }
            ''',
            schema: r'''
            schema {
              query: QueryRoot
            }
            
            type QueryRoot {
              q: QueryResponse
            }
            
            type QueryResponse {
              e: String
            }
            ''',
            libraryDefinition:
                LibraryDefinition(basename: r'query.graphql', queries: [
              QueryDefinition(
                  name: QueryName(name: r'Custom$_QueryRoot'),
                  operationName: r'custom',
                  classes: [
                    ClassDefinition(
                        name: ClassName(name: r'Custom$_QueryRoot$_q'),
                        properties: [
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'__typename'),
                              annotations: [r'''JsonKey(name: '__typename')'''],
                              isResolveType: true)
                        ],
                        mixins: [FragmentName(name: r'QueryResponseMixin')],
                        factoryPossibilities: {},
                        typeNameField: ClassPropertyName(name: r'__typename'),
                        isInput: false),
                    ClassDefinition(
                        name: ClassName(name: r'Custom$_QueryRoot'),
                        properties: [
                          ClassProperty(
                              type: TypeName(name: r'Custom$_QueryRoot$_q'),
                              name: ClassPropertyName(name: r'q'),
                              isResolveType: false),
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'__typename'),
                              annotations: [r'''JsonKey(name: '__typename')'''],
                              isResolveType: true)
                        ],
                        factoryPossibilities: {},
                        typeNameField: ClassPropertyName(name: r'__typename'),
                        isInput: false),
                    FragmentClassDefinition(
                        name: FragmentName(name: r'QueryResponseMixin'),
                        properties: [
                          ClassProperty(
                              type: DartTypeName(name: r'String'),
                              name: ClassPropertyName(name: r'e'),
                              isResolveType: false),
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'__typename'),
                              annotations: [r'''JsonKey(name: '__typename')'''],
                              isResolveType: true)
                        ])
                  ],
                  generateHelpers: false,
                  suffix: r'Query')
            ]),
            generatedFile: r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

mixin QueryResponseMixin {
  String? e;
  @JsonKey(name: '__typename')
  String? $$typename;
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot$Q extends JsonSerializable
    with EquatableMixin, QueryResponseMixin {
  Custom$QueryRoot$Q();

  factory Custom$QueryRoot$Q.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRoot$QFromJson(json);

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [e, $$typename];
  @override
  Map<String, dynamic> toJson() => _$Custom$QueryRoot$QToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot extends JsonSerializable with EquatableMixin {
  Custom$QueryRoot();

  factory Custom$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRootFromJson(json);

  Custom$QueryRoot$Q? q;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [q, $$typename];
  @override
  Map<String, dynamic> toJson() => _$Custom$QueryRootToJson(this);
}
''',
            generateHelpers: false));

    test(
        'Appends typename on union',
        () async => testGenerator(
            appendTypeName: true,
            namingScheme: 'pathedWithFields',
            query: r'''
              query custom {
                q {
                  ... on TypeA { 
                    a
                  }, 
                  ... on TypeB { 
                    b
                  }
                }
              }
            ''',
            schema: r'''
            schema {
              query: QueryRoot
            }
            
            type QueryRoot {
              q: SomeUnion
            }
            
            union SomeUnion = TypeA | TypeB
            
            type TypeA {
              a: Int
            }
            
            type TypeB {
              b: Int
            }
            ''',
            libraryDefinition:
                LibraryDefinition(basename: r'query.graphql', queries: [
              QueryDefinition(
                  name: QueryName(name: r'Custom$_QueryRoot'),
                  operationName: r'custom',
                  classes: [
                    ClassDefinition(
                        name: ClassName(name: r'Custom$_QueryRoot$_q$_typeA'),
                        properties: [
                          ClassProperty(
                              type: DartTypeName(name: r'int'),
                              name: ClassPropertyName(name: r'a'),
                              isResolveType: false),
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'__typename'),
                              annotations: [r'''JsonKey(name: '__typename')'''],
                              isResolveType: true)
                        ],
                        extension: ClassName(name: r'Custom$_QueryRoot$_q'),
                        factoryPossibilities: {},
                        typeNameField: ClassPropertyName(name: r'__typename'),
                        isInput: false),
                    ClassDefinition(
                        name: ClassName(name: r'Custom$_QueryRoot$_q$_typeB'),
                        properties: [
                          ClassProperty(
                              type: DartTypeName(name: r'int'),
                              name: ClassPropertyName(name: r'b'),
                              isResolveType: false),
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'__typename'),
                              annotations: [r'''JsonKey(name: '__typename')'''],
                              isResolveType: true)
                        ],
                        extension: ClassName(name: r'Custom$_QueryRoot$_q'),
                        factoryPossibilities: {},
                        typeNameField: ClassPropertyName(name: r'__typename'),
                        isInput: false),
                    ClassDefinition(
                        name: ClassName(name: r'Custom$_QueryRoot$_q'),
                        properties: [
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'__typename'),
                              annotations: [r'''JsonKey(name: '__typename')'''],
                              isResolveType: true)
                        ],
                        factoryPossibilities: {
                          r'TypeA':
                              ClassName(name: r'Custom$_QueryRoot$_q$_TypeA'),
                          r'TypeB':
                              ClassName(name: r'Custom$_QueryRoot$_q$_TypeB')
                        },
                        typeNameField: ClassPropertyName(name: r'__typename'),
                        isInput: false),
                    ClassDefinition(
                        name: ClassName(name: r'Custom$_QueryRoot'),
                        properties: [
                          ClassProperty(
                              type: TypeName(name: r'Custom$_QueryRoot$_q'),
                              name: ClassPropertyName(name: r'q'),
                              isResolveType: false),
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'__typename'),
                              annotations: [r'''JsonKey(name: '__typename')'''],
                              isResolveType: true)
                        ],
                        factoryPossibilities: {},
                        typeNameField: ClassPropertyName(name: r'__typename'),
                        isInput: false)
                  ],
                  generateHelpers: false,
                  suffix: r'Query')
            ]),
            generatedFile: r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot$Q$TypeA extends Custom$QueryRoot$Q with EquatableMixin {
  Custom$QueryRoot$Q$TypeA();

  factory Custom$QueryRoot$Q$TypeA.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRoot$Q$TypeAFromJson(json);

  int? a;

  @JsonKey(name: '__typename')
  @override
  String? $$typename;

  @override
  List<Object?> get props => [a, $$typename];
  @override
  Map<String, dynamic> toJson() => _$Custom$QueryRoot$Q$TypeAToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot$Q$TypeB extends Custom$QueryRoot$Q with EquatableMixin {
  Custom$QueryRoot$Q$TypeB();

  factory Custom$QueryRoot$Q$TypeB.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRoot$Q$TypeBFromJson(json);

  int? b;

  @JsonKey(name: '__typename')
  @override
  String? $$typename;

  @override
  List<Object?> get props => [b, $$typename];
  @override
  Map<String, dynamic> toJson() => _$Custom$QueryRoot$Q$TypeBToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot$Q extends JsonSerializable with EquatableMixin {
  Custom$QueryRoot$Q();

  factory Custom$QueryRoot$Q.fromJson(Map<String, dynamic> json) {
    switch (json['__typename'].toString()) {
      case r'TypeA':
        return Custom$QueryRoot$Q$TypeA.fromJson(json);
      case r'TypeB':
        return Custom$QueryRoot$Q$TypeB.fromJson(json);
      default:
    }
    return _$Custom$QueryRoot$QFromJson(json);
  }

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [$$typename];
  @override
  Map<String, dynamic> toJson() {
    switch ($$typename) {
      case r'TypeA':
        return (this as Custom$QueryRoot$Q$TypeA).toJson();
      case r'TypeB':
        return (this as Custom$QueryRoot$Q$TypeB).toJson();
      default:
    }
    return _$Custom$QueryRoot$QToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot extends JsonSerializable with EquatableMixin {
  Custom$QueryRoot();

  factory Custom$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRootFromJson(json);

  Custom$QueryRoot$Q? q;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [q, $$typename];
  @override
  Map<String, dynamic> toJson() => _$Custom$QueryRootToJson(this);
}
''',
            generateHelpers: false));

    test(
      'Appends typename to common fragments',
      () async => testGenerator(
        appendTypeName: true,
        query: r'''
          query custom {
            q {
              ...QueryResponse
            }
          }
        ''',
        schema: r'''
          schema {
            query: QueryRoot
          }
          
          type QueryRoot {
            q: QueryResponse
          }
          
          type QueryResponse {
            e: String
          }
        ''',
        libraryDefinition:
            LibraryDefinition(basename: r'query.graphql', queries: [
          QueryDefinition(
              name: QueryName(name: r'Custom$_QueryRoot'),
              operationName: r'custom',
              classes: [
                ClassDefinition(
                    name: ClassName(name: r'Custom$_QueryRoot$_QueryResponse'),
                    properties: [
                      ClassProperty(
                          type: TypeName(name: r'String'),
                          name: ClassPropertyName(name: r'__typename'),
                          annotations: [r'''JsonKey(name: '__typename')'''],
                          isResolveType: true)
                    ],
                    mixins: [FragmentName(name: r'QueryResponseMixin')],
                    factoryPossibilities: {},
                    typeNameField: ClassPropertyName(name: r'__typename'),
                    isInput: false),
                ClassDefinition(
                    name: ClassName(name: r'Custom$_QueryRoot'),
                    properties: [
                      ClassProperty(
                          type: TypeName(
                              name: r'Custom$_QueryRoot$_QueryResponse'),
                          name: ClassPropertyName(name: r'q'),
                          isResolveType: false),
                      ClassProperty(
                          type: TypeName(name: r'String'),
                          name: ClassPropertyName(name: r'__typename'),
                          annotations: [r'''JsonKey(name: '__typename')'''],
                          isResolveType: true)
                    ],
                    factoryPossibilities: {},
                    typeNameField: ClassPropertyName(name: r'__typename'),
                    isInput: false),
                FragmentClassDefinition(
                    name: FragmentName(name: r'QueryResponseMixin'),
                    properties: [
                      ClassProperty(
                          type: DartTypeName(name: r'String'),
                          name: ClassPropertyName(name: r'e'),
                          isResolveType: false),
                      ClassProperty(
                          type: TypeName(name: r'String'),
                          name: ClassPropertyName(name: r'__typename'),
                          annotations: [r'''JsonKey(name: '__typename')'''],
                          isResolveType: true)
                    ])
              ],
              generateHelpers: true,
              suffix: r'Query')
        ]),
        generatedFile: r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

mixin QueryResponseMixin {
  String? e;
  @JsonKey(name: '__typename')
  String? $$typename;
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot$QueryResponse extends JsonSerializable
    with EquatableMixin, QueryResponseMixin {
  Custom$QueryRoot$QueryResponse();

  factory Custom$QueryRoot$QueryResponse.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRoot$QueryResponseFromJson(json);

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [e, $$typename];
  @override
  Map<String, dynamic> toJson() => _$Custom$QueryRoot$QueryResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot extends JsonSerializable with EquatableMixin {
  Custom$QueryRoot();

  factory Custom$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRootFromJson(json);

  Custom$QueryRoot$QueryResponse? q;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [q, $$typename];
  @override
  Map<String, dynamic> toJson() => _$Custom$QueryRootToJson(this);
}

final CUSTOM_QUERY_DOCUMENT_OPERATION_NAME = 'custom';
final CUSTOM_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'custom'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'q'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'QueryResponse'), directives: []),
              FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'QueryResponse'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'QueryResponse'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'e'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class CustomQuery extends GraphQLQuery<Custom$QueryRoot, JsonSerializable> {
  CustomQuery();

  @override
  final DocumentNode document = CUSTOM_QUERY_DOCUMENT;

  @override
  final String operationName = CUSTOM_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  List<Object?> get props => [document, operationName];
  @override
  Custom$QueryRoot parse(Map<String, dynamic> json) =>
      Custom$QueryRoot.fromJson(json);
}
''',
        builderOptionsMap: {'fragments_glob': '**.frag'},
        sourceAssetsMap: {
          'a|fragment.frag': r'''
          fragment QueryResponse on QueryResponse {
            e
          }
        '''
        },
        generateHelpers: true,
      ),
    );
  });
}
