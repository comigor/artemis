import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:recase/recase.dart';
import 'package:meta/meta.dart';

import '../schema/graphql.dart';
import 'data_printer.dart';
import 'helpers.dart';

/// Callback fired when the generator processes a [LibraryDefinition].
typedef OnBuildQuery = void Function(LibraryDefinition definition);

/// Callback fired when a new class is found during schema parsing.
typedef OnNewClassFoundCallback = void Function(
  SelectionSetNode selectionSet,
  String className,
  GraphQLType parentType,
);

/// Define a property (field) from a class.
class ClassProperty extends Equatable with DataPrinter {
  /// The property type.
  final String type;

  /// The property name.
  final String name;

  /// If property is an override from super class.
  final bool isOverride;

  /// Some other custom annotation.
  final String annotation;

  /// Instantiate a property (field) from a class.
  ClassProperty({
    @required this.type,
    @required this.name,
    this.isOverride = false,
    this.annotation,
  }) : assert(hasValue(type) && hasValue(name));

  /// Creates a copy of [ClassProperty] without modifying the original.
  ClassProperty copyWith({
    String type,
    String name,
    bool isOverride,
    String annotation,
  }) =>
      ClassProperty(
        type: type ?? this.type,
        name: name ?? this.name,
        isOverride: isOverride ?? this.isOverride,
        annotation: annotation ?? this.annotation,
      );

  @override
  Map<String, Object> get namedProps => {
        'type': type,
        'name': name,
        'isOverride': isOverride,
        'annotation': annotation,
      };
}

/// Define a query/mutation input parameter.
class QueryInput extends Equatable with DataPrinter {
  /// The input type.
  final String type;

  /// The input name.
  final String name;

  /// Instantiate an input parameter.
  QueryInput({@required this.type, @required this.name})
      : assert(hasValue(type) && hasValue(name));

  @override
  Map<String, Object> get namedProps => {
        'type': type,
        'name': name,
      };
}

/// Abstract definition of an entity.
abstract class Definition extends Equatable {
  /// The definition name.
  final String name;

  /// Instantiate a definition.
  Definition({@required this.name}) : assert(hasValue(name));

  @override
  List get props => [name];
}

/// Define a Dart class parsed from GraphQL type.
class ClassDefinition extends Definition with DataPrinter {
  /// The properties (fields) of the class.
  final Iterable<ClassProperty> properties;

  /// The type this class extends from, or [null].
  final String extension;

  /// The types this class implements.
  final Iterable<String> implementations;

  /// The types this class mixins.
  final Iterable<String> mixins;

  /// The types possibilities (GraphQL type -> class name) the class
  /// implements, if it's part of an union type or interface.
  final Map<String, String> factoryPossibilities;

  /// The field name used to resolve this class type.
  final String typeNameField;

  /// Instantiate a class definition.
  ClassDefinition({
    @required String name,
    this.properties = const [],
    this.extension,
    this.implementations = const [],
    this.mixins = const [],
    this.factoryPossibilities = const {},
    this.typeNameField = '__typename',
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
      };
}

/// Define a Dart class parsed from GraphQL fragment.
class FragmentClassDefinition extends Definition with DataPrinter {
  /// The properties (fields) of the class.
  final Iterable<ClassProperty> properties;

  /// Instantiate a fragment class definition.
  FragmentClassDefinition({
    @required String name,
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
    String name,
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
  }) : assert(hasValue(queryName) && hasValue(queryType));

  @override
  Map<String, Object> get namedProps => {
        'queryName': queryName,
        'queryType': queryType,
        'classes': classes,
        'inputs': inputs,
        'generateHelpers': generateHelpers,
      };
}

/// Define a whole library file, the output of a single [SchemaMap] code
/// generation.
class LibraryDefinition extends Equatable with DataPrinter {
  /// The output file basename.
  final String basename;

  /// A list of queries.
  final Iterable<QueryDefinition> queries;

  /// An import for coercing custom scalars, defined in `build.yaml`.
  final String customParserImport;

  /// Any other custom package imports, defined in `build.yaml`.
  final Iterable<String> customImports;

  /// Instantiate a library definition.
  LibraryDefinition({
    @required this.basename,
    this.customParserImport,
    this.queries = const [],
    this.customImports = const [],
  }) : assert(hasValue(basename));

  @override
  Map<String, Object> get namedProps => {
        'basename': basename,
        'queries': queries,
        'customParserImport': customParserImport,
        'customImports': customImports,
      };
}
