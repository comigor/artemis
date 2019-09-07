import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import '../schema/graphql.dart';

/// Callback fired when the generator processes a [LibraryDefinition].
typedef void OnBuildQuery(LibraryDefinition definition);

/// Callback fired when a new class is found during schema parsing.
typedef void OnNewClassFoundCallback(
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
  final bool override;

  /// Some other custom annotation.
  final String annotation;

  /// Instantiate a property (field) from a class.
  ClassProperty(this.type, this.name, {this.override = false, this.annotation});

  /// Creates a copy of [ClassProperty] without modifying the original.
  ClassProperty copyWith(
          {String type, String name, bool override, String annotation}) =>
      ClassProperty(type ?? this.type, name ?? this.name,
          override: override ?? this.override,
          annotation: annotation ?? this.annotation);

  List get props => [type, name, override, annotation];
}

/// Define a query/mutation input parameter.
class QueryInput extends Equatable {
  /// The input type.
  final String type;

  /// The input name.
  final String name;

  /// Instantiate an input parameter.
  QueryInput(this.type, this.name)
      : assert(
            type != null && type.isNotEmpty, 'Type can\'t be null nor empty.'),
        assert(
            name != null && name.isNotEmpty, 'Name can\'t be null nor empty.');

  @override
  List get props => [type, name];
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
  List get props => [name];
}

/// Define a Dart class parsed from GraphQL schema.
class ClassDefinition extends Definition {
  /// The properties (fields) of the class.
  final Iterable<ClassProperty> properties;

  /// The type this class extends from, or [null].
  final String extension;

  /// The types this class implements.
  final Iterable<String> implementations;

  /// The types possibilities the class implements, if it's part of an union
  /// type or interface.
  final Iterable<String> factoryPossibilities;

  /// The field name used to resolve this class type.
  final String resolveTypeField;

  /// Instantiate a class definition.
  ClassDefinition(
    String name,
    this.properties, {
    this.extension,
    this.implementations = const [],
    this.factoryPossibilities = const [],
    this.resolveTypeField = '__resolveType',
  }) : super(name);

  @override
  List get props => [
        name,
        properties,
        extension,
        implementations,
        factoryPossibilities,
        resolveTypeField,
      ];
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
  List get props => [name, values];
}

/// Define a GraphQL query and its dependencies.
class QueryDefinition extends Equatable {
  /// The query name.
  final String queryName;

  /// The full query string.
  final String query;

  /// A list of classes related to this query.
  final Iterable<Definition> classes;

  /// A list of inputs related to this query.
  final Iterable<QueryInput> inputs;

  /// If instances of [GraphQLQuery] should be generated.
  final bool generateHelpers;

  /// Instantiate a query definition.
  QueryDefinition(
    this.queryName,
    this.query, {
    this.classes = const [],
    this.inputs = const [],
    this.generateHelpers = false,
  })  : assert(queryName != null && queryName.isNotEmpty,
            'Query name must not be null or empty.'),
        assert(query != null && query.isNotEmpty,
            'Query must not be null or empty.');

  @override
  List get props => [queryName, query, classes, inputs, generateHelpers];
}

/// Define a whole library file, the output of a single [SchemaMap] code
/// generation.
class LibraryDefinition extends Equatable {
  /// The file basename which contains the query on file path.
  final String basename;

  /// A list of queries.
  final Iterable<QueryDefinition> queries;

  /// A custom import for this query, defined in `build.yaml`.
  final String customParserImport;

  /// Any other custom packagee imports, defined in `build.yaml`.
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
  List get props => [basename, queries, customParserImport, customImports];
}
