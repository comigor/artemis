// @dart = 2.8

import 'package:artemis/builder.dart';
import 'package:artemis/generator/data/enum_value_definition.dart';
import 'package:artemis/generator/data/data.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
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
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'__typename'),
                              annotations: [r'''JsonKey(name: '__typename')'''],
                              isNonNull: false,
                              isResolveType: true),
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'e'),
                              isNonNull: false,
                              isResolveType: false)
                        ],
                        factoryPossibilities: {},
                        typeNameField: TypeName(name: r'__typename'),
                        isInput: false),
                    ClassDefinition(
                        name: ClassName(name: r'Custom$_QueryRoot'),
                        properties: [
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'__typename'),
                              annotations: [r'''JsonKey(name: '__typename')'''],
                              isNonNull: false,
                              isResolveType: true),
                          ClassProperty(
                              type: TypeName(name: r'Custom$_QueryRoot$_q'),
                              name: ClassPropertyName(name: r'q'),
                              isNonNull: false,
                              isResolveType: false)
                        ],
                        factoryPossibilities: {},
                        typeNameField: TypeName(name: r'__typename'),
                        isInput: false)
                  ],
                  generateHelpers: false,
                  suffix: r'Query')
            ]),
            generatedFile: r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot$Q with EquatableMixin {
  Custom$QueryRoot$Q();

  factory Custom$QueryRoot$Q.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRoot$QFromJson(json);

  @JsonKey(name: '__typename')
  String $$typename;

  String e;

  @override
  List<Object> get props => [$$typename, e];
  Map<String, dynamic> toJson() => _$Custom$QueryRoot$QToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot with EquatableMixin {
  Custom$QueryRoot();

  factory Custom$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRootFromJson(json);

  @JsonKey(name: '__typename')
  String $$typename;

  Custom$QueryRoot$Q q;

  @override
  List<Object> get props => [$$typename, q];
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
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'__typename'),
                              annotations: [r'''JsonKey(name: '__typename')'''],
                              isNonNull: false,
                              isResolveType: true),
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'e'),
                              isNonNull: false,
                              isResolveType: false)
                        ],
                        factoryPossibilities: {},
                        typeNameField: TypeName(name: r'__typename'),
                        isInput: false),
                    ClassDefinition(
                        name: ClassName(name: r'Custom$_QueryRoot'),
                        properties: [
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'__typename'),
                              annotations: [r'''JsonKey(name: '__typename')'''],
                              isNonNull: false,
                              isResolveType: true),
                          ClassProperty(
                              type: TypeName(name: r'Custom$_QueryRoot$_q'),
                              name: ClassPropertyName(name: r'q'),
                              isNonNull: false,
                              isResolveType: false)
                        ],
                        factoryPossibilities: {},
                        typeNameField: TypeName(name: r'__typename'),
                        isInput: false)
                  ],
                  generateHelpers: false,
                  suffix: r'Query')
            ]),
            generatedFile: r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot$Q with EquatableMixin {
  Custom$QueryRoot$Q();

  factory Custom$QueryRoot$Q.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRoot$QFromJson(json);

  @JsonKey(name: '__typename')
  String $$typename;

  String e;

  @override
  List<Object> get props => [$$typename, e];
  Map<String, dynamic> toJson() => _$Custom$QueryRoot$QToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot with EquatableMixin {
  Custom$QueryRoot();

  factory Custom$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRootFromJson(json);

  @JsonKey(name: '__typename')
  String $$typename;

  Custom$QueryRoot$Q q;

  @override
  List<Object> get props => [$$typename, q];
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
                              isNonNull: false,
                              isResolveType: true)
                        ],
                        mixins: [FragmentName(name: r'QueryResponseMixin')],
                        factoryPossibilities: {},
                        typeNameField: TypeName(name: r'__typename'),
                        isInput: false),
                    ClassDefinition(
                        name: ClassName(name: r'Custom$_QueryRoot'),
                        properties: [
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'__typename'),
                              annotations: [r'''JsonKey(name: '__typename')'''],
                              isNonNull: false,
                              isResolveType: true),
                          ClassProperty(
                              type: TypeName(name: r'Custom$_QueryRoot$_q'),
                              name: ClassPropertyName(name: r'q'),
                              isNonNull: false,
                              isResolveType: false)
                        ],
                        factoryPossibilities: {},
                        typeNameField: TypeName(name: r'__typename'),
                        isInput: false),
                    FragmentClassDefinition(
                        name: FragmentName(name: r'QueryResponseMixin'),
                        properties: [
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'__typename'),
                              annotations: [r'''JsonKey(name: '__typename')'''],
                              isNonNull: false,
                              isResolveType: true),
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'e'),
                              isNonNull: false,
                              isResolveType: false)
                        ])
                  ],
                  generateHelpers: false,
                  suffix: r'Query')
            ]),
            generatedFile: r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

mixin QueryResponseMixin {
  @JsonKey(name: '__typename')
  String $$typename;
  String e;
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot$Q with EquatableMixin, QueryResponseMixin {
  Custom$QueryRoot$Q();

  factory Custom$QueryRoot$Q.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRoot$QFromJson(json);

  @JsonKey(name: '__typename')
  String $$typename;

  @override
  List<Object> get props => [$$typename, e, $$typename];
  Map<String, dynamic> toJson() => _$Custom$QueryRoot$QToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot with EquatableMixin {
  Custom$QueryRoot();

  factory Custom$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRootFromJson(json);

  @JsonKey(name: '__typename')
  String $$typename;

  Custom$QueryRoot$Q q;

  @override
  List<Object> get props => [$$typename, q];
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
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'__typename'),
                              annotations: [r'''JsonKey(name: '__typename')'''],
                              isNonNull: false,
                              isResolveType: true),
                          ClassProperty(
                              type: TypeName(name: r'int'),
                              name: ClassPropertyName(name: r'a'),
                              isNonNull: false,
                              isResolveType: false)
                        ],
                        extension: ClassName(name: r'Custom$_QueryRoot$_q'),
                        factoryPossibilities: {},
                        typeNameField: TypeName(name: r'__typename'),
                        isInput: false),
                    ClassDefinition(
                        name: ClassName(name: r'Custom$_QueryRoot$_q$_typeB'),
                        properties: [
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'__typename'),
                              annotations: [r'''JsonKey(name: '__typename')'''],
                              isNonNull: false,
                              isResolveType: true),
                          ClassProperty(
                              type: TypeName(name: r'int'),
                              name: ClassPropertyName(name: r'b'),
                              isNonNull: false,
                              isResolveType: false)
                        ],
                        extension: ClassName(name: r'Custom$_QueryRoot$_q'),
                        factoryPossibilities: {},
                        typeNameField: TypeName(name: r'__typename'),
                        isInput: false),
                    ClassDefinition(
                        name: ClassName(name: r'Custom$_QueryRoot$_q'),
                        properties: [
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'__typename'),
                              annotations: [r'''JsonKey(name: '__typename')'''],
                              isNonNull: false,
                              isResolveType: true)
                        ],
                        factoryPossibilities: {
                          r'TypeA':
                              ClassName(name: r'Custom$_QueryRoot$_q$_TypeA'),
                          r'TypeB':
                              ClassName(name: r'Custom$_QueryRoot$_q$_TypeB')
                        },
                        typeNameField: TypeName(name: r'__typename'),
                        isInput: false),
                    ClassDefinition(
                        name: ClassName(name: r'Custom$_QueryRoot'),
                        properties: [
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r'__typename'),
                              annotations: [r'''JsonKey(name: '__typename')'''],
                              isNonNull: false,
                              isResolveType: true),
                          ClassProperty(
                              type: TypeName(name: r'Custom$_QueryRoot$_q'),
                              name: ClassPropertyName(name: r'q'),
                              isNonNull: false,
                              isResolveType: false)
                        ],
                        factoryPossibilities: {},
                        typeNameField: TypeName(name: r'__typename'),
                        isInput: false)
                  ],
                  generateHelpers: false,
                  suffix: r'Query')
            ]),
            generatedFile: r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot$Q$TypeA extends Custom$QueryRoot$Q with EquatableMixin {
  Custom$QueryRoot$Q$TypeA();

  factory Custom$QueryRoot$Q$TypeA.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRoot$Q$TypeAFromJson(json);

  @JsonKey(name: '__typename')
  @override
  String $$typename;

  int a;

  @override
  List<Object> get props => [$$typename, a];
  Map<String, dynamic> toJson() => _$Custom$QueryRoot$Q$TypeAToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot$Q$TypeB extends Custom$QueryRoot$Q with EquatableMixin {
  Custom$QueryRoot$Q$TypeB();

  factory Custom$QueryRoot$Q$TypeB.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRoot$Q$TypeBFromJson(json);

  @JsonKey(name: '__typename')
  @override
  String $$typename;

  int b;

  @override
  List<Object> get props => [$$typename, b];
  Map<String, dynamic> toJson() => _$Custom$QueryRoot$Q$TypeBToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot$Q with EquatableMixin {
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
  String $$typename;

  @override
  List<Object> get props => [$$typename];
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
class Custom$QueryRoot with EquatableMixin {
  Custom$QueryRoot();

  factory Custom$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRootFromJson(json);

  @JsonKey(name: '__typename')
  String $$typename;

  Custom$QueryRoot$Q q;

  @override
  List<Object> get props => [$$typename, q];
  Map<String, dynamic> toJson() => _$Custom$QueryRootToJson(this);
}
''',
            generateHelpers: false));
  });
}
