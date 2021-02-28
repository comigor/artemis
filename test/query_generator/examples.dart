// @dart = 2.8

import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../helpers.dart';

void main() {
  test(
    'Example',
    () async => testGenerator(
      query: r'''
query {
  allCompanies {
    allEmployees {
      name
    }
    organizationalChart {
      cLevels {
        name
      }
    }
  }
}
        ''',
      schema: r'''
type Query {
  allCompanies: [Company!]
}

type Company {
  allEmployees: [Person!]
  organizationalChart: OrganizationalChart!
}

type OrganizationalChart {
  cLevels: [Person!]
}

type Person {
  name: String!
}
        ''',
      libraryDefinition: null,
      generatedFile: generatedFile,
      namingScheme: 'pathedWithFields',
    ),
  );
}

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

mixin MyFragmentMixin {
  String s;
  int i;
}

@JsonSerializable(explicitToJson: true)
class SomeObject with EquatableMixin, MyFragmentMixin {
  SomeObject();

  factory SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeObjectFromJson(json);

  @override
  List<Object> get props => [s, i];
  Map<String, dynamic> toJson() => _$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MoreData with EquatableMixin {
  MoreData();

  factory MoreData.fromJson(Map<String, dynamic> json) =>
      _$MoreDataFromJson(json);

  SomeObject someObject;

  @override
  List<Object> get props => [someObject];
  Map<String, dynamic> toJson() => _$MoreDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$QueryResponse with EquatableMixin {
  SomeQuery$QueryResponse();

  factory SomeQuery$QueryResponse.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$QueryResponseFromJson(json);

  SomeObject someObject;

  MoreData moreData;

  @override
  List<Object> get props => [someObject, moreData];
  Map<String, dynamic> toJson() => _$SomeQuery$QueryResponseToJson(this);
}
''';
