import 'package:artemis/generator/data.dart';
import 'package:test/test.dart';

import '../helpers.dart';

void main() {
  group('On union types', () {
    test(
      'On union types',
      () async => testGenerator(
        query: query,
        schema: graphQLSchema,
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
      ),
    );
  });
}

final String query = r'''
  query some_query { 
    o { 
      __typename, 
      ... on TypeA { 
        a 
      }, 
      ... on TypeB { 
        b 
      } 
    } 
  }
''';

final String graphQLSchema = '''
  schema {
    query: SomeObject
  }

  type SomeObject {
    o: SomeUnion
  }
  
  union SomeUnion = TypeA | TypeB
  
  type TypeA {
    a: Int
  }
  
  type TypeB {
    b: Int
  }
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      queryName: r'some_query',
      queryType: r'SomeQuery$SomeObject',
      classes: [
        ClassDefinition(
            name: r'SomeQuery$SomeObject$SomeUnion$TypeA',
            properties: [
              ClassProperty(
                  type: r'int',
                  name: r'a',
                  isNonNull: false,
                  isResolveType: false)
            ],
            extension: r'SomeQuery$SomeObject$SomeUnion',
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'SomeQuery$SomeObject$SomeUnion$TypeB',
            properties: [
              ClassProperty(
                  type: r'int',
                  name: r'b',
                  isNonNull: false,
                  isResolveType: false)
            ],
            extension: r'SomeQuery$SomeObject$SomeUnion',
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'SomeQuery$SomeObject$SomeUnion',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r'typeName',
                  annotations: [
                    r'override',
                    r'''JsonKey(name: '__typename')'''
                  ],
                  isNonNull: false,
                  isResolveType: true)
            ],
            factoryPossibilities: {
              r'TypeA': r'SomeQuery$SomeObject$SomeUnion$TypeA',
              r'TypeB': r'SomeQuery$SomeObject$SomeUnion$TypeB'
            },
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'SomeQuery$SomeObject',
            properties: [
              ClassProperty(
                  type: r'SomeQuery$SomeObject$SomeUnion',
                  name: r'o',
                  isNonNull: false,
                  isResolveType: false)
            ],
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
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery$SomeObject$SomeUnion$TypeA
    extends SomeQuery$SomeObject$SomeUnion with EquatableMixin {
  SomeQuery$SomeObject$SomeUnion$TypeA();

  factory SomeQuery$SomeObject$SomeUnion$TypeA.fromJson(
          Map<String, dynamic> json) =>
      _$SomeQuery$SomeObject$SomeUnion$TypeAFromJson(json);

  int a;

  @override
  List<Object> get props => [a];
  Map<String, dynamic> toJson() =>
      _$SomeQuery$SomeObject$SomeUnion$TypeAToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$SomeObject$SomeUnion$TypeB
    extends SomeQuery$SomeObject$SomeUnion with EquatableMixin {
  SomeQuery$SomeObject$SomeUnion$TypeB();

  factory SomeQuery$SomeObject$SomeUnion$TypeB.fromJson(
          Map<String, dynamic> json) =>
      _$SomeQuery$SomeObject$SomeUnion$TypeBFromJson(json);

  int b;

  @override
  List<Object> get props => [b];
  Map<String, dynamic> toJson() =>
      _$SomeQuery$SomeObject$SomeUnion$TypeBToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$SomeObject$SomeUnion with EquatableMixin {
  SomeQuery$SomeObject$SomeUnion();

  factory SomeQuery$SomeObject$SomeUnion.fromJson(Map<String, dynamic> json) {
    switch (json['__typename'].toString()) {
      case r'TypeA':
        return SomeQuery$SomeObject$SomeUnion$TypeA.fromJson(json);
      case r'TypeB':
        return SomeQuery$SomeObject$SomeUnion$TypeB.fromJson(json);
      default:
    }
    return _$SomeQuery$SomeObject$SomeUnionFromJson(json);
  }

  @override
  @JsonKey(name: '__typename')
  String typeName;

  @override
  List<Object> get props => [typeName];
  Map<String, dynamic> toJson() {
    switch (typeName) {
      case r'TypeA':
        return (this as SomeQuery$SomeObject$SomeUnion$TypeA).toJson();
      case r'TypeB':
        return (this as SomeQuery$SomeObject$SomeUnion$TypeB).toJson();
      default:
    }
    return _$SomeQuery$SomeObject$SomeUnionToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$SomeObject with EquatableMixin {
  SomeQuery$SomeObject();

  factory SomeQuery$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$SomeObjectFromJson(json);

  SomeQuery$SomeObject$SomeUnion o;

  @override
  List<Object> get props => [o];
  Map<String, dynamic> toJson() => _$SomeQuery$SomeObjectToJson(this);
}
''';
