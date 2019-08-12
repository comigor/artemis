abstract class GraphQLQuery<T, U extends Object> {
  GraphQLQuery({this.variables, this.query});

  final U variables;
  final String query;

  T parse(Map<String, dynamic> json);
}
