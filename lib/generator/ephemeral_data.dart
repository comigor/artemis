import 'package:artemis/generator/data/data.dart';
import 'package:artemis/generator/data/nullable.dart';
import 'package:gql/ast.dart';
import '../schema/options.dart';

/// Returns the full class name with joined path.
List<Name> createPathName(List<Name> path, NamingScheme? namingScheme,
    [Name? currentClassName, Name? currentFieldName, Name? alias]) {
  final fieldName = alias ?? currentFieldName;
  final className = alias ?? currentClassName;

  List<Name?> fullPath;

  switch (namingScheme) {
    case NamingScheme.simple:
      fullPath = className == null
          // fix for https://github.com/comigor/artemis/issues/226
          ? (path.length == 2 ? path : [path.last])
          : [className];
      break;
    case NamingScheme.pathedWithFields:
      fullPath = [...path, fieldName];
      break;
    case NamingScheme.pathedWithTypes:
    default:
      fullPath = [...path, className];
      break;
  }

  return fullPath.whereType<Name>().toList();
}

/// Holds context between [_GeneratorVisitor] iterations.
class Context {
  /// Instantiates context for [_GeneratorVisitor] iterations.
  Context({
    required this.schema,
    required this.options,
    required this.schemaMap,
    required this.path,
    required this.currentType,
    required this.currentFieldName,
    required this.currentClassName,
    this.alias,
    this.ofUnion,
    required this.generatedClasses,
    required this.inputsClasses,
    required this.fragments,
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
  final List<Name> path;

  /// The [TypeDefinitionNode] we're currently processing.
  final TypeDefinitionNode? currentType;

  /// The name of the class we're currently processing.
  final Name? currentClassName;

  /// The name of the field we're currently processing.
  final Name? currentFieldName;

  /// If part of an union type, which [TypeDefinitionNode] it represents.
  final TypeDefinitionNode? ofUnion;

  /// A string to replace the current class name.
  final Name? alias;

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

  Name? _stringForNaming(Name? withFieldNames, Name? withClassNames) =>
      schemaMap.namingScheme == NamingScheme.pathedWithFields
          ? withFieldNames
          : withClassNames;

  /// Returns the full class name
  List<Name> fullPathName() => createPathName(
      path, schemaMap.namingScheme, currentClassName, currentFieldName, alias);

  /// Returns a copy of this context, on the same path, but with a new type.
  Context nextTypeWithSamePath({
    required TypeDefinitionNode nextType,
    required Name? nextFieldName,
    required Name? nextClassName,
    Nullable<TypeDefinitionNode?>? ofUnion,
    Name? alias,
    List<Definition>? generatedClasses,
    List<QueryInput>? inputsClasses,
    List<FragmentDefinitionNode>? fragments,
  }) =>
      Context(
        schema: schema,
        options: options,
        schemaMap: schemaMap,
        path: path,
        currentType: nextType,
        currentFieldName: nextFieldName,
        currentClassName: nextClassName,
        ofUnion: ofUnion == null ? this.ofUnion : ofUnion.value,
        generatedClasses: generatedClasses ?? this.generatedClasses,
        inputsClasses: inputsClasses ?? this.inputsClasses,
        fragments: fragments ?? this.fragments,
        align: align,
        usedEnums: usedEnums,
        usedInputObjects: usedInputObjects,
      );

  /// Returns a copy of this context, with a new type on a new path.
  Context next({
    required TypeDefinitionNode nextType,
    Name? nextFieldName,
    Name? nextClassName,
    Name? alias,
    Nullable<TypeDefinitionNode?>? ofUnion,
    List<Definition>? generatedClasses,
    List<QueryInput>? inputsClasses,
    List<FragmentDefinitionNode>? fragments,
  }) {
    assert(alias != null || (nextFieldName != null && nextClassName != null));
    return Context(
      schema: schema,
      options: options,
      schemaMap: schemaMap,
      path: path
          .followedBy([
            _stringForNaming(
              alias ?? nextFieldName,
              alias ?? nextClassName,
            )
          ].whereType<Name>())
          .toList(),
      currentType: nextType,
      currentFieldName: nextFieldName,
      currentClassName: nextClassName,
      ofUnion: ofUnion == null ? this.ofUnion : ofUnion.value,
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
    Name? nextFieldName,
    Name? nextClassName,
    Name? alias,
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
    Name? nextFieldName,
    Name? nextClassName,
    Name? alias,
    Nullable<TypeDefinitionNode?>? ofUnion,
    List<Definition>? generatedClasses,
    List<QueryInput>? inputsClasses,
    List<FragmentDefinitionNode>? fragments,
    bool? log,
  }) {
    assert(alias != null || (nextFieldName != null && nextClassName != null));
    return Context(
      schema: schema,
      options: options,
      schemaMap: schemaMap,
      path: path
          .followedBy([
            _stringForNaming(
              alias ?? nextFieldName,
              alias ?? nextClassName,
            ),
          ].whereType<Name>())
          .toList(),
      currentType: currentType,
      currentFieldName: nextFieldName ?? currentFieldName,
      currentClassName: nextClassName ?? currentClassName,
      ofUnion: ofUnion == null ? this.ofUnion : ofUnion.value,
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
    Name? alias,
    Nullable<TypeDefinitionNode?>? ofUnion,
    List<Definition>? generatedClasses,
    List<QueryInput>? inputsClasses,
    List<FragmentDefinitionNode>? fragments,
  }) =>
      Context(
        schema: schema,
        options: options,
        schemaMap: schemaMap,
        path: [],
        currentType: currentType,
        currentFieldName: currentFieldName,
        currentClassName: currentClassName,
        ofUnion: ofUnion == null ? this.ofUnion : ofUnion.value,
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
    required TypeDefinitionNode nextType,
    required Name nextFieldName,
    required Name nextClassName,
    Nullable<TypeDefinitionNode?>? ofUnion,
    Name? alias,
    List<Definition>? generatedClasses,
    List<QueryInput>? inputsClasses,
    List<FragmentDefinitionNode>? fragments,
  }) =>
      Context(
        schema: schema,
        options: options,
        schemaMap: schemaMap,
        path: [],
        currentType: nextType,
        currentFieldName: nextFieldName,
        currentClassName: nextClassName,
        ofUnion: ofUnion == null ? this.ofUnion : ofUnion.value,
        alias: alias ?? this.alias,
        generatedClasses: generatedClasses ?? this.generatedClasses,
        inputsClasses: inputsClasses ?? this.inputsClasses,
        fragments: fragments ?? this.fragments,
        align: 0,
        usedEnums: usedEnums,
        usedInputObjects: usedInputObjects,
      );
}
