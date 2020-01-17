import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:recase/recase.dart';

import '../schema/graphql.dart';

/// Callback fired when the generator processes a [LibraryDefinition].
typedef OnBuildQuery = void Function(LibraryDefinition definition);

/// Callback fired when a new class is found during schema parsing.
typedef OnNewClassFoundCallback = void Function(
  SelectionSetNode selectionSet,
  String className,
  GraphQLType parentType,
);

/// Define a property (field) from a class.
class ClassProperty extends Equatable {
  /// The property type.
  final String type;

  /// The property name.
  final String name;

  /// If property is an override from super class.
  final bool isOverride;

  /// Some other custom annotation.
  final String annotation;

  /// Instantiate a property (field) from a class.
  ClassProperty(this.type, this.name,
      {this.isOverride = false, this.annotation});

  /// Creates a copy of [ClassProperty] without modifying the original.
  ClassProperty copyWith(
          {String type, String name, bool isOverride, String annotation}) =>
      ClassProperty(type ?? this.type, name ?? this.name,
          isOverride: isOverride ?? this.isOverride,
          annotation: annotation ?? this.annotation);

  @override
  String toString() => props.toList().toString();

  @override
  List get props => [type, name, isOverride, annotation];
}

/// Define a query/mutation input parameter.
class QueryInput extends Equatable {
  /// The input type.
  final String type;

  /// The input name.
  final String name;

  /// Whether this parameter is required
  final bool isNonNull;

  /// Instantiate an input parameter.
  QueryInput(this.type, this.name, this.isNonNull)
      : assert(
            type != null && type.isNotEmpty, 'Type can\'t be null nor empty.'),
        assert(
            name != null && name.isNotEmpty, 'Name can\'t be null nor empty.');

  @override
  List get props => [type, name, isNonNull];
}

/// Abstract definition of an entity.
abstract class Definition extends Equatable {
  /// The definition name.
  final String name;

  /// Instantiate a definition.
  Definition(this.name)
      : assert(
            name != null && name.isNotEmpty, 'Name can\'t be null nor empty.');

  @override
  String toString() => props.toList().toString();

  @override
  List get props => [name];
}

/// Define a Dart class parsed from GraphQL type.
class ClassDefinition extends Definition {
  /// The properties (fields) of the class.
  final Iterable<ClassProperty> properties;

  /// The type this class extends from, or [null].
  final String extension;

  /// The types this class implements.
  final Iterable<String> implementations;

  /// The types this class mixins.
  final Iterable<FragmentClassDefinition> mixins;

  /// The types possibilities the class implements, if it's part of an union
  /// type or interface.
  final Iterable<String> factoryPossibilities;

  /// The prefix this class and its relations will use.
  // TODO(igor): make everything use this prefix
  final String prefix;

  /// The field name used to resolve this class type.
  final String resolveTypeField;

  /// Instantiate a class definition.
  ClassDefinition(
    String name,
    this.properties, {
    this.prefix = '',
    this.extension,
    this.implementations = const [],
    this.mixins = const [],
    this.factoryPossibilities = const [],
    this.resolveTypeField = '__resolveType',
  }) : super(name);

  @override
  String toString() => props.toList().toString();

  @override
  List get props => [
        name,
        properties,
        prefix,
        extension,
        implementations,
        mixins,
        factoryPossibilities,
        resolveTypeField,
      ];
}

/// Define a Dart class parsed from GraphQL fragment.
class FragmentClassDefinition extends Definition {
  /// The properties (fields) of the class.
  final Iterable<ClassProperty> properties;

  /// Instantiate a fragment class definition.
  FragmentClassDefinition(
    String name,
    this.properties,
  ) : super(name);

  @override
  String toString() => props.toList().toString();

  @override
  List get props => [name, properties];
}

/// Define a Dart enum parsed from GraphQL schema.
class EnumDefinition extends Definition {
  /// The possible values of this enum.
  final Iterable<String> values;

  /// Instantiate an enum definition.
  EnumDefinition(
    String name,
    this.values,
  )   : assert(values != null && values.isNotEmpty,
            'An enum must have at least one possible value.'),
        super(name);

  @override
  String toString() => props.toList().toString();

  @override
  List get props => [name, values];
}

/// Define a GraphQL query and its dependencies.
class QueryDefinition extends Equatable {
  /// The query name.
  final String queryName;

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
  QueryDefinition(
    this.queryName,
    this.document, {
    this.classes = const [],
    this.inputs = const [],
    this.generateHelpers = false,
  })  : assert(
          queryName != null && queryName.isNotEmpty,
          'Query name must not be null or empty.',
        ),
        assert(
          document != null,
          'Query must not be null or empty.',
        );

  @override
  String toString() => props.toList().toString();

  @override
  List get props => [queryName, document, classes, inputs, generateHelpers];
}

/// Define a whole library file, the output of a single [SchemaMap] code
/// generation.
class LibraryDefinition extends Equatable {
  /// The output file basename.
  final String basename;

  /// A list of queries.
  final Iterable<QueryDefinition> queries;

  /// An import for coercing custom scalars, defined in `build.yaml`.
  final String customParserImport;

  /// Any other custom package imports, defined in `build.yaml`.
  final Iterable<String> customImports;

  /// Instantiate a library definition.
  LibraryDefinition(
    this.basename, {
    this.customParserImport,
    this.queries = const [],
    this.customImports = const [],
  }) : assert(basename != null && basename.isNotEmpty,
            'Basename must not be null or empty.');

  @override
  String toString() => props.toList().toString();

  @override
  List get props => [basename, queries, customParserImport, customImports];
}
