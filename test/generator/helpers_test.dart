import 'package:test/test.dart';
import 'package:artemis/generator/helpers.dart';

void main() {
  group('On removeDuplicatedBy helper', () {
    test('It will return a new iterable.', () {
      final it = [
        {'a': 1},
        {'a': 2},
      ];
      final anotherIt = removeDuplicatedBy(it, (i) => i['a']);

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
      removeDuplicatedBy(it, (i) => i['a']);

      expect(it, equals(copyOfIt));
    });

    test('It will keep only the first entry that matches the function.', () {
      final it = [
        {'a': 1, 'first': true},
        {'a': 2, 'first': true},
        {'a': 2, 'first': false},
        {'a': 1, 'first': false},
      ];
      final anotherIt = removeDuplicatedBy(it, (i) => i['a']);

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
      final anotherIt =
          removeDuplicatedBy<Map<String, Object>, Map<String, Object>>(
              it, (i) => i);

      expect(anotherIt, equals(it));
    });
  });

  group('On mergeDuplicatesBy helper', () {
    test('It will return a new iterable.', () {
      final it = [
        {'a': 1},
        {'a': 2},
      ];
      final anotherIt = mergeDuplicatesBy(it, (i) => i, (i, _) => i);

      expect(anotherIt == it, false);
    });

    test('It can behave like removeDuplicatedBy.', () {
      final it = [
        {'a': 1, 'first': true},
        {'a': 2, 'first': true},
        {'a': 2, 'first': false},
        {'a': 1, 'first': false},
      ];
      final anotherIt = mergeDuplicatesBy(it, (i) => i['a'], (i, _) => i);

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
      final anotherIt = mergeDuplicatesBy(it, (i) => i['a'], (_, i) => i);

      expect(
          anotherIt,
          equals([
            {'a': 1, 'last': true},
            {'a': 2, 'last': true},
          ]));
    });
  });
}
