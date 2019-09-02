import 'package:collection/collection.dart';
import 'package:graphql_parser/graphql_parser.dart';
import '../schema/graphql.dart';

final Function _eq = const ListEquality().equals;

typedef void OnBuildQuery(QueryDefinition definition);

typedef void OnNewClassFoundCallback(
  SelectionSetContext selectionSet,
  String className,
  GraphQLType parentType,
);

class ClassProperty {
  final String type;
  final String name;
  final bool override;
  final String annotation;

  ClassProperty(this.type, this.name, {this.override = false, this.annotation});

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

class QueryInput {
  final String type;
  final String name;

  QueryInput(this.type, this.name)
      : assert(
            type != null && type.isNotEmpty, 'Type can\'t be null nor empty.'),
        assert(
            name != null && name.isNotEmpty, 'Name can\'t be null nor empty.');

  bool operator ==(dynamic o) =>
      o is QueryInput && o.type == type && o.name == name;
  int get hashCode => type.hashCode ^ name.hashCode;
}

abstract class Definition {
  final String name;

  Definition(this.name)
      : assert(
            name != null && name.isNotEmpty, 'Name can\'t be null nor empty.');

  bool operator ==(dynamic o) => o is Definition && o.name == name;
  int get hashCode => name.hashCode;
}

class ClassDefinition extends Definition {
  final Iterable<ClassProperty> properties;
  final String extension;
  final Iterable<String> implementations;
  final Iterable<String> factoryPossibilities;
  final String resolveTypeField;

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

class EnumDefinition extends Definition {
  final Iterable<String> values;

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

class QueryDefinition {
  final String queryName;
  final String query;
  final String basename;
  final Iterable<Definition> classes;
  final Iterable<QueryInput> inputs;
  final String customParserImport;
  final bool generateHelpers;
  final Iterable<String> customImports;

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
