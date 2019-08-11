abstract class GraphQLQuery<T> {
  GraphQLQuery({this.variables, this.query});

  final Map<String, dynamic> variables;
  final String query;

  T parse(Map<String, dynamic> json);
}
