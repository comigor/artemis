import 'package:artemis/generator/data/data.dart';
import 'package:meta/meta.dart';
import 'package:gql/ast.dart';
import 'package:recase/recase.dart';

import '../schema/options.dart';
import 'helpers.dart';

/// Returns the full class name with joined path.
String createJoinedName(List<String> path, NamingScheme namingScheme,
    [String currentClassName, String currentFieldName, String alias]) {
  final fieldName = alias ?? currentFieldName;
  final className = alias ?? currentClassName;

  List<String> fullPath;

  switch (namingScheme) {
    case NamingScheme.simple:
      fullPath = [className ?? path.last];
      break;
    case NamingScheme.pathedWithFields:
      fullPath = [...path, if (fieldName != null) fieldName];
      break;
    case NamingScheme.pathedWithTypes:
    default:
      fullPath = [...path, if (className != null) className];
      break;
  }

  // normalize before re-case cause it removes starting underscore
  return fullPath.map((e) => ReCase(normalizeName(e)).pascalCase).join(r'$');
}

/// Returns the full class name with joined path.
List<String> createPathName(List<String> path, NamingScheme namingScheme,
    [String currentClassName, String currentFieldName, String alias]) {
  final fieldName = alias ?? currentFieldName;
  final className = alias ?? currentClassName;

  List<String> fullPath;

  switch (namingScheme) {
    case NamingScheme.simple:
      fullPath = [className ?? path.last];
      break;
    case NamingScheme.pathedWithFields:
      fullPath = [...path, if (fieldName != null) fieldName];
      break;
    case NamingScheme.pathedWithTypes:
    default:
      fullPath = [...path, if (className != null) className];
      break;
  }

  return fullPath;
}

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
    @required this.currentClassName,
    this.alias,
    this.ofUnion,
    @required this.generatedClasses,
    @required this.inputsClasses,
    @required this.fragments,
    this.usedEnums = const {},
    this.usedInputObjects = const {},
    this.align = 0,
    this.log = true,
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

  /// The name of the class we're currently processing.
  final String currentClassName;

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

  /// The indentation used to debugging purposes.
  final int align;

  /// If debug log should be printed.
  final bool log;

  /// A list of used enums (to filtered on generation).
  final Set<EnumName> usedEnums;

  /// A list of used input objects (to filtered on generation).
  final Set<ClassName> usedInputObjects;

  String _stringForNaming(String withFieldNames, String withClassNames) =>
      schemaMap.namingScheme == NamingScheme.pathedWithFields
          ? withFieldNames
          : withClassNames;

  /// Returns the full class name with joined path.
  String joinedName() => createJoinedName(
      path, schemaMap.namingScheme, currentClassName, currentFieldName, alias);

  ///
  List<String> fullPathName() => createPathName(
      path, schemaMap.namingScheme, currentClassName, currentFieldName, alias);

  /// Returns a copy of this context, on the same path, but with a new type.
  Context nextTypeWithSamePath({
    @required TypeDefinitionNode nextType,
    @required String nextFieldName,
    @required String nextClassName,
    TypeDefinitionNode ofUnion,
    String alias,
    List<Definition> generatedClasses,
    List<QueryInput> inputsClasses,
    List<FragmentDefinitionNode> fragments,
  }) =>
      Context(
        schema: schema,
        options: options,
        schemaMap: schemaMap,
        path: path,
        currentType: nextType,
        currentFieldName: nextFieldName,
        currentClassName: nextClassName,
        ofUnion: ofUnion ?? this.ofUnion,
        generatedClasses: generatedClasses ?? this.generatedClasses,
        inputsClasses: inputsClasses ?? this.inputsClasses,
        fragments: fragments ?? this.fragments,
        align: align,
        usedEnums: usedEnums,
        usedInputObjects: usedInputObjects,
      );

  /// Returns a copy of this context, with a new type on a new path.
  Context next({
    @required TypeDefinitionNode nextType,
    String nextFieldName,
    String nextClassName,
    String alias,
    TypeDefinitionNode ofUnion,
    List<Definition> generatedClasses,
    List<QueryInput> inputsClasses,
    List<FragmentDefinitionNode> fragments,
  }) {
    assert(alias != null || (nextFieldName != null && nextClassName != null));
    return Context(
      schema: schema,
      options: options,
      schemaMap: schemaMap,
      path: path.followedBy([
        _stringForNaming(
          alias ?? nextFieldName,
          alias ?? nextClassName,
        )
      ]).toList(),
      currentType: nextType,
      currentFieldName: nextFieldName,
      currentClassName: nextClassName,
      ofUnion: ofUnion ?? this.ofUnion,
      generatedClasses: generatedClasses ?? this.generatedClasses,
      inputsClasses: inputsClasses ?? this.inputsClasses,
      fragments: fragments ?? this.fragments,
      align: align + 1,
      usedEnums: usedEnums,
      usedInputObjects: usedInputObjects,
    );
  }

  /// Returns a copy of this context, with the same type and path.
  Context withAlias({
    String nextFieldName,
    String nextClassName,
    String alias,
  }) =>
      Context(
        schema: schema,
        options: options,
        schemaMap: schemaMap,
        path: path,
        currentType: currentType,
        currentFieldName: nextFieldName,
        currentClassName: nextClassName,
        ofUnion: ofUnion,
        alias: alias,
        generatedClasses: generatedClasses,
        inputsClasses: inputsClasses,
        fragments: fragments,
        align: align,
        usedEnums: usedEnums,
        usedInputObjects: usedInputObjects,
      );

  /// Returns a copy of this context, with the same type, but on a new path.
  Context sameTypeWithNextPath({
    String nextFieldName,
    String nextClassName,
    String alias,
    TypeDefinitionNode ofUnion,
    List<Definition> generatedClasses,
    List<QueryInput> inputsClasses,
    List<FragmentDefinitionNode> fragments,
    bool log,
  }) {
    assert(alias != null || (nextFieldName != null && nextClassName != null));
    return Context(
      schema: schema,
      options: options,
      schemaMap: schemaMap,
      path: path.followedBy([
        _stringForNaming(
          alias ?? nextFieldName,
          alias ?? nextClassName,
        ),
      ]).toList(),
      currentType: currentType,
      currentFieldName: nextFieldName ?? currentFieldName,
      currentClassName: nextClassName ?? currentClassName,
      ofUnion: ofUnion ?? this.ofUnion,
      alias: alias ?? this.alias,
      generatedClasses: generatedClasses ?? this.generatedClasses,
      inputsClasses: inputsClasses ?? this.inputsClasses,
      fragments: fragments ?? this.fragments,
      align: align + 1,
      usedEnums: usedEnums,
      usedInputObjects: usedInputObjects,
      log: log ?? this.log,
    );
  }

  /// Returns a copy of this context, rolling back a item on path.
  Context rollbackPath() {
    return Context(
      schema: schema,
      options: options,
      schemaMap: schemaMap,
      path: [...path]..removeLast(),
      currentType: currentType,
      currentFieldName: currentFieldName,
      currentClassName: currentClassName,
      ofUnion: ofUnion,
      alias: alias,
      generatedClasses: generatedClasses,
      inputsClasses: inputsClasses,
      fragments: fragments,
      align: align - 1,
      usedEnums: usedEnums,
      usedInputObjects: usedInputObjects,
    );
  }

  /// Returns a copy of this context, with the same type, but on the first path.
  Context sameTypeWithNoPath({
    String alias,
    TypeDefinitionNode ofUnion,
    List<Definition> generatedClasses,
    List<QueryInput> inputsClasses,
    List<FragmentDefinitionNode> fragments,
  }) =>
      Context(
        schema: schema,
        options: options,
        schemaMap: schemaMap,
        path: [],
        currentType: currentType,
        currentFieldName: currentFieldName,
        currentClassName: currentClassName,
        ofUnion: ofUnion ?? this.ofUnion,
        alias: alias ?? this.alias,
        generatedClasses: generatedClasses ?? this.generatedClasses,
        inputsClasses: inputsClasses ?? this.inputsClasses,
        fragments: fragments ?? this.fragments,
        align: align,
        usedEnums: usedEnums,
        usedInputObjects: usedInputObjects,
      );

  /// Returns a copy of this context, with next type, but on the first path.
  Context nextTypeWithNoPath({
    @required TypeDefinitionNode nextType,
    @required String nextFieldName,
    @required String nextClassName,
    TypeDefinitionNode ofUnion,
    String alias,
    List<Definition> generatedClasses,
    List<QueryInput> inputsClasses,
    List<FragmentDefinitionNode> fragments,
  }) =>
      Context(
        schema: schema,
        options: options,
        schemaMap: schemaMap,
        path: [],
        currentType: nextType,
        currentFieldName: nextFieldName,
        currentClassName: nextClassName,
        ofUnion: ofUnion ?? this.ofUnion,
        alias: alias ?? this.alias,
        generatedClasses: generatedClasses ?? this.generatedClasses,
        inputsClasses: inputsClasses ?? this.inputsClasses,
        fragments: fragments ?? this.fragments,
        align: 0,
        usedEnums: usedEnums,
        usedInputObjects: usedInputObjects,
      );
}
