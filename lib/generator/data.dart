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

class ClassDefinition {
  final String className;
  final List<ClassProperty> classProperties;
  final String mixins;
  final Set<String> factoryPossibilities;
  final String resolveTypeField;

  ClassDefinition(
    this.className,
    this.classProperties, {
    this.mixins = '',
    this.factoryPossibilities = const {},
    this.resolveTypeField = '__resolveType',
  }) : assert(
            factoryPossibilities.isEmpty ||
                (factoryPossibilities.isNotEmpty && resolveTypeField != null),
            'To use a custom factory, include resolveType.');
}
