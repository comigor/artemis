import 'package:artemis/generator/data.dart';
import 'package:test/test.dart';
import 'package:artemis/generator/print_helpers.dart';

void main() {
  group('On printCustomEnum', () {
    test('It will throw if name is null or empty.', () {
      expect(() => printCustomEnum(EnumDefinition(null, [])),
          throwsA(TypeMatcher<AssertionError>()));
      expect(() => printCustomEnum(EnumDefinition('', [])),
          throwsA(TypeMatcher<AssertionError>()));
    });

    test('It will throw if values is null or empty.', () {
      expect(() => printCustomEnum(EnumDefinition('Name', null)),
          throwsA(TypeMatcher<AssertionError>()));
      expect(() => printCustomEnum(EnumDefinition('Name', [])),
          throwsA(TypeMatcher<AssertionError>()));
    });

    test('It will generate an Enum declaration.', () {
      final definition = EnumDefinition('Name', [
        'Option',
        'anotherOption',
        'third_option',
        'FORTH_OPTION',
      ]);

      final str = specToString(printCustomEnum(definition));

      expect(str, '''enum Name {
  Option,
  anotherOption,
  third_option,
  FORTH_OPTION,
}
''');
    });

    test('It will ignore duplicate options.', () {
      final definition = EnumDefinition('Name', [
        'Option',
        'AnotherOption',
        'Option',
        'AnotherOption',
      ]);

      final str = specToString(printCustomEnum(definition));

      expect(str, '''enum Name {
  Option,
  AnotherOption,
}
''');
    });
  });

  group('On printCustomClass', () {
    test('It will throw if name is null or empty.', () {
      expect(() => printCustomClass(ClassDefinition(null, [])),
          throwsA(TypeMatcher<AssertionError>()));
      expect(() => printCustomClass(ClassDefinition('', [])),
          throwsA(TypeMatcher<AssertionError>()));
    });

    test('It can generate a class without properties.', () {
      final definition = ClassDefinition('AClass', []);

      final str = specToString(printCustomClass(definition));

      expect(str, '''@JsonSerializable(explicitToJson: true)
class AClass {
  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) => _\$AClassFromJson(json);

  Map<String, dynamic> toJson() => _\$AClassToJson(this);
}
''');
    });

    test('"Mixins" will be included to class.', () {
      final definition =
          ClassDefinition('AClass', [], extension: 'AnotherClass');

      final str = specToString(printCustomClass(definition));

      expect(str, '''@JsonSerializable(explicitToJson: true)
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
      final definition = ClassDefinition(
        'AClass',
        [],
        factoryPossibilities: ['ASubClass', 'BSubClass'],
        resolveTypeField: '__resolveType',
      );

      final str = specToString(printCustomClass(definition));

      expect(str, '''@JsonSerializable(explicitToJson: true)
class AClass {
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
      final definition = ClassDefinition('AClass', [
        ClassProperty('Type', 'name'),
        ClassProperty('AnotherType', 'anotherName'),
      ]);

      final str = specToString(printCustomClass(definition));

      expect(str, '''@JsonSerializable(explicitToJson: true)
class AClass {
  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) => _\$AClassFromJson(json);

  Type name;

  AnotherType anotherName;

  Map<String, dynamic> toJson() => _\$AClassToJson(this);
}
''');
    });

    test(
        'Its properties can be an override or have a custom annotation, or both.',
        () {
      final definition = ClassDefinition('AClass', [
        ClassProperty('Type', 'name'),
        ClassProperty('AnnotedProperty', 'name', annotation: 'Hey()'),
        ClassProperty('OverridenProperty', 'name', override: true),
        ClassProperty('AllAtOnce', 'name', override: true, annotation: 'Ho()'),
      ]);

      final str = specToString(printCustomClass(definition));

      expect(str, '''@JsonSerializable(explicitToJson: true)
class AClass {
  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) => _\$AClassFromJson(json);

  Type name;

  @Hey()
  AnnotedProperty name;

  @override
  OverridenProperty name;

  @override
  @Ho()
  AllAtOnce name;

  Map<String, dynamic> toJson() => _\$AClassToJson(this);
}
''');
    });
  });

  group('On printCustomQuery', () {
    test('It will throw if name/query/basename is null or empty.', () {
      final buffer = StringBuffer();

      expect(
          () => printCustomQueryFile(buffer,
              QueryDefinition(null, 'query test_query {}', 'test_query')),
          throwsA(TypeMatcher<AssertionError>()));
      expect(
          () => printCustomQueryFile(
              buffer, QueryDefinition('', 'query test_query {}', 'test_query')),
          throwsA(TypeMatcher<AssertionError>()));
      expect(
          () => printCustomQueryFile(
              buffer, QueryDefinition('TestQuery', null, 'test_query')),
          throwsA(TypeMatcher<AssertionError>()));
      expect(
          () => printCustomQueryFile(
              buffer, QueryDefinition('TestQuery', '', 'test_query')),
          throwsA(TypeMatcher<AssertionError>()));
      expect(
          () => printCustomQueryFile(buffer,
              QueryDefinition('TestQuery', 'query test_query {}', null)),
          throwsA(TypeMatcher<AssertionError>()));
      expect(
          () => printCustomQueryFile(
              buffer, QueryDefinition('TestQuery', 'query test_query {}', '')),
          throwsA(TypeMatcher<AssertionError>()));
    });

    test('It should generated an empty file by default.', () {
      final buffer = StringBuffer();
      final definition =
          QueryDefinition('TestQuery', 'query test_query {}', 'test_query');

      printCustomQueryFile(buffer, definition);

      expect(buffer.toString(), '''// GENERATED CODE - DO NOT MODIFY BY HAND

import \'package:json_annotation/json_annotation.dart\';
part \'test_query.query.g.dart\';
''');
    });

    test('When customParserImport is given, its import is included.', () {
      final buffer = StringBuffer();
      final definition = QueryDefinition(
          'TestQuery', 'query test_query {}', 'test_query',
          customParserImport: 'some_file.dart');

      printCustomQueryFile(buffer, definition);

      expect(buffer.toString(), '''// GENERATED CODE - DO NOT MODIFY BY HAND

import \'package:json_annotation/json_annotation.dart\';
import \'some_file.dart\';
part \'test_query.query.g.dart\';
''');
    });

    test('When generateHelpers is true, an execute fn is generated.', () {
      final buffer = StringBuffer();
      final definition = QueryDefinition(
          'TestQuery', 'query test_query {}', 'test_query',
          generateHelpers: true);

      printCustomQueryFile(buffer, definition);

      expect(buffer.toString(), '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'dart:async';
import 'dart:convert';
import 'package:artemis/artemis.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
part 'test_query.query.g.dart';

class TestQueryQuery extends GraphQLQuery<TestQuery, JsonSerializable> {
  TestQueryQuery();

  @override
  final String query = 'query test_query {}';

  @override
  final String operationName = 'test_query';

  @override
  TestQuery parse(Map<String, dynamic> json) => TestQuery.fromJson(json);
}
''');
    });

    test('The generated execute fn could have input.', () {
      final buffer = StringBuffer();
      final definition = QueryDefinition(
          'TestQuery', 'query test_query {}', 'test_query',
          generateHelpers: true, inputs: [QueryInput('Type', 'name')]);

      printCustomQueryFile(buffer, definition);

      expect(buffer.toString(), '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'dart:async';
import 'dart:convert';
import 'package:artemis/artemis.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
part 'test_query.query.g.dart';

@JsonSerializable(explicitToJson: true)
class TestQueryArguments extends JsonSerializable {
  TestQueryArguments({this.name});

  factory TestQueryArguments.fromJson(Map<String, dynamic> json) =>
      _\$TestQueryArgumentsFromJson(json);

  final Type name;

  Map<String, dynamic> toJson() => _\$TestQueryArgumentsToJson(this);
}

class TestQueryQuery extends GraphQLQuery<TestQuery, TestQueryArguments> {
  TestQueryQuery({this.variables});

  @override
  final String query = 'query test_query {}';

  @override
  final String operationName = 'test_query';

  @override
  final TestQueryArguments variables;

  @override
  TestQuery parse(Map<String, dynamic> json) => TestQuery.fromJson(json);
}
''');
    });

    test('Will generate an Arguments class', () {
      final definition = QueryDefinition(
          'TestQuery', 'query test_query {}', 'test_query',
          generateHelpers: true, inputs: [QueryInput('Type', 'name')]);

      final str = specToString(printArgumentsClass(definition));

      expect(str, '''@JsonSerializable(explicitToJson: true)
class TestQueryArguments extends JsonSerializable {
  TestQueryArguments({this.name});

  factory TestQueryArguments.fromJson(Map<String, dynamic> json) =>
      _\$TestQueryArgumentsFromJson(json);

  final Type name;

  Map<String, dynamic> toJson() => _\$TestQueryArgumentsToJson(this);
}
''');
    });

    test('Will generate a Query Class', () {
      final definition = QueryDefinition(
          'TestQuery', 'query test_query {}', 'test_query',
          generateHelpers: true, inputs: [QueryInput('Type', 'name')]);

      final str = specToString(printQueryClass(definition));

      expect(str,
          '''class TestQueryQuery extends GraphQLQuery<TestQuery, TestQueryArguments> {
  TestQueryQuery({this.variables});

  @override
  final String query = 'query test_query {}';

  @override
  final String operationName = 'test_query';

  @override
  final TestQueryArguments variables;

  @override
  TestQuery parse(Map<String, dynamic> json) => TestQuery.fromJson(json);
}
''');
    });

    test('It will accept and write class/enum definitions.', () {
      final buffer = StringBuffer();
      final definition = QueryDefinition(
          'TestQuery', 'query test_query {}', 'test_query',
          classes: [
            EnumDefinition('Enum', ['Value']),
            ClassDefinition('AClass', [])
          ]);

      printCustomQueryFile(buffer, definition);

      expect(buffer.toString(), '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
part 'test_query.query.g.dart';

@JsonSerializable(explicitToJson: true)
class AClass {
  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) => _\$AClassFromJson(json);

  Map<String, dynamic> toJson() => _\$AClassToJson(this);
}

enum Enum {
  Value,
}
''');
    });
  });
}
