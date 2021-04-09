// @dart = 2.8

import 'package:artemis/generator/data/data.dart';
import 'package:artemis/generator/data/enum_value_definition.dart';
import 'package:artemis/generator/print_helpers.dart';
import 'package:gql/language.dart';
import 'package:test/test.dart';

void main() {
  group('On printCustomEnum', () {
    test('It will throw if name is empty.', () {
      expect(
          () => enumDefinitionToSpec(
              EnumDefinition(name: EnumName(name: ''), values: [])),
          throwsA(TypeMatcher<AssertionError>()));
    });

    test('It will throw if values is empty.', () {
      // expect(
      //     () => enumDefinitionToSpec(
      //         EnumDefinition(name: EnumName(name: 'Name'), values: null)),
      //     throwsA(TypeMatcher<AssertionError>()));
      expect(
          () => enumDefinitionToSpec(
              EnumDefinition(name: EnumName(name: 'Name'), values: [])),
          throwsA(TypeMatcher<AssertionError>()));
    });

    test('It will generate an Enum declaration.', () {
      final definition = EnumDefinition(name: EnumName(name: 'Name'), values: [
        EnumValueDefinition(
          name: EnumValueName(name: 'Option'),
        ),
        EnumValueDefinition(
          name: EnumValueName(name: 'anotherOption'),
        ),
        EnumValueDefinition(
          name: EnumValueName(name: 'third_option'),
        ),
        EnumValueDefinition(
          name: EnumValueName(name: 'FORTH_OPTION'),
        ),
      ]);

      final str = specToString(enumDefinitionToSpec(definition));

      expect(str, '''enum Name {
  @JsonValue('Option')
  option,
  @JsonValue('anotherOption')
  anotherOption,
  @JsonValue('third_option')
  thirdOption,
  @JsonValue('FORTH_OPTION')
  forthOption,
}
''');
    });

    test('It will ignore duplicate options.', () {
      final definition = EnumDefinition(name: EnumName(name: 'Name'), values: [
        EnumValueDefinition(
          name: EnumValueName(name: 'Option'),
        ),
        EnumValueDefinition(
          name: EnumValueName(name: 'AnotherOption'),
        ),
        EnumValueDefinition(
          name: EnumValueName(name: 'Option'),
        ),
        EnumValueDefinition(
          name: EnumValueName(name: 'AnotherOption'),
        ),
      ]);

      final str = specToString(enumDefinitionToSpec(definition));

      expect(str, '''enum Name {
  @JsonValue('Option')
  option,
  @JsonValue('AnotherOption')
  anotherOption,
}
''');
    });
  });

  group('On printCustomFragmentClass', () {
    test('It will throw if name is null or empty.', () {
      expect(
          () => fragmentClassDefinitionToSpec(
              FragmentClassDefinition(name: null, properties: [])),
          throwsA(TypeMatcher<AssertionError>()));
      expect(
          () => fragmentClassDefinitionToSpec(FragmentClassDefinition(
              name: FragmentName(name: ''), properties: [])),
          throwsA(TypeMatcher<AssertionError>()));
    });

    test('It will generate an Mixins declarations.', () {
      final definition = FragmentClassDefinition(
          name: FragmentName(name: 'FragmentMixin'),
          properties: [
            ClassProperty(
                type: TypeName(name: 'Type'),
                name: ClassPropertyName(name: 'name')),
            ClassProperty(
                type: TypeName(name: 'Type'),
                name: ClassPropertyName(name: 'name'),
                annotations: ['override']),
            ClassProperty(
                type: TypeName(name: 'Type'),
                name: ClassPropertyName(name: 'name'),
                annotations: ['Test']),
          ]);

      final str = specToString(fragmentClassDefinitionToSpec(definition));

      expect(str, '''mixin FragmentMixin {
  Type? name;
  @override
  Type? name;
  @Test
  Type? name;
}
''');
    });
  });

  group('On printCustomClass', () {
    test('It will throw if name is empty.', () {
      // expect(
      //     () => classDefinitionToSpec(
      //         ClassDefinition(name: null, properties: []), [], []),
      //     throwsA(TypeMatcher<AssertionError>()));
      expect(
          () => classDefinitionToSpec(
              ClassDefinition(name: ClassName(name: ''), properties: []),
              [],
              []),
          throwsA(TypeMatcher<AssertionError>()));
    });

    test('It can generate a class without properties.', () {
      final definition =
          ClassDefinition(name: ClassName(name: 'AClass'), properties: []);

      final str = specToString(classDefinitionToSpec(definition, [], []));

      expect(str, '''@JsonSerializable(explicitToJson: true)
class AClass extends JsonSerializable with EquatableMixin {
  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) => _\$AClassFromJson(json);

  @override
  List<Object?> get props => [];
  Map<String, dynamic> toJson() => _\$AClassToJson(this);
}
''');
    });

    test('"Mixins" will be included to class.', () {
      final definition = ClassDefinition(
          name: ClassName(name: 'AClass'),
          properties: [],
          extension: ClassName(name: 'AnotherClass'));

      final str = specToString(classDefinitionToSpec(definition, [], []));

      expect(str, '''@JsonSerializable(explicitToJson: true)
class AClass extends AnotherClass with EquatableMixin {
  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) => _\$AClassFromJson(json);

  @override
  List<Object?> get props => [];
  Map<String, dynamic> toJson() => _\$AClassToJson(this);
}
''');
    });

    test(
        'factoryPossibilities and typeNameField are used to generated a branch factory.',
        () {
      final definition = ClassDefinition(
        name: ClassName(name: 'AClass'),
        properties: [],
        factoryPossibilities: {
          'ASubClass': ClassName(name: 'ASubClass'),
          'BSubClass': ClassName(name: 'BSubClass'),
        },
        typeNameField: ClassPropertyName(name: '__typename'),
      );

      final str = specToString(classDefinitionToSpec(definition, [], []));

      expect(str, r'''@JsonSerializable(explicitToJson: true)
class AClass extends JsonSerializable with EquatableMixin {
  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) {
    switch (json['__typename'].toString()) {
      case r'ASubClass':
        return ASubClass.fromJson(json);
      case r'BSubClass':
        return BSubClass.fromJson(json);
      default:
    }
    return _$AClassFromJson(json);
  }

  @override
  List<Object?> get props => [];
  Map<String, dynamic> toJson() {
    switch ($$typename) {
      case r'ASubClass':
        return (this as ASubClass).toJson();
      case r'BSubClass':
        return (this as BSubClass).toJson();
      default:
    }
    return _$AClassToJson(this);
  }
}
''');
    });

    test('It can have properties.', () {
      final definition =
          ClassDefinition(name: ClassName(name: 'AClass'), properties: [
        ClassProperty(
            type: TypeName(name: 'Type'),
            name: ClassPropertyName(name: 'name')),
        ClassProperty(
            type: TypeName(name: 'AnotherType'),
            name: ClassPropertyName(name: 'anotherName')),
      ]);

      final str = specToString(classDefinitionToSpec(definition, [], []));

      expect(str, '''@JsonSerializable(explicitToJson: true)
class AClass extends JsonSerializable with EquatableMixin {
  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) => _\$AClassFromJson(json);

  Type? name;

  AnotherType? anotherName;

  @override
  List<Object?> get props => [name, anotherName];
  Map<String, dynamic> toJson() => _\$AClassToJson(this);
}
''');
    });

    test(
        'Its properties can be an override or have a custom annotation, or both.',
        () {
      final definition =
          ClassDefinition(name: ClassName(name: 'AClass'), properties: [
        ClassProperty(
            type: TypeName(name: 'Type'),
            name: ClassPropertyName(name: 'name')),
        ClassProperty(
            type: TypeName(name: 'AnnotatedProperty'),
            name: ClassPropertyName(name: 'name'),
            annotations: ['Hey()']),
        ClassProperty(
            type: TypeName(name: 'OverridenProperty'),
            name: ClassPropertyName(name: 'name'),
            annotations: ['override']),
        ClassProperty(
            type: TypeName(name: 'AllAtOnce'),
            name: ClassPropertyName(name: 'name'),
            annotations: ['override', 'Ho()']),
      ]);

      final str = specToString(classDefinitionToSpec(definition, [], []));

      expect(str, '''@JsonSerializable(explicitToJson: true)
class AClass extends JsonSerializable with EquatableMixin {
  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) => _\$AClassFromJson(json);

  Type? name;

  @Hey()
  AnnotatedProperty? name;

  @override
  OverridenProperty? name;

  @override
  @Ho()
  AllAtOnce? name;

  @override
  List<Object?> get props => [name, name, name, name];
  Map<String, dynamic> toJson() => _\$AClassToJson(this);
}
''');
    });

    test(
        'Mixins can be included and its properties will be considered on props getter',
        () {
      final definition = ClassDefinition(
          name: ClassName(name: 'AClass'),
          properties: [],
          mixins: [FragmentName(name: 'FragmentMixin')]);

      final str = specToString(classDefinitionToSpec(definition, [
        FragmentClassDefinition(
            name: FragmentName(name: 'FragmentMixin'),
            properties: [
              ClassProperty(
                  type: TypeName(name: 'Type'),
                  name: ClassPropertyName(name: 'name')),
            ])
      ], []));

      expect(str, '''@JsonSerializable(explicitToJson: true)
class AClass extends JsonSerializable with EquatableMixin, FragmentMixin {
  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) => _\$AClassFromJson(json);

  @override
  List<Object?> get props => [name];
  Map<String, dynamic> toJson() => _\$AClassToJson(this);
}
''');
    });

    test('It can be an input object (and have a named parameter constructor).',
        () {
      final definition = ClassDefinition(
        name: ClassName(name: 'AClass'),
        properties: [
          ClassProperty(
              type: TypeName(name: 'Type'),
              name: ClassPropertyName(name: 'name')),
          ClassProperty(
              type: TypeName(name: 'AnotherType', isNonNull: true),
              name: ClassPropertyName(name: 'anotherName')),
        ],
        isInput: true,
      );

      final str = specToString(classDefinitionToSpec(definition, [], []));

      expect(str, '''@JsonSerializable(explicitToJson: true)
class AClass extends JsonSerializable with EquatableMixin {
  AClass({this.name, required this.anotherName});

  factory AClass.fromJson(Map<String, dynamic> json) => _\$AClassFromJson(json);

  Type? name;

  late AnotherType anotherName;

  @override
  List<Object?> get props => [name, anotherName];
  Map<String, dynamic> toJson() => _\$AClassToJson(this);
}
''');
    });
  });

  group('On generateQueryClassSpec', () {
    test('It will throw if basename is null or empty.', () {
      expect(() => generateLibrarySpec(LibraryDefinition(basename: null)),
          throwsA(TypeMatcher<AssertionError>()));
      expect(() => generateLibrarySpec(LibraryDefinition(basename: '')),
          throwsA(TypeMatcher<AssertionError>()));
    });

    test('It will throw if query name/type is null or empty.', () {
      expect(
        () => generateQueryClassSpec(
          QueryDefinition(
              name: QueryName(name: ''),
              operationName: 'Type',
              document: parseString('query test_query {}')),
        ),
        throwsA(TypeMatcher<AssertionError>()),
      );
      expect(
        () => generateQueryClassSpec(
          QueryDefinition(
              name: QueryName(name: 'Type'),
              operationName: '',
              document: parseString('query test_query {}')),
        ),
        throwsA(
          TypeMatcher<AssertionError>(),
        ),
      );
      expect(
        () => generateQueryClassSpec(
          QueryDefinition(
              name: QueryName(name: null),
              operationName: 'test_query',
              document: parseString('query test_query {}')),
        ),
        throwsA(
          TypeMatcher<AssertionError>(),
        ),
      );
      expect(
        () => generateQueryClassSpec(
          QueryDefinition(
              name: QueryName(name: ''),
              operationName: 'test_query',
              document: parseString('query test_query {}')),
        ),
        throwsA(
          TypeMatcher<AssertionError>(),
        ),
      );
    });

    test('It should generated an empty file by default.', () {
      final buffer = StringBuffer();
      final definition = LibraryDefinition(basename: r'test_query.graphql');
      final ignoreForFile = <String>[];
      writeLibraryDefinitionToBuffer(buffer, ignoreForFile, definition);

      expect(buffer.toString(), '''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'test_query.graphql.g.dart';
''');
    });

    test('When there are custom imports, they are included.', () {
      final buffer = StringBuffer();
      final definition = LibraryDefinition(
          basename: r'test_query.graphql', customImports: ['some_file.dart']);
      final ignoreForFile = <String>[];

      writeLibraryDefinitionToBuffer(buffer, ignoreForFile, definition);

      expect(buffer.toString(), '''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'some_file.dart';
part 'test_query.graphql.g.dart';
''');
    });

    test('When generateHelpers is true, an execute fn is generated.', () {
      final buffer = StringBuffer();
      final definition = LibraryDefinition(
        basename: r'test_query.graphql',
        queries: [
          QueryDefinition(
            name: QueryName(name: 'test_query'),
            operationName: 'test_query',
            document: parseString('query test_query {}'),
            generateHelpers: true,
          )
        ],
      );
      final ignoreForFile = <String>[];

      writeLibraryDefinitionToBuffer(buffer, ignoreForFile, definition);

      expect(buffer.toString(), '''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'test_query.graphql.g.dart';

final TEST_QUERY_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'test_query'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: []))
]);

class TestQueryQuery extends GraphQLQuery<TestQuery, JsonSerializable> {
  TestQueryQuery();

  @override
  final DocumentNode document = TEST_QUERY_QUERY_DOCUMENT;

  @override
  final String operationName = 'test_query';

  @override
  List<Object?> get props => [document, operationName];
  @override
  TestQuery parse(Map<String, dynamic> json) => TestQuery.fromJson(json);
}
''');
    });

    test('The generated execute fn could have input.', () {
      final buffer = StringBuffer();
      final definition =
          LibraryDefinition(basename: r'test_query.graphql', queries: [
        QueryDefinition(
          name: QueryName(name: 'test_query'),
          operationName: 'test_query',
          document: parseString('query test_query {}'),
          generateHelpers: true,
          inputs: [
            QueryInput(
                type: TypeName(name: 'Type'),
                name: QueryInputName(name: 'name'))
          ],
        ),
      ]);
      final ignoreForFile = <String>[];

      writeLibraryDefinitionToBuffer(buffer, ignoreForFile, definition);

      expect(buffer.toString(), '''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'test_query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class TestQueryArguments extends JsonSerializable with EquatableMixin {
  TestQueryArguments({this.name});

  @override
  factory TestQueryArguments.fromJson(Map<String, dynamic> json) =>
      _\$TestQueryArgumentsFromJson(json);

  final Type? name;

  @override
  List<Object?> get props => [name];
  @override
  Map<String, dynamic> toJson() => _\$TestQueryArgumentsToJson(this);
}

final TEST_QUERY_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'test_query'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: []))
]);

class TestQueryQuery extends GraphQLQuery<TestQuery, TestQueryArguments> {
  TestQueryQuery({required this.variables});

  @override
  final DocumentNode document = TEST_QUERY_QUERY_DOCUMENT;

  @override
  final String operationName = 'test_query';

  @override
  final TestQueryArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  TestQuery parse(Map<String, dynamic> json) => TestQuery.fromJson(json);
}
''');
    });

    test('Will generate an Arguments class', () {
      final definition = QueryDefinition(
        name: QueryName(name: 'test_query'),
        operationName: 'test_query',
        document: parseString('query test_query {}'),
        generateHelpers: true,
        inputs: [
          QueryInput(
              type: TypeName(name: 'Type'), name: QueryInputName(name: 'name'))
        ],
      );

      final str = specToString(generateArgumentClassSpec(definition));

      expect(str, '''@JsonSerializable(explicitToJson: true)
class TestQueryArguments extends JsonSerializable with EquatableMixin {
  TestQueryArguments({this.name});

  @override
  factory TestQueryArguments.fromJson(Map<String, dynamic> json) =>
      _\$TestQueryArgumentsFromJson(json);

  final Type? name;

  @override
  List<Object?> get props => [name];
  @override
  Map<String, dynamic> toJson() => _\$TestQueryArgumentsToJson(this);
}
''');
    });

    test('Will generate a Query Class', () {
      final definition = QueryDefinition(
        name: QueryName(name: 'test_query'),
        operationName: 'test_query',
        document: parseString('query test_query {}'),
        generateHelpers: true,
        inputs: [
          QueryInput(
              type: TypeName(name: 'Type'), name: QueryInputName(name: 'name'))
        ],
        suffix: 'Query',
      );

      final str =
          generateQueryClassSpec(definition).map((e) => specToString(e)).join();

      expect(
          str, '''final TEST_QUERY_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'test_query'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: []))
]);
class TestQueryQuery extends GraphQLQuery<TestQuery, TestQueryArguments> {
  TestQueryQuery({required this.variables});

  @override
  final DocumentNode document = TEST_QUERY_QUERY_DOCUMENT;

  @override
  final String operationName = 'test_query';

  @override
  final TestQueryArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  TestQuery parse(Map<String, dynamic> json) => TestQuery.fromJson(json);
}
''');
    });

    test('It will accept and write class/enum definitions.', () {
      final buffer = StringBuffer();
      final definition =
          LibraryDefinition(basename: r'test_query.graphql', queries: [
        QueryDefinition(
          name: QueryName(name: 'test_query'),
          operationName: 'test_query',
          document: parseString('query test_query {}'),
          classes: [
            EnumDefinition(name: EnumName(name: 'SomeEnum'), values: [
              EnumValueDefinition(
                name: EnumValueName(name: 'Value'),
              )
            ]),
            ClassDefinition(name: ClassName(name: 'AClass'), properties: [])
          ],
        ),
      ]);
      final ignoreForFile = <String>[];

      writeLibraryDefinitionToBuffer(buffer, ignoreForFile, definition);

      expect(buffer.toString(), '''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'test_query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class AClass extends JsonSerializable with EquatableMixin {
  AClass();

  factory AClass.fromJson(Map<String, dynamic> json) => _\$AClassFromJson(json);

  @override
  List<Object?> get props => [];
  Map<String, dynamic> toJson() => _\$AClassToJson(this);
}

enum SomeEnum {
  @JsonValue('Value')
  value,
}
''');
    });
  });

  test('Should not add ignore_for_file when ignoreForFile is null', () {
    final buffer = StringBuffer();
    final definition = LibraryDefinition(basename: r'test_query.graphql');
    final List<String> ignoreForFile = [];

    writeLibraryDefinitionToBuffer(buffer, ignoreForFile, definition);

    expect(buffer.toString(), '''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'test_query.graphql.g.dart';
''');
  });

  test('Should not add ignore_for_file when ignoreForFile is empty', () {
    final buffer = StringBuffer();
    final definition = LibraryDefinition(basename: r'test_query.graphql');
    final ignoreForFile = <String>[];

    writeLibraryDefinitionToBuffer(buffer, ignoreForFile, definition);

    expect(buffer.toString(), '''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'test_query.graphql.g.dart';
''');
  });

  test('Should add // ignore_for_file: ... when ignoreForFile is not empty',
      () {
    final buffer = StringBuffer();
    final definition = LibraryDefinition(basename: r'test_query.graphql');
    final ignoreForFile = <String>['my_rule_1', 'my_rule_2'];

    writeLibraryDefinitionToBuffer(buffer, ignoreForFile, definition);

    expect(buffer.toString(), '''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12
// ignore_for_file: my_rule_1, my_rule_2

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'test_query.graphql.g.dart';
''');
  });
}
