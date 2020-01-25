import 'package:artemis/generator/data.dart';
import 'package:artemis/generator/print_helpers.dart';
import 'package:gql/language.dart';
import 'package:test/test.dart';

void main() {
  group('On printCustomEnum', () {
    test('It will throw if name is null or empty.', () {
      expect(() => enumDefinitionToSpec(EnumDefinition(null, [])),
          throwsA(TypeMatcher<AssertionError>()));
      expect(() => enumDefinitionToSpec(EnumDefinition('', [])),
          throwsA(TypeMatcher<AssertionError>()));
    });

    test('It will throw if values is null or empty.', () {
      expect(() => enumDefinitionToSpec(EnumDefinition('Name', null)),
          throwsA(TypeMatcher<AssertionError>()));
      expect(() => enumDefinitionToSpec(EnumDefinition('Name', [])),
          throwsA(TypeMatcher<AssertionError>()));
    });

    test('It will generate an Enum declaration.', () {
      final definition = EnumDefinition('Name', [
        'Option',
        'anotherOption',
        'third_option',
        'FORTH_OPTION',
      ]);

      final str = specToString(enumDefinitionToSpec(definition));

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

      final str = specToString(enumDefinitionToSpec(definition));

      expect(str, '''enum Name {
  Option,
  AnotherOption,
}
''');
    });
  });

  group('On printCustomFragmentClass', () {
    test('It will throw if name is null or empty.', () {
      expect(
          () =>
              fragmentClassDefinitionToSpec(FragmentClassDefinition(null, [])),
          throwsA(TypeMatcher<AssertionError>()));
      expect(
          () => fragmentClassDefinitionToSpec(FragmentClassDefinition('', [])),
          throwsA(TypeMatcher<AssertionError>()));
    });

    test('It will generate an Mixins declarations.', () {
      final definition = FragmentClassDefinition('FragmentMixin', [
        ClassProperty('Type', 'name'),
        ClassProperty('Type', 'name', isOverride: true),
        ClassProperty('Type', 'name', annotation: 'Test'),
      ]);

      final str = specToString(fragmentClassDefinitionToSpec(definition));

      expect(str, '''mixin FragmentMixin {
  Type name;
  @override
  Type name;
  @Test
  Type name;
}
''');
    });
  });

  group('On printCustomClass', () {
    test('It will throw if name is null or empty.', () {
      expect(() => classDefinitionToSpec(ClassDefinition(null, []), []),
          throwsA(TypeMatcher<AssertionError>()));
      expect(() => classDefinitionToSpec(ClassDefinition('', []), []),
          throwsA(TypeMatcher<AssertionError>()));
    });

    test('It can generate a class without properties.', () {
      final definition = ClassDefinition('AClass', []);

      final str = specToString(classDefinitionToSpec(definition, []));

      expect(str, '''@JsonSerializable(explicitToJson: true)
class AClass with EquatableMixin {
  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) => _\$AClassFromJson(json);

  @override
  List<Object> get props => [];
  Map<String, dynamic> toJson() => _\$AClassToJson(this);
}
''');
    });

    test('"Mixins" will be included to class.', () {
      final definition =
          ClassDefinition('AClass', [], extension: 'AnotherClass');

      final str = specToString(classDefinitionToSpec(definition, []));

      expect(str, '''@JsonSerializable(explicitToJson: true)
class AClass extends AnotherClass with EquatableMixin {
  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) => _\$AClassFromJson(json);

  @override
  List<Object> get props => [];
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

      final str = specToString(classDefinitionToSpec(definition, []));

      expect(str, '''@JsonSerializable(explicitToJson: true)
class AClass with EquatableMixin {
  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) {
    switch (json['__resolveType'].toString()) {
      case 'ASubClass':
        return ASubClass.fromJson(json);
      case 'BSubClass':
        return BSubClass.fromJson(json);
      default:
    }
    return _\$AClassFromJson(json);
  }

  @override
  List<Object> get props => [];
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

      final str = specToString(classDefinitionToSpec(definition, []));

      expect(str, '''@JsonSerializable(explicitToJson: true)
class AClass with EquatableMixin {
  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) => _\$AClassFromJson(json);

  Type name;

  AnotherType anotherName;

  @override
  List<Object> get props => [name, anotherName];
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
        ClassProperty('OverridenProperty', 'name', isOverride: true),
        ClassProperty('AllAtOnce', 'name',
            isOverride: true, annotation: 'Ho()'),
      ]);

      final str = specToString(classDefinitionToSpec(definition, []));

      expect(str, '''@JsonSerializable(explicitToJson: true)
class AClass with EquatableMixin {
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

  @override
  List<Object> get props => [name, name, name, name];
  Map<String, dynamic> toJson() => _\$AClassToJson(this);
}
''');
    });

    test(
        'Mixins can be included and its properties will be considered on props getter',
        () {
      final definition =
          ClassDefinition('AClass', [], mixins: ['FragmentMixin']);

      final str = specToString(classDefinitionToSpec(definition, [
        FragmentClassDefinition('FragmentMixin', [
          ClassProperty('Type', 'name'),
        ])
      ]));

      expect(str, '''@JsonSerializable(explicitToJson: true)
class AClass with EquatableMixin, FragmentMixin {
  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) => _\$AClassFromJson(json);

  @override
  List<Object> get props => [name];
  Map<String, dynamic> toJson() => _\$AClassToJson(this);
}
''');
    });
  });

  group('On generateQueryClassSpec', () {
    test('It will throw if basename is null or empty.', () {
      expect(() => generateLibrarySpec(LibraryDefinition(null)),
          throwsA(TypeMatcher<AssertionError>()));
      expect(() => generateLibrarySpec(LibraryDefinition('')),
          throwsA(TypeMatcher<AssertionError>()));
    });

    test('It will throw if name/type/query is null or empty.', () {
      expect(
        () => generateQueryClassSpec(
          QueryDefinition(null, 'Type', parseString('query test_query {}')),
        ),
        throwsA(TypeMatcher<AssertionError>()),
      );
      expect(
        () => generateQueryClassSpec(
          QueryDefinition('', 'Type', parseString('query test_query {}')),
        ),
        throwsA(
          TypeMatcher<AssertionError>(),
        ),
      );
      expect(
        () => generateQueryClassSpec(
          QueryDefinition(
              'test_query', null, parseString('query test_query {}')),
        ),
        throwsA(
          TypeMatcher<AssertionError>(),
        ),
      );
      expect(
        () => generateQueryClassSpec(
          QueryDefinition('test_query', '', parseString('query test_query {}')),
        ),
        throwsA(
          TypeMatcher<AssertionError>(),
        ),
      );
      expect(
        () => generateQueryClassSpec(
          QueryDefinition('test_query', 'Type', null),
        ),
        throwsA(
          TypeMatcher<AssertionError>(),
        ),
      );
    });

    test('It should generated an empty file by default.', () {
      final buffer = StringBuffer();
      final definition = LibraryDefinition('test_query');

      writeLibraryDefinitionToBuffer(buffer, definition);

      expect(buffer.toString(), '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'test_query.g.dart';
''');
    });

    test('When customParserImport is given, its import is included.', () {
      final buffer = StringBuffer();
      final definition =
          LibraryDefinition('test_query', customParserImport: 'some_file.dart');

      writeLibraryDefinitionToBuffer(buffer, definition);

      expect(buffer.toString(), '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'some_file.dart';
part 'test_query.g.dart';
''');
    });

    test('When generateHelpers is true, an execute fn is generated.', () {
      final buffer = StringBuffer();
      final definition = LibraryDefinition(
        'test_query',
        queries: [
          QueryDefinition(
            'test_query',
            'TestQuery',
            parseString('query test_query {}'),
            generateHelpers: true,
          )
        ],
      );

      writeLibraryDefinitionToBuffer(buffer, definition);

      expect(buffer.toString(), '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'test_query.g.dart';

class TestQueryQuery extends GraphQLQuery<TestQuery, JsonSerializable> {
  TestQueryQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'test_query'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: []))
  ]);

  @override
  final String operationName = 'test_query';

  @override
  List<Object> get props => [document, operationName];
  @override
  TestQuery parse(Map<String, dynamic> json) => TestQuery.fromJson(json);
}
''');
    });

    test('The generated execute fn could have input.', () {
      final buffer = StringBuffer();
      final definition = LibraryDefinition('test_query', queries: [
        QueryDefinition(
          'test_query',
          'TestQuery',
          parseString('query test_query {}'),
          generateHelpers: true,
          inputs: [QueryInput('Type', 'name')],
        ),
      ]);

      writeLibraryDefinitionToBuffer(buffer, definition);

      expect(buffer.toString(), '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'test_query.g.dart';

@JsonSerializable(explicitToJson: true)
class TestQueryArguments extends JsonSerializable with EquatableMixin {
  TestQueryArguments({this.name});

  factory TestQueryArguments.fromJson(Map<String, dynamic> json) =>
      _\$TestQueryArgumentsFromJson(json);

  final Type name;

  @override
  List<Object> get props => [name];
  Map<String, dynamic> toJson() => _\$TestQueryArgumentsToJson(this);
}

class TestQueryQuery extends GraphQLQuery<TestQuery, TestQueryArguments> {
  TestQueryQuery({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'test_query'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: []))
  ]);

  @override
  final String operationName = 'test_query';

  @override
  final TestQueryArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  TestQuery parse(Map<String, dynamic> json) => TestQuery.fromJson(json);
}
''');
    });

    test('Will generate an Arguments class', () {
      final definition = QueryDefinition(
        'test_query',
        'TestQuery',
        parseString('query test_query {}'),
        generateHelpers: true,
        inputs: [QueryInput('Type', 'name')],
      );

      final str = specToString(generateArgumentClassSpec(definition));

      expect(str, '''@JsonSerializable(explicitToJson: true)
class TestQueryArguments extends JsonSerializable with EquatableMixin {
  TestQueryArguments({this.name});

  factory TestQueryArguments.fromJson(Map<String, dynamic> json) =>
      _\$TestQueryArgumentsFromJson(json);

  final Type name;

  @override
  List<Object> get props => [name];
  Map<String, dynamic> toJson() => _\$TestQueryArgumentsToJson(this);
}
''');
    });

    test('Will generate a Query Class', () {
      final definition = QueryDefinition(
        'test_query',
        'TestQuery',
        parseString('query test_query {}'),
        generateHelpers: true,
        inputs: [QueryInput('Type', 'name')],
      );

      final str = specToString(generateQueryClassSpec(definition));

      expect(str,
          '''class TestQueryQuery extends GraphQLQuery<TestQuery, TestQueryArguments> {
  TestQueryQuery({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'test_query'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: []))
  ]);

  @override
  final String operationName = 'test_query';

  @override
  final TestQueryArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  TestQuery parse(Map<String, dynamic> json) => TestQuery.fromJson(json);
}
''');
    });

    test('It will accept and write class/enum definitions.', () {
      final buffer = StringBuffer();
      final definition = LibraryDefinition('test_query', queries: [
        QueryDefinition(
          'test_query',
          'TestQuery',
          parseString('query test_query {}'),
          classes: [
            EnumDefinition('Enum', ['Value']),
            ClassDefinition('AClass', [])
          ],
        ),
      ]);

      writeLibraryDefinitionToBuffer(buffer, definition);

      expect(buffer.toString(), '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'test_query.g.dart';

@JsonSerializable(explicitToJson: true)
class AClass with EquatableMixin {
  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) => _\$AClassFromJson(json);

  @override
  List<Object> get props => [];
  Map<String, dynamic> toJson() => _\$AClassToJson(this);
}

enum Enum {
  Value,
}
''');
    });
  });
}
