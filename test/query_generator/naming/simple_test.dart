import 'package:artemis/generator/errors.dart';
import 'package:test/test.dart';

import '../../helpers.dart';
import 'common.dart';

void main() {
  group('On naming', () {
    test(
      'On simple naming scheme',
      () => expect(
        testNaming(
          query: query,
          schema: schema,
          expectedNames: expectedNames,
          namingScheme: 'simple',
          shouldFail: true,
        ),
        throwsA(predicate((e) =>
            e is DuplicatedClassesException &&
            listEquals(e.allClassesNames, expectedNames))),
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
  r'Thing',
  r'Thing',
  r'AliasOnAThing',
  r'AliasOnThing',
  r'Thing',
  r'Thing',
  r'AliasOnAThing',
  r'PartsMixin',
  r'Thing',
  r'AliasOnFThing',
];
