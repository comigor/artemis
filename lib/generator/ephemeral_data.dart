import 'package:meta/meta.dart';
import 'package:gql/ast.dart';
import 'package:recase/recase.dart';

import './data.dart';
import '../schema/options.dart';

/// Holds context between [_GeneratorVisitor] iterations.
class Context {
  /// Instantiates context for [_GeneratorVisitor] iterations.
  Context({
    @required this.schema,
    @required this.options,
    @required this.schemaMap,
    @required this.path,
    @required this.currentType,
    @required this.currentFieldName,
    this.alias,
    this.ofUnion,
    @required this.generatedClasses,
    @required this.inputsClasses,
    @required this.fragments,
  });

  /// The [DocumentNode] parsed from `build.yaml` configuration.
  final DocumentNode schema;

  /// Other options parsed from `build.yaml` configuration.
  final GeneratorOptions options;

  /// The [SchemaMap] being used on this iteration.
  final SchemaMap schemaMap;

  /// The path of data we're currently processing.
  final List<String> path;

  /// The [TypeDefinitionNode] we're currently processing.
  final TypeDefinitionNode currentType;

  /// The name of the field we're currently processing.
  final String currentFieldName;

  /// If part of an union type, which [TypeDefinitionNode] it represents.
  final TypeDefinitionNode ofUnion;

  /// A string to replace the current class name.
  final String alias;

  /// The current generated definition classes of this visitor.
  final List<Definition> generatedClasses;

  /// The current generated input classes of this visitor.
  final List<QueryInput> inputsClasses;

  /// The current fragments considered in this visitor.
  final List<FragmentDefinitionNode> fragments;

  String _stringForNaming(String withFieldNames, String withClassNames) =>
      schemaMap.namingScheme == NamingScheme.pathedWithFieldNames
          ? withFieldNames
          : withClassNames;

  /// Returns the full class name with joined path.
  String joinedName() {
    final className = ReCase(alias ?? currentType.name.value).pascalCase;
    final fieldName = ReCase(alias ?? currentFieldName ?? className).pascalCase;

    switch (schemaMap.namingScheme) {
      case NamingScheme.simple:
        return className;
      case NamingScheme.pathedWithFieldNames:
        return '${path.map((e) => ReCase(e).pascalCase).join(r'$')}\$$fieldName';
      case NamingScheme.pathedWithClassNames:
      default:
        return '${path.map((e) => ReCase(e).pascalCase).join(r'$')}\$$className';
    }
  }

  /// Returns a copy of this context, on the same path, but with a new type.
  Context nextTypeWithSamePath({
    @required TypeDefinitionNode nextType,
    @required String nextFieldName,
    TypeDefinitionNode ofUnion,
    String alias,
    List<Definition> generatedClasses,
    List<QueryInput> inputsClasses,
    List<FragmentDefinitionNode> fragments,
  }) =>
      Context(
        schema: this.schema,
        options: this.options,
        schemaMap: this.schemaMap,
        path: path,
        currentType: nextType,
        currentFieldName: nextFieldName,
        ofUnion: ofUnion ?? this.ofUnion,
        generatedClasses: generatedClasses ?? this.generatedClasses,
        inputsClasses: inputsClasses ?? this.inputsClasses,
        fragments: fragments ?? this.fragments,
      );

  /// Returns a copy of this context, with a new type on a new path.
  Context next({
    @required TypeDefinitionNode nextType,
    @required String nextFieldName,
    TypeDefinitionNode ofUnion,
    String alias,
    List<Definition> generatedClasses,
    List<QueryInput> inputsClasses,
    List<FragmentDefinitionNode> fragments,
  }) =>
      Context(
        schema: this.schema,
        options: this.options,
        schemaMap: this.schemaMap,
        path: path.followedBy([
          _stringForNaming(
            alias ?? nextFieldName,
            alias ?? currentType.name.value,
          )
        ]).toList(),
        currentType: nextType,
        currentFieldName: nextFieldName,
        ofUnion: ofUnion ?? this.ofUnion,
        generatedClasses: generatedClasses ?? this.generatedClasses,
        inputsClasses: inputsClasses ?? this.inputsClasses,
        fragments: fragments ?? this.fragments,
      );

  /// Returns a copy of this context, with the same type, but on a new path.
  Context sameTypeWithNextPath({
    String nextFieldName,
    TypeDefinitionNode ofUnion,
    String alias,
    List<Definition> generatedClasses,
    List<QueryInput> inputsClasses,
    List<FragmentDefinitionNode> fragments,
  }) =>
      Context(
        schema: this.schema,
        options: this.options,
        schemaMap: this.schemaMap,
        path: path.followedBy([
          _stringForNaming(
            alias ?? currentFieldName,
            alias ?? currentType.name.value,
          ),
        ]).toList(),
        currentType: currentType,
        currentFieldName: nextFieldName ?? this.currentFieldName,
        ofUnion: ofUnion ?? this.ofUnion,
        alias: alias ?? this.alias,
        generatedClasses: generatedClasses ?? this.generatedClasses,
        inputsClasses: inputsClasses ?? this.inputsClasses,
        fragments: fragments ?? this.fragments,
      );

  /// Returns a copy of this context, with the same type, but on the first path.
  Context sameTypeWithFirstPath({
    String nextFieldName,
    TypeDefinitionNode ofUnion,
    String alias,
    List<Definition> generatedClasses,
    List<QueryInput> inputsClasses,
    List<FragmentDefinitionNode> fragments,
  }) =>
      Context(
        schema: this.schema,
        options: this.options,
        schemaMap: this.schemaMap,
        path: [path.first],
        currentType: currentType,
        currentFieldName: nextFieldName,
        ofUnion: ofUnion ?? this.ofUnion,
        alias: alias ?? this.alias,
        generatedClasses: generatedClasses ?? this.generatedClasses,
        inputsClasses: inputsClasses ?? this.inputsClasses,
        fragments: fragments ?? this.fragments,
      );
}
