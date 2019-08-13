import 'package:json_annotation/json_annotation.dart';

abstract class GraphQLQuery<T, U extends JsonSerializable> {
  GraphQLQuery({this.variables});

  final U variables;
  final String query = null;
  final String operationName = null;

  T parse(Map<String, dynamic> json);

  Map<String, dynamic> getVariablesMap() {
    return (variables != null) ? variables.toJson() : {};
  }
}
