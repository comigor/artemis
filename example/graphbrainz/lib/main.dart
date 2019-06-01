import 'package:graphql_builder/graphql_builder.dart';
import 'graphbrainz.api.dart';

final query = '''
query EdSheeran {
  node(id: "QXJ0aXN0OmI4YTdjNTFmLTM2MmMtNGRjYi1hMjU5LWJjNmUwMDk1ZjBhNg==") {
    ... on Artist {
      mbid
      name
      lifeSpan {
        begin
      }
      spotify {
        href
      }
    }
  }
}
''';
