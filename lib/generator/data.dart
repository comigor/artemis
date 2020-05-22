import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:recase/recase.dart';
import 'package:meta/meta.dart';

import 'data_printer.dart';
import 'helpers.dart';

///
abstract class Name extends Equatable with DataPrinter {
  ///
  final String name;

  ///
  Name({this.name}) : assert(hasValue(name));

  ///
  String get namePrintable => normalizeName1(name);

  ///
  String normalizeName1(String name);
}

/// Abstract definition of an entity.
abstract class Definition extends Equatable with DataPrinter {
  /// The definition name.
  final Name name;

  /// Instantiate a definition.
  Definition({@required this.name});
}

///
class EnumName extends Name with DataPrinter {
  ///
  EnumName({String name}) : super(name: name);

  @override
  String normalizeName1(String name) => name;

  @override
  Map<String, Object> get namedProps => {
        'name': name,
      };
}

///
class ClassName extends Name {
  ///
  ClassName({String name}) : super(name: name);

  ///
  @override
  String normalizeName1(String name) => ReCase(name).pascalCase;

  @override
  Map<String, Object> get namedProps => {
        'name': name,
      };
}

///
class VariableName extends Name {
  ///
  VariableName({String name}) : super(name: name);

  ///
  @override
  String normalizeName1(String name) => ReCase(name).camelCase;

  @override
  Map<String, Object> get namedProps => {
        'name': name,
      };
}

/// Callback fired when the generator processes a [LibraryDefinition].
typedef OnBuildQuery = void Function(LibraryDefinition definition);

/// Define a property (field) from a class.
class ClassProperty extends Definition with DataPrinter {
  /// The property type.
  final String type;

  /// Some other custom annotation.
  final List<String> annotations;

  /// Whether this parameter is required
  final bool isNonNull;

  /// Whether this parameter corresponds to the __resolveType (or equivalent)
  final bool isResolveType;

  /// Instantiate a property (field) from a class.
  ClassProperty({
    @required this.type,
    this.annotations = const [],
    this.isNonNull = false,
    this.isResolveType = false,
    @required Name name,
  })  : assert(hasValue(type) && hasValue(name)),
        super(name: name);

  /// If property is an override from super class.
  bool get isOverride => annotations.contains('override');

  /// Creates a copy of [ClassProperty] without modifying the original.
  ClassProperty copyWith({
    String type,
    Name name,
    List<String> annotations,
    bool isNonNull,
    bool isResolveType,
  }) =>
      ClassProperty(
        type: type ?? this.type,
        name: name ?? this.name,
        annotations: annotations ?? this.annotations,
        isNonNull: isNonNull ?? this.isNonNull,
        isResolveType: isResolveType ?? this.isResolveType,
      );

  @override
  Map<String, Object> get namedProps => {
        'type': type,
        'name': name,
        'annotations': annotations,
        'isNonNull': isNonNull,
        'isResolveType': isResolveType,
      };
}

/// Define a query/mutation input parameter.
class QueryInput extends Definition with DataPrinter {
  /// The input type.
  final String type;

  /// Whether this parameter is required
  final bool isNonNull;

  /// Some other custom annotation.
  final List<String> annotations;

  /// Instantiate an input parameter.
  QueryInput({
    @required this.type,
    this.isNonNull = false,
    this.annotations = const [],
    Name name,
  })  : assert(hasValue(type) && hasValue(name)),
        super(name: name);

  @override
  Map<String, Object> get namedProps => {
        'type': type,
        'name': name,
        'isNonNull': isNonNull,
        'annotations': annotations,
      };
}

/// Define a Dart class parsed from GraphQL type.
class ClassDefinition extends Definition with DataPrinter {
  /// The properties (fields) of the class.
  final Iterable<ClassProperty> properties;

  /// The type this class extends from, or [null].
  final Name extension;

  /// The types this class implements.
  final Iterable<String> implementations;

  /// The types this class mixins.
  final Iterable<String> mixins;

  /// The types possibilities (GraphQL type -> class name) the class
  /// implements, if it's part of an union type or interface.
  final Map<String, String> factoryPossibilities;

  /// The field name used to resolve this class type.
  final String typeNameField;

  /// Wheter this is an input object or not.
  final bool isInput;

  /// Instantiate a class definition.
  ClassDefinition({
    @required Name name,
    this.properties = const [],
    this.extension,
    this.implementations = const [],
    this.mixins = const [],
    this.factoryPossibilities = const {},
    this.typeNameField = '__typename',
    this.isInput = false,
  })  : assert(hasValue(name)),
        super(name: name);

  @override
  Map<String, Object> get namedProps => {
        'name': name,
        'properties': properties,
        'extension': extension,
        'implementations': implementations,
        'mixins': mixins,
        'factoryPossibilities': factoryPossibilities,
        'typeNameField': typeNameField,
        'isInput': isInput,
      };
}

/// Define a Dart class parsed from GraphQL fragment.
class FragmentClassDefinition extends Definition with DataPrinter {
  /// The properties (fields) of the class.
  final Iterable<ClassProperty> properties;

  /// Instantiate a fragment class definition.
  FragmentClassDefinition({
    @required Name name,
    @required this.properties,
  })  : assert(hasValue(name) && hasValue(properties)),
        super(name: name);

  @override
  Map<String, Object> get namedProps => {
        'name': name,
        'properties': properties,
      };
}

/// Define a Dart enum parsed from GraphQL schema.
class EnumDefinition extends Definition with DataPrinter {
  /// The possible values of this enum.
  final Iterable<String> values;

  /// Instantiate an enum definition.
  EnumDefinition({
    @required Name name,
    this.values,
  })  : assert(hasValue(name) && hasValue(values)),
        super(name: name);

  @override
  Map<String, Object> get namedProps => {
        'name': name,
        'values': values,
      };
}

/// Define a GraphQL query and its dependencies.
class QueryDefinition extends Equatable with DataPrinter {
  /// The query name.
  final String queryName;

  /// The query type name.
  final String queryType;

  /// The AST representation of GraphQL document.
  final DocumentNode document;

  /// A list of classes related to this query.
  final Iterable<Definition> classes;

  /// A list of inputs related to this query.
  final Iterable<QueryInput> inputs;

  /// If instances of [GraphQLQuery] should be generated.
  final bool generateHelpers;

  /// The suffix of generated [GraphQLQuery] classes.
  final String suffix;

  /// The class name.
  String get className => ReCase(queryName).pascalCase;

  /// Instantiate a query definition.
  QueryDefinition({
    @required this.queryName,
    @required this.queryType,
    this.document = const DocumentNode(),
    this.classes = const [],
    this.inputs = const [],
    this.generateHelpers = false,
    this.suffix = 'Query',
  }) : assert(hasValue(queryName) && hasValue(queryType));

  @override
  Map<String, Object> get namedProps => {
        'queryName': queryName,
        'queryType': queryType,
        'classes': classes,
        'inputs': inputs,
        'generateHelpers': generateHelpers,
        'suffix': suffix,
      };
}

/// Define a whole library file, the output of a single [SchemaMap] code
/// generation.
class LibraryDefinition extends Equatable with DataPrinter {
  /// The output file basename.
  final String basename;

  /// A list of queries.
  final Iterable<QueryDefinition> queries;

  /// Any other custom package imports, defined in `build.yaml`.
  final Iterable<String> customImports;

  /// Instantiate a library definition.
  LibraryDefinition({
    @required this.basename,
    this.queries = const [],
    this.customImports = const [],
  }) : assert(hasValue(basename));

  @override
  Map<String, Object> get namedProps => {
        'basename': basename,
        'queries': queries,
        'customImports': customImports,
      };
}
