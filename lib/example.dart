// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

class Data {
  String? address;
}
class Person {
  String? name;
}

// query/all_companies.dart
mixin ToCanonical<T> {
  T _internal;
  T toCanonical();
}

class AllEmployees$Data {
  Data toData() {

  }
}

mixin Obj {
  int a;
}

// 
List<CLevels> getAll() {

}

Obj fn() {}

@JsonSerializable(explicitToJson: true)
class AllEmployees with EquatableMixin, ToCanonical<Person>, Obj {
  Query$Query$AllCompanies$AllEmployees();

  factory Query$Query$AllCompanies$AllEmployees.fromJson(
          Map<String, dynamic> json) =>
      _$Query$Query$AllCompanies$AllEmployeesFromJson(json);

  String name;
  AllEmployees$Data data;

  Person toCanonical() {
    if (_internal !=null) return _internal;
    _internal = Person(name: name, data: data.toData());
    return _internal;
  }

  @override
  List<Object> get props => [name];
  Map<String, dynamic> toJson() =>
      _$Query$Query$AllCompanies$AllEmployeesToJson(this);
}

// query/organizational_chart.dart
@JsonSerializable(explicitToJson: true)
class CLevels with EquatableMixin {
  Query$Query$AllCompanies$OrganizationalChart$CLevels();

  factory Query$Query$AllCompanies$OrganizationalChart$CLevels.fromJson(
          Map<String, dynamic> json) =>
      _$Query$Query$AllCompanies$OrganizationalChart$CLevelsFromJson(json);

  String name;
  CLevels$Data data;

  @override
  List<Object> get props => [name];
  Map<String, dynamic> toJson() =>
      _$Query$Query$AllCompanies$OrganizationalChart$CLevelsToJson(this);
}

import 'query/all_companies.dart' as all_companies
import 'query/organizational_chart.dart' as organizational_chart

p1.Person
p2.Person

@JsonSerializable(explicitToJson: true)
class Query$Query$AllCompanies$OrganizationalChart with EquatableMixin {
  Query$Query$AllCompanies$OrganizationalChart();

  factory Query$Query$AllCompanies$OrganizationalChart.fromJson(
          Map<String, dynamic> json) =>
      _$Query$Query$AllCompanies$OrganizationalChartFromJson(json);

  List<Query$Query$AllCompanies$OrganizationalChart$CLevels> cLevels;

  @override
  List<Object> get props => [cLevels];
  Map<String, dynamic> toJson() =>
      _$Query$Query$AllCompanies$OrganizationalChartToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Query$Query$AllCompanies with EquatableMixin {
  Query$Query$AllCompanies();

  factory Query$Query$AllCompanies.fromJson(Map<String, dynamic> json) =>
      _$Query$Query$AllCompaniesFromJson(json);

  List<Query$Query$AllCompanies$AllEmployees> allEmployees;

  Query$Query$AllCompanies$OrganizationalChart organizationalChart;

  @override
  List<Object> get props => [allEmployees, organizationalChart];
  Map<String, dynamic> toJson() => _$Query$Query$AllCompaniesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Query$Query with EquatableMixin {
  Query$Query();

  factory Query$Query.fromJson(Map<String, dynamic> json) =>
      _$Query$QueryFromJson(json);

  List<Query$Query$AllCompanies> allCompanies;

  @override
  List<Object> get props => [allCompanies];
  Map<String, dynamic> toJson() => _$Query$QueryToJson(this);
}
