import 'package:meta/meta.dart';
import 'package:gql/ast.dart';

import './data.dart';
import '../schema/graphql.dart';
import '../schema/options.dart';

/// References options while on [_GeneratorVisitor] iterations.
class InjectedOptions {
  /// Instantiates options for [_GeneratorVisitor] iterations.
  InjectedOptions({
    @required this.schema,
    @required this.options,
    @required this.schemaMap,
  });

  /// The [GraphQLSchema] parsed from `build.yaml` configuration.
  final GraphQLSchema schema;

  /// Other options parsed from `build.yaml` configuration.
  final GeneratorOptions options;

  /// The [SchemaMap] being used on this iteration.
  final SchemaMap schemaMap;
}

/// Holds context between [_GeneratorVisitor] iterations.
class Context {
  /// Instantiates context for [_GeneratorVisitor] iterations.
  Context({
    @required this.path,
    @required this.currentType,
    this.alias,
    this.ofUnion,
    @required this.generatedClasses,
    @required this.inputsClasses,
    @required this.fragments,
  });

  /// The path of data we're currently processing.
  final List<String> path;

  /// The [GraphQLType] we're currently processing.
  final GraphQLType currentType;

  /// If part of an union type, which [GraphQLType] it represents.
  final GraphQLType ofUnion;

  /// A string to replace the current class name.
  final String alias;

  /// The current generated definition classes of this visitor.
  final List<Definition> generatedClasses;

  /// The current generated input classes of this visitor.
  final List<QueryInput> inputsClasses;

  /// The current fragments considered in this visitor.
  final List<FragmentDefinitionNode> fragments;

  /// Returns the full class name with joined path.
  String joinedName([String name]) =>
      '${path.join(r'$')}\$${name ?? alias ?? currentType.name}';

  /// Returns a copy of this context, on the same path, but with a new type.
  Context nextTypeWithSamePath({
    @required GraphQLType nextType,
    GraphQLType ofUnion,
    String alias,
    List<Definition> generatedClasses,
    List<QueryInput> inputsClasses,
    List<FragmentDefinitionNode> fragments,
  }) =>
      Context(
        path: path,
        currentType: nextType,
        ofUnion: ofUnion ?? this.ofUnion,
        alias: alias ?? this.alias,
        generatedClasses: generatedClasses ?? this.generatedClasses,
        inputsClasses: inputsClasses ?? this.inputsClasses,
        fragments: fragments ?? this.fragments,
      );

  /// Returns a copy of this context, with a new type on a new path.
  Context next({
    @required GraphQLType nextType,
    GraphQLType ofUnion,
    String alias,
    List<Definition> generatedClasses,
    List<QueryInput> inputsClasses,
    List<FragmentDefinitionNode> fragments,
  }) =>
      Context(
        path: path.followedBy([alias ?? currentType.name]).toList(),
        currentType: nextType,
        ofUnion: ofUnion ?? this.ofUnion,
        alias: alias ?? this.alias,
        generatedClasses: generatedClasses ?? this.generatedClasses,
        inputsClasses: inputsClasses ?? this.inputsClasses,
        fragments: fragments ?? this.fragments,
      );

  /// Returns a copy of this context, with the same type, but on a new path.
  Context sameTypeWithNextPath({
    GraphQLType ofUnion,
    String alias,
    List<Definition> generatedClasses,
    List<QueryInput> inputsClasses,
    List<FragmentDefinitionNode> fragments,
  }) =>
      Context(
        path: path.followedBy([alias ?? currentType.name]).toList(),
        currentType: currentType,
        ofUnion: ofUnion ?? this.ofUnion,
        alias: alias ?? this.alias,
        generatedClasses: generatedClasses ?? this.generatedClasses,
        inputsClasses: inputsClasses ?? this.inputsClasses,
        fragments: fragments ?? this.fragments,
      );

  /// Returns a copy of this context, with the same type, but on the first path.
  Context sameTypeWithFirstPath({
    GraphQLType ofUnion,
    List<Definition> generatedClasses,
    List<QueryInput> inputsClasses,
    List<FragmentDefinitionNode> fragments,
  }) =>
      Context(
        path: [path.first],
        currentType: currentType,
        ofUnion: ofUnion ?? this.ofUnion,
        generatedClasses: generatedClasses ?? this.generatedClasses,
        inputsClasses: inputsClasses ?? this.inputsClasses,
        fragments: fragments ?? this.fragments,
      );
}
