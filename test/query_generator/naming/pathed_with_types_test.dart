import 'package:artemis/generator/errors.dart';
import 'package:test/test.dart';
import 'package:collection/collection.dart';

import '../../helpers.dart';
import 'common.dart';

final bool Function(Iterable, Iterable) _listEquals =
    const DeepCollectionEquality.unordered().equals;

void main() {
  group('On naming', () {
    test(
      'On pathedWithTypes naming scheme',
      () => expect(
        testNaming(
          query: query,
          schema: schema,
          expectedNames: expectedNames,
          builderOptionsMap: {
            'naming_scheme': 'pathedWithTypes',
          },
          shouldFail: true,
        ),
        throwsA(predicate((e) =>
            e is DuplicatedClassesException &&
            _listEquals(e.allClassesNames, expectedNames))),
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
  r'PartsMixin',
  r'PartsMixin$Thing',
  r'PartsMixin$AliasOnFThing',
];
