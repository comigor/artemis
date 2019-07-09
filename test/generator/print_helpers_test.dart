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

  group('On printCustomClass', () {
    test('It will throw if name is null or empty.', () {
      final buffer = StringBuffer();

      expect(() => printCustomClass(buffer, ClassDefinition(null, [])),
          throwsA(TypeMatcher<AssertionError>()));
      expect(() => printCustomClass(buffer, ClassDefinition('', [])),
          throwsA(TypeMatcher<AssertionError>()));
    });

    test(
        'It will throw if factoryPossibilities is given without resolveTypeField.',
        () {
      final buffer = StringBuffer();

      expect(
          () => printCustomClass(
              buffer,
              ClassDefinition('AClass', [],
                  factoryPossibilities: ['Possibility'])),
          throwsA(TypeMatcher<AssertionError>()));
    });

    test('It can generate a class without properties.', () {
      final buffer = StringBuffer();
      final definition = ClassDefinition('AClass', []);

      printCustomClass(buffer, definition);

      expect(buffer.toString(), '''

@JsonSerializable()
class AClass  {

  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) => _\$AClassFromJson(json);
  Map<String, dynamic> toJson() => _\$AClassToJson(this);
}
''');
    });

    test('"Mixins" will be included to class.', () {
      final buffer = StringBuffer();
      final definition =
          ClassDefinition('AClass', [], mixins: 'extends AnotherClass');

      printCustomClass(buffer, definition);

      expect(buffer.toString(), '''

@JsonSerializable()
class AClass extends AnotherClass {

  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) => _\$AClassFromJson(json);
  Map<String, dynamic> toJson() => _\$AClassToJson(this);
}
''');
    });

    test(
        'factoryPossibilities and resolveTypeField are used to generated a branch factory.',
        () {
      final buffer = StringBuffer();
      final definition = ClassDefinition(
        'AClass',
        [],
        factoryPossibilities: ['ASubClass', 'BSubClass'],
        resolveTypeField: '__resolveType',
      );

      printCustomClass(buffer, definition);

      expect(buffer.toString(), '''

@JsonSerializable()
class AClass  {

  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) {
    switch (json['__resolveType']) {
      case 'ASubClass':
        return ASubClass.fromJson(json);
      case 'BSubClass':
        return BSubClass.fromJson(json);
      default:
    }
    return _\$AClassFromJson(json);
  }
  Map<String, dynamic> toJson() {
    switch (resolveType) {
      case 'ASubClass':
        return (this as ASubClass).toJson();
      case 'BSubClass':
        return (this as BSubClass).toJson();
      default:
    }
    return _\$AClassToJson(this);
  }
}
''');
    });

    test('It can have properties.', () {
      final buffer = StringBuffer();
      final definition = ClassDefinition('AClass', [
        ClassProperty('Type', 'name'),
        ClassProperty('AnotherType', 'anotherName'),
      ]);

      printCustomClass(buffer, definition);

      expect(buffer.toString(), '''

@JsonSerializable()
class AClass  {
  Type name;
  AnotherType anotherName;

  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) => _\$AClassFromJson(json);
  Map<String, dynamic> toJson() => _\$AClassToJson(this);
}
''');
    });

    test(
        'Its properties can be an override or have a custom annotation, or both.',
        () {
      final buffer = StringBuffer();
      final definition = ClassDefinition('AClass', [
        ClassProperty('Type', 'name'),
        ClassProperty('AnnotedProperty', 'name', annotation: '@Hey()'),
        ClassProperty('OverridenProperty', 'name', override: true),
        ClassProperty('AllAtOnce', 'name', override: true, annotation: '@Ho()'),
      ]);

      printCustomClass(buffer, definition);

      expect(buffer.toString(), '''

@JsonSerializable()
class AClass  {
  Type name;
  @Hey()
  AnnotedProperty name;
  @override
  OverridenProperty name;
  @override
  @Ho()
  AllAtOnce name;

  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) => _\$AClassFromJson(json);
  Map<String, dynamic> toJson() => _\$AClassToJson(this);
}
''');
    });
  });
}
