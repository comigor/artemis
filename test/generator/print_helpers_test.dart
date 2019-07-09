import 'package:artemis/generator/data.dart';
import 'package:test/test.dart';
import 'package:artemis/generator/print_helpers.dart';

void main() {
  group('On printCustomEnum', () {
    test('It will throw if name is null or empty.', () {
      final buffer = StringBuffer();

      expect(() => printCustomEnum(buffer, EnumDefinition(null, [])),
          throwsA(TypeMatcher<AssertionError>()));
      expect(() => printCustomEnum(buffer, EnumDefinition('', [])),
          throwsA(TypeMatcher<AssertionError>()));
    });

    test('It will throw if values is null or empty.', () {
      final buffer = StringBuffer();

      expect(() => printCustomEnum(buffer, EnumDefinition('Name', null)),
          throwsA(TypeMatcher<AssertionError>()));
      expect(() => printCustomEnum(buffer, EnumDefinition('Name', [])),
          throwsA(TypeMatcher<AssertionError>()));
    });

    test('It will generate an Enum declaration.', () {
      final buffer = StringBuffer();
      final definition = EnumDefinition('Name', [
        'Option',
        'anotherOption',
        'third_option',
        'FORTH_OPTION',
      ]);

      printCustomEnum(buffer, definition);

      expect(buffer.toString(), '''enum Name {
  Option,
  anotherOption,
  third_option,
  FORTH_OPTION,
}
''');
    });

    test('It will ignore duplicate options.', () {
      final buffer = StringBuffer();
      final definition = EnumDefinition('Name', [
        'Option',
        'AnotherOption',
        'Option',
        'AnotherOption',
      ]);

      printCustomEnum(buffer, definition);

      expect(buffer.toString(), '''enum Name {
  Option,
  AnotherOption,
}
''');
    });
  });
}
