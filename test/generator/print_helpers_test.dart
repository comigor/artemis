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

    test('It can generate a class without properties.', () {
      final buffer = StringBuffer();
      final definition = ClassDefinition('AClass', []);

      printCustomClass(buffer, definition);

      expect(buffer.toString(), '''

@JsonSerializable(explicitToJson: true)
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

@JsonSerializable(explicitToJson: true)
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

@JsonSerializable(explicitToJson: true)
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

@JsonSerializable(explicitToJson: true)
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

@JsonSerializable(explicitToJson: true)
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

  group('On printCustomQuery', () {
    test('It will throw if name/query/basename is null or empty.', () {
      final buffer = StringBuffer();

      expect(
          () => printCustomQuery(buffer,
              QueryDefinition(null, 'query test_query {}', 'test_query')),
          throwsA(TypeMatcher<AssertionError>()));
      expect(
          () => printCustomQuery(
              buffer, QueryDefinition('', 'query test_query {}', 'test_query')),
          throwsA(TypeMatcher<AssertionError>()));
      expect(
          () => printCustomQuery(
              buffer, QueryDefinition('TestQuery', null, 'test_query')),
          throwsA(TypeMatcher<AssertionError>()));
      expect(
          () => printCustomQuery(
              buffer, QueryDefinition('TestQuery', '', 'test_query')),
          throwsA(TypeMatcher<AssertionError>()));
      expect(
          () => printCustomQuery(buffer,
              QueryDefinition('TestQuery', 'query test_query {}', null)),
          throwsA(TypeMatcher<AssertionError>()));
      expect(
          () => printCustomQuery(
              buffer, QueryDefinition('TestQuery', 'query test_query {}', '')),
          throwsA(TypeMatcher<AssertionError>()));
    });

    test('It should generated an empty file by default.', () {
      final buffer = StringBuffer();
      final definition =
          QueryDefinition('TestQuery', 'query test_query {}', 'test_query');

      printCustomQuery(buffer, definition);

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

      printCustomQuery(buffer, definition);

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

      printCustomQuery(buffer, definition);

      expect(buffer.toString(), '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:artemis/artemis.dart';

part 'test_query.query.g.dart';
class TestQueryQuery extends GraphQLQuery<TestQuery, JsonSerializable> {
  TestQueryQuery();

  @override
  final String query = 'query test_query {}';
  @override
  final String operationName = 'test_query';

  @override
  TestQuery parse(Map<String, dynamic> json) {
    return TestQuery.fromJson(json);
  }
}
''');
    });

    test('The generated execute fn could have input.', () {
      final buffer = StringBuffer();
      final definition = QueryDefinition(
          'TestQuery', 'query test_query {}', 'test_query',
          generateHelpers: true, inputs: [QueryInput('Type', 'name')]);

      printCustomQuery(buffer, definition);

      expect(buffer.toString(), '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:artemis/artemis.dart';

part 'test_query.query.g.dart';
@JsonSerializable(explicitToJson: true)
class TestQueryArguments extends JsonSerializable {
  TestQueryArguments({this.name});

  final Type name;
  
  factory TestQueryArguments.fromJson(Map<String, dynamic> json) =>
      _\$TestQueryArgumentsFromJson(json);
  Map<String, dynamic> toJson() => _\$TestQueryArgumentsToJson(this);
}
class TestQueryQuery extends GraphQLQuery<TestQuery, TestQueryArguments> {
  TestQueryQuery({this.variables});
  @override
  final TestQueryArguments variables;
  @override
  final String query = 'query test_query {}';
  @override
  final String operationName = 'test_query';

  @override
  TestQuery parse(Map<String, dynamic> json) {
    return TestQuery.fromJson(json);
  }
}
''');
    });

    test('Will generate an Arguments class', () {
      final buffer = StringBuffer();
      final definition = QueryDefinition(
          'TestQuery', 'query test_query {}', 'test_query',
          generateHelpers: true, inputs: [QueryInput('Type', 'name')]);

      printArgumentsClass(buffer, definition);

      expect(buffer.toString(), '''@JsonSerializable(explicitToJson: true)
class TestQueryArguments extends JsonSerializable {
  TestQueryArguments({this.name});

  final Type name;
  
  factory TestQueryArguments.fromJson(Map<String, dynamic> json) =>
      _\$TestQueryArgumentsFromJson(json);
  Map<String, dynamic> toJson() => _\$TestQueryArgumentsToJson(this);
}
''');
    });

    test('Will generate a Query Class', () {
      final buffer = StringBuffer();
      final definition = QueryDefinition(
          'TestQuery', 'query test_query {}', 'test_query',
          generateHelpers: true, inputs: [QueryInput('Type', 'name')]);

      printQueryClass(buffer, definition);

      expect(buffer.toString(),
          '''class TestQueryQuery extends GraphQLQuery<TestQuery, TestQueryArguments> {
  TestQueryQuery({this.variables});
  @override
  final TestQueryArguments variables;
  @override
  final String query = 'query test_query {}';
  @override
  final String operationName = 'test_query';

  @override
  TestQuery parse(Map<String, dynamic> json) {
    return TestQuery.fromJson(json);
  }
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

      printCustomQuery(buffer, definition);

      expect(buffer.toString(), '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'test_query.query.g.dart';
enum Enum {
  Value,
}

@JsonSerializable(explicitToJson: true)
class AClass  {

  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) => _\$AClassFromJson(json);
  Map<String, dynamic> toJson() => _\$AClassToJson(this);
}
''');
    });
  });
}
