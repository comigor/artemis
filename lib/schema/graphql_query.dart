import 'package:json_annotation/json_annotation.dart';

abstract class GraphQLQuery<T, U extends JsonSerializable> {
  GraphQLQuery({this.variables, this.query, this.operationName});

  final U variables;
  final String query;
  final String operationName;

  T parse(Map<String, dynamic> json);

  Map<String, dynamic> getVariablesMap() {
    return (variables != null) ? variables.toJson() : {};
  }
}
