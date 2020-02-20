import 'package:artemis/generator/data.dart';
import 'package:gql/language.dart';
import 'package:test/test.dart';
import 'package:artemis/generator/helpers.dart';

void main() {
  group('On removeDuplicatedBy helper', () {
    test('It will return a new iterable.', () {
      final it = [
        {'a': 1},
        {'a': 2},
      ];
      final anotherIt = it.removeDuplicatedBy((i) => i['a']);

      expect(anotherIt == it, false);
    });

    test('It will not mutate the old iterable.', () {
      final it = [
        {'a': 1},
        {'a': 2},
        {'a': 2},
        {'a': 1},
      ];
      final copyOfIt = List.from(it);
      it.removeDuplicatedBy((i) => i['a']);

      expect(it, equals(copyOfIt));
    });

    test('It will keep only the first entry that matches the function.', () {
      final it = [
        {'a': 1, 'first': true},
        {'a': 2, 'first': true},
        {'a': 2, 'first': false},
        {'a': 1, 'first': false},
      ];
      final anotherIt = it.removeDuplicatedBy((i) => i['a']);

      expect(
          anotherIt,
          equals([
            {'a': 1, 'first': true},
            {'a': 2, 'first': true},
          ]));
    });

    test('Iterable function can return anything.', () {
      final it = [
        {'a': 1, 'first': true},
        {'a': 2, 'first': true},
        {'a': 2, 'first': false},
        {'a': 1, 'first': false},
      ];
      final anotherIt = it.removeDuplicatedBy((i) => i);

      expect(anotherIt, equals(it));
    });
  });

  group('On mergeDuplicatesBy helper', () {
    test('It will return a new iterable.', () {
      final it = [
        {'a': 1},
        {'a': 2},
      ];
      final anotherIt = it.mergeDuplicatesBy((i) => i, (i, _) => i);

      expect(anotherIt == it, false);
    });

    test('It can behave like removeDuplicatedBy.', () {
      final it = [
        {'a': 1, 'first': true},
        {'a': 2, 'first': true},
        {'a': 2, 'first': false},
        {'a': 1, 'first': false},
      ];
      final anotherIt = it.mergeDuplicatesBy((i) => i['a'], (i, _) => i);

      expect(
          anotherIt,
          equals([
            {'a': 1, 'first': true},
            {'a': 2, 'first': true},
          ]));
    });

    test('It can return a list of the last elements based on fn.', () {
      final it = [
        {'a': 1, 'last': false},
        {'a': 2, 'last': false},
        {'a': 2, 'last': true},
        {'a': 1, 'last': true},
      ];
      final anotherIt = it.mergeDuplicatesBy((i) => i['a'], (_, i) => i);

      expect(
          anotherIt,
          equals([
            {'a': 1, 'last': true},
            {'a': 2, 'last': true},
          ]));
    });
  });

  group('On hasNonNullableInput helper', () {
    test('It will return `false` on empty input', () {
      var result = hasNonNullableInput([]);

      expect(result, false);
    });

    test('It will return `true` if at least one query input is non nullable',
        () {
      var input = [
        QueryDefinition(
          queryName: 'some_query',
          queryType: 'SomeQuery',
          document: parseString('query some_query {}'),
          inputs: [QueryInput(type: 'Type', name: 'name', isNonNull: true)],
        ),
        QueryDefinition(
          queryName: 'another_query',
          queryType: 'AnotherQuery',
          document: parseString('query another_query {}'),
          inputs: [QueryInput(type: 'Type', name: 'name')],
        ),
      ];
      var result = hasNonNullableInput(input);

      expect(result, true);
    });

    test('It will return `false` if there is no non nullable inputs', () {
      var input = [
        QueryDefinition(
          queryName: 'some_query',
          queryType: 'SomeQuery',
          document: parseString('query some_query {}'),
          inputs: [QueryInput(type: 'Type', name: 'name')],
        ),
        QueryDefinition(
          queryName: 'another_query',
          queryType: 'AnotherQuery',
          document: parseString('query another_query {}'),
          inputs: [QueryInput(type: 'Type', name: 'name')],
        ),
      ];
      var result = hasNonNullableInput(input);

      expect(result, false);
    });
  });
}
