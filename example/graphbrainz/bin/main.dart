import 'package:graphql_builder/graphql_builder.dart';
import 'graphbrainz.api.dart';

ScalarMap brainzScalarMapping(GraphQLType type) => [
      ScalarMap('MBID', 'String'),
      ScalarMap('DiscID', 'String'),
      ScalarMap('Date', 'DateTime', useCustomParsers: true),
      ScalarMap('Time', 'DateTime', useCustomParsers: true),
      ScalarMap('ASIN', 'String'),
      ScalarMap('IPI', 'String'),
      ScalarMap('ISNI', 'String'),
      ScalarMap('URLString', 'String'),
      ScalarMap('Degrees', 'double'),
      ScalarMap('Locale', 'String'),
    ].firstWhere((m) => m.graphqlType == type.name,
        orElse: () => defaultScalarMapping(type));

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
