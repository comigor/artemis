import 'package:test/test.dart';

import '../../helpers.dart';
import 'common.dart';

void main() {
  group('On naming', () {
    test(
      'On pathedWithTypes naming scheme',
      () async => expect(
        () {
          testNaming(
            query: query,
            schema: schema,
            expectedNames: expectedNames,
            builderOptionsMap: {
              'naming_scheme': 'pathedWithTypes',
            },
          );
        },
        throwsA(predicate((e) => e is Exception)),
      ),
    );
  });
}

const expectedNames = [
  r'Enum',
  r'Input',
  r'SubInput',
  r'BigQuery$Query',
  r'BigQuery$Query$Thing',
  r'BigQuery$Query$Thing$Thing',
  r'BigQuery$Query$Thing$Thing',
  r'BigQuery$Query$Thing$AliasOnAThing',
  r'BigQuery$Query$AliasOnThing',
  r'BigQuery$Query$AliasOnThing$Thing',
  r'BigQuery$Query$AliasOnThing$Thing',
  r'BigQuery$Query$AliasOnThing$AliasOnAThing',
  r'BigQuery$PartsMixin',
  r'BigQuery$PartsMixin$Thing',
  r'BigQuery$PartsMixin$AliasOnFThing',
];
