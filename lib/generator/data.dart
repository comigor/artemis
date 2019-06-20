import 'package:graphql_parser/graphql_parser.dart';
import 'package:artemis/schema/graphql.dart';

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

  ClassProperty(this.type, this.name,
      {this.override = false, this.annotation = ''});

  ClassProperty copyWith({type, name, override, annotation}) =>
      ClassProperty(type ?? this.type, name ?? this.name,
          override: override ?? this.override,
          annotation: annotation ?? this.annotation);
}

class QueryInput {
  final String type;
  final String name;

  QueryInput(this.type, this.name);
}

abstract class Definition {
  final String name;

  Definition(this.name);
}

class ClassDefinition extends Definition {
  final List<ClassProperty> properties;
  final String mixins;
  final Set<String> factoryPossibilities;
  final String resolveTypeField;

  ClassDefinition(
    String name,
    this.properties, {
    this.mixins = '',
    this.factoryPossibilities = const {},
    this.resolveTypeField = '__resolveType',
  })  : assert(
            factoryPossibilities.isEmpty ||
                (factoryPossibilities.isNotEmpty && resolveTypeField != null),
            'To use a custom factory, include resolveType.'),
        super(name);
}

class EnumDefinition extends Definition {
  final List<String> values;

  EnumDefinition(
    name,
    this.values,
  )   : assert(values.isNotEmpty,
            'An enum must have at least one possible value.'),
        super(name);
}

class QueryDefinition {
  final String queryName;
  final String query;
  final String basename;
  final List<Definition> classes;
  final List<QueryInput> inputs;
  final String customParserImport;
  final bool generateHelpers;

  QueryDefinition(
    this.queryName,
    this.query,
    this.basename, {
    this.classes = const [],
    this.inputs = const [],
    this.customParserImport,
    this.generateHelpers = false,
  });
}
