import 'package:collection/collection.dart';
import 'package:gql/ast.dart';
import '../schema/graphql.dart';

final Function _eq = const ListEquality().equals;

/// Callback fired when the generator processes a [QueryDefinition].
typedef void OnBuildQuery(QueryDefinition definition);

/// Callback fired when a new class is found during schema parsing.
typedef void OnNewClassFoundCallback(
  SelectionSetNode selectionSet,
  String className,
  GraphQLType parentType,
);

/// Define a property (field) from a class.
class ClassProperty {
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

  bool operator ==(dynamic o) =>
      o is ClassProperty &&
      o.type == type &&
      o.name == name &&
      o.override == override &&
      o.annotation == annotation;
  int get hashCode =>
      type.hashCode ^ name.hashCode ^ override.hashCode ^ annotation.hashCode;
}

/// Define a query/mutation input parameter.
class QueryInput {
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

  bool operator ==(dynamic o) =>
      o is QueryInput && o.type == type && o.name == name;
  int get hashCode => type.hashCode ^ name.hashCode;
}

/// Abstract definition of an entity.
abstract class Definition {
  /// The definition name.
  final String name;

  /// Instantiate a definition.
  Definition(this.name)
      : assert(
            name != null && name.isNotEmpty, 'Name can\'t be null nor empty.');

  bool operator ==(dynamic o) => o is Definition && o.name == name;
  int get hashCode => name.hashCode;
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

  bool operator ==(dynamic o) =>
      o is ClassDefinition &&
      o.name == name &&
      _eq(o.properties, properties) &&
      o.extension == extension &&
      _eq(o.implementations, implementations) &&
      _eq(o.factoryPossibilities, factoryPossibilities) &&
      o.resolveTypeField == resolveTypeField;
  int get hashCode =>
      name.hashCode ^
      properties.hashCode ^
      extension.hashCode ^
      implementations.hashCode ^
      factoryPossibilities.hashCode ^
      resolveTypeField.hashCode;
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

  bool operator ==(dynamic o) =>
      o is EnumDefinition && o.name == name && _eq(o.values, values);
  int get hashCode => name.hashCode ^ values.hashCode;
}

/// Define a GraphQL query.
class QueryDefinition {
  /// The query name.
  final String queryName;

  /// The full query string.
  final String query;

  /// The file basename which contains the query on file path.
  final String basename;

  /// A list of classes related to this query.
  final Iterable<Definition> classes;

  /// A list of inputs related to this query.
  final Iterable<QueryInput> inputs;

  /// A custom import for this query, defined in `build.yaml`.
  final String customParserImport;

  /// If instances of [GraphQLQuery] should be generated.
  final bool generateHelpers;

  /// Any other custom packagee imports, defined in `build.yaml`.
  final Iterable<String> customImports;

  /// Instantiate a query definition.
  QueryDefinition(
    this.queryName,
    this.query,
    this.basename, {
    this.classes = const [],
    this.inputs = const [],
    this.customParserImport,
    this.generateHelpers = false,
    this.customImports = const [],
  })  : assert(queryName != null && queryName.isNotEmpty,
            'Query name must not be null or empty.'),
        assert(query != null && query.isNotEmpty,
            'Query must not be null or empty.'),
        assert(basename != null && basename.isNotEmpty,
            'Basename must not be null or empty.');

  bool operator ==(dynamic o) =>
      o is QueryDefinition &&
      o.queryName == queryName &&
      o.query == query &&
      o.basename == basename &&
      _eq(o.classes, classes) &&
      _eq(o.inputs, inputs) &&
      o.customParserImport == customParserImport &&
      o.generateHelpers == generateHelpers &&
      _eq(o.customImports, customImports);
  int get hashCode =>
      queryName.hashCode ^
      query.hashCode ^
      basename.hashCode ^
      classes.hashCode ^
      inputs.hashCode ^
      customParserImport.hashCode ^
      generateHelpers.hashCode ^
      customImports.hashCode;
}
