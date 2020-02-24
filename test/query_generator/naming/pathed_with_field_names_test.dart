import 'package:test/test.dart';

import '../../helpers.dart';
import 'common.dart';

void main() {
  group('On naming', () {
    test(
      'On pathedWithFieldNames naming scheme',
      () async => testNaming(
        query: query,
        schema: schema,
        expectedNames: expectedNames,
        builderOptionsMap: {
          'naming_scheme': 'pathedWithFieldNames',
        },
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
  r'BigQuery$Query$Thing$NextThing',
  r'BigQuery$Query$Thing$AliasOnNextThing',
  r'BigQuery$Query$AliasOnThing',
  r'BigQuery$Query$AliasOnThing$NextThing',
  r'BigQuery$Query$AliasOnThing$AliasOnNextThing',
  r'BigQuery$PartsMixin',
  r'BigQuery$PartsMixin$NextThingOnFragment',
  r'BigQuery$PartsMixin$AliasOnNextThingOnFragment',
];
