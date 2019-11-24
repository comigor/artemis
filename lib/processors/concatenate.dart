import 'package:artemis/schema/graphql.dart';
import 'package:artemis/schema/options.dart';
import 'package:gql/ast.dart';

List<DocumentNode> preprocess(
  GraphQLSchema _schema,
  String _path,
  List<DocumentNode> gqlDocs,
  GeneratorOptions _options,
  SchemaMap _schemaMap,
) {
  return [
    gqlDocs.reduce((memo, doc) {
      return DocumentNode(
        definitions: memo.definitions.followedBy(doc.definitions).toList(),
      );
    }),
  ];
}
