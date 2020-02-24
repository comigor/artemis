import 'package:test/test.dart';

import '../../helpers.dart';
import 'common.dart';

void main() {
  group('On naming', () {
    test(
      'On simple naming scheme',
      () async => expect(
        () {
          testNaming(
            query: query,
            schema: schema,
            expectedNames: expectedNames,
            builderOptionsMap: {
              'naming_scheme': 'simple',
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
  r'Query',
  r'Thing',
  r'AliasOnThing',
  r'Thing',
  r'AliasOnNextThing',
  r'Thing',
  r'AliasOnNextThing',
  r'PartsMixin',
  r'Thing',
  r'AliasOnNextThingOnFragment',
];
