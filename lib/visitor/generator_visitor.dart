import 'package:artemis/generator.dart';
import 'package:artemis/generator/data/data.dart';
import 'package:meta/meta.dart';
import 'package:gql/ast.dart';

import 'package:artemis/generator/ephemeral_data.dart';
import 'package:artemis/generator/graphql_helpers.dart' as gql;
import 'package:artemis/generator/helpers.dart';

/// Visitor for types generation
class GeneratorVisitor extends RecursiveVisitor {
  /// Constructor
  GeneratorVisitor({
    @required this.context,
  });

  /// Current context
  final Context context;

  /// Selection nodes
  SelectionSetNode selectionSetNode;

  /// Class properties
  final List<ClassProperty> _classProperties = [];

  /// Mixnis
  final List<FragmentName> _mixins = [];

  @override
  void visitSelectionSetNode(SelectionSetNode node) {
    final nextContext = context.withAlias();

    logFn(context, nextContext.align, '-> Class');
    logFn(context, nextContext.align,
        '┌ ${nextContext.path}[${nextContext.currentType.name.value}][${nextContext.currentClassName} ${nextContext.currentFieldName}] (${nextContext.alias ?? ''})');
    super.visitSelectionSetNode(node);

    final possibleTypes = <String, Name>{};

    if (nextContext.currentType is UnionTypeDefinitionNode ||
        nextContext.currentType is InterfaceTypeDefinitionNode) {
      // Filter by requested types
      final keys = node.selections
          .whereType<InlineFragmentNode>()
          .map((n) => n.typeCondition.on.name.value);

      final values = keys.map((t) => ClassName.fromPath(
          path:
              nextContext.withAlias(alias: ClassName(name: t)).fullPathName()));

      possibleTypes.addAll(Map.fromIterables(keys, values));
    }

    final partOfUnion = nextContext.ofUnion != null;
    if (partOfUnion) {}

    final name = ClassName.fromPath(path: nextContext.fullPathName());
    logFn(context, nextContext.align,
        '└ ${nextContext.path}[${nextContext.currentType.name.value}][${nextContext.currentClassName} ${nextContext.currentFieldName}] (${nextContext.alias ?? ''})');
    logFn(context, nextContext.align,
        '<- Generated class ${name.namePrintable}.');

    nextContext.generatedClasses.add(ClassDefinition(
      name: name,
      properties: _classProperties,
      mixins: _mixins,
      extension: partOfUnion
          ? ClassName.fromPath(path: nextContext.rollbackPath().fullPathName())
          : null,
      factoryPossibilities: possibleTypes,
    ));
  }

  @override
  void visitFieldNode(FieldNode node) {
    final fieldName = node.name.value;

    final property = createClassProperty(
      fieldName: ClassPropertyName(name: fieldName),
      fieldAlias: node.alias?.value != null
          ? ClassPropertyName(name: node.alias?.value)
          : null,
      context: context,
      onNewClassFound: (nextContext) {
        node.visitChildren(GeneratorVisitor(
          context: nextContext,
        ));
      },
    );
    _classProperties.add(property);
  }

  @override
  void visitInlineFragmentNode(InlineFragmentNode node) {
    logFn(context, context.align + 1,
        '${context.path}: ... on ${node.typeCondition.on.name.value}');
    final nextType = gql.getTypeByName(context.schema, node.typeCondition.on,
        context: 'inline fragment');

    if (nextType.name.value == context.currentType.name.value) {
      final visitor = GeneratorVisitor(
        context: context.nextTypeWithSamePath(
          nextType: nextType,
          nextClassName: null,
          nextFieldName: null,
          ofUnion: context.currentType,
          inputsClasses: [],
          fragments: [],
        ),
      );
      node.selectionSet.visitChildren(visitor);
    } else {
      final visitor = GeneratorVisitor(
        context: context.next(
          nextType: nextType,
          nextClassName: ClassName(name: nextType.name.value),
          nextFieldName: ClassPropertyName(name: nextType.name.value),
          ofUnion: context.currentType,
          inputsClasses: [],
          fragments: [],
        ),
      );
      node.visitChildren(visitor);
    }
  }

  ///
  void addUsedInputObjectsAndEnums(InputObjectTypeDefinitionNode node) {
    if (context.usedInputObjects.contains(ClassName(name: node.name.value))) {
      return;
    }
    context.usedInputObjects.add(ClassName(name: node.name.value));

    for (final field in node.fields) {
      final type = gql.getTypeByName(context.schema, field.type);
      if (type is InputObjectTypeDefinitionNode) {
        addUsedInputObjectsAndEnums(type);
      } else if (type is EnumTypeDefinitionNode) {
        context.usedEnums.add(EnumName(name: type.name.value));
      }
    }
  }

  @override
  void visitVariableDefinitionNode(VariableDefinitionNode node) {
    final leafType = gql.getTypeByName(context.schema, node.type,
        context: 'variable definition');

    final nextClassName = context
        .nextTypeWithNoPath(
          nextType: leafType,
          nextClassName: ClassName(name: leafType.name.value),
          nextFieldName: ClassName(name: node.variable.name.value),
        )
        .fullPathName();

    final dartTypeName = gql.buildTypeName(node.type, context.options,
        dartType: true,
        replaceLeafWith: ClassName.fromPath(path: nextClassName),
        schema: context.schema);

    final jsonKeyAnnotation = <String, String>{};

    if (leafType is EnumTypeDefinitionNode) {
      context.usedEnums.add(EnumName(name: leafType.name.value));
      final variableNodeType = node.type;
      if (variableNodeType is ListTypeNode) {
        final innerDartTypeName = gql.buildTypeName(variableNodeType.type, context.options,
            dartType: true,
            replaceLeafWith: ClassName.fromPath(path: nextClassName),
            schema: context.schema);
        jsonKeyAnnotation['unknownEnumValue'] =
            '${EnumName(name: innerDartTypeName.name).namePrintable}.${ARTEMIS_UNKNOWN.name.namePrintable}';
      } else {
        jsonKeyAnnotation['unknownEnumValue'] =
            '${EnumName(name: dartTypeName.name).namePrintable}.${ARTEMIS_UNKNOWN.name.namePrintable}';
      }
    } else if (leafType is InputObjectTypeDefinitionNode) {
      addUsedInputObjectsAndEnums(leafType);
    } else if (leafType is ScalarTypeDefinitionNode) {
      final scalar =
          gql.getSingleScalarMap(context.options, leafType.name.value);

      if (scalar.customParserImport != null &&
          leafType.name.value == scalar.graphQLType) {
        final graphqlTypeSafeStr = TypeName(
            name: gql
                .buildTypeName(node.type, context.options,
                    dartType: false, schema: context.schema)
                .dartTypeSafe);
        final dartTypeSafeStr = TypeName(name: dartTypeName.dartTypeSafe);
        jsonKeyAnnotation['fromJson'] =
            'fromGraphQL${graphqlTypeSafeStr.namePrintable}ToDart${dartTypeSafeStr.namePrintable}';
        jsonKeyAnnotation['toJson'] =
            'fromDart${dartTypeSafeStr.namePrintable}ToGraphQL${graphqlTypeSafeStr.namePrintable}';
      }
    }

    final inputName = QueryInputName(name: node.variable.name.value);

    if (inputName.namePrintable != inputName.name) {
      jsonKeyAnnotation['name'] = '\'${inputName.name}\'';
    }

    var annotations = <String>[];

    if (jsonKeyAnnotation.isNotEmpty) {
      final jsonKey = jsonKeyAnnotation.entries
          .map<String>((e) => '${e.key}: ${e.value}')
          .join(', ');
      annotations.add('JsonKey(${jsonKey})');
    }

    context.inputsClasses.add(QueryInput(
      type: dartTypeName,
      name: inputName,
      isNonNull: node.type.isNonNull,
      annotations: annotations,
    ));
  }

  @override
  void visitFragmentSpreadNode(FragmentSpreadNode node) {
    logFn(context, context.align + 1,
        '${context.path}: ... expanding ${node.name.value}');
    final fragmentName = FragmentName.fromPath(
        path: context
            .sameTypeWithNoPath(alias: FragmentName(name: node.name.value))
            .fullPathName());

    final visitor = GeneratorVisitor(
      context: context.sameTypeWithNextPath(
        alias: fragmentName,
        generatedClasses: [],
        log: false,
      ),
    );
    final fragmentDef = context.fragments.firstWhere(
        (fragment) => fragment.name.value == node.name.value,
        orElse: () => null);
    fragmentDef?.visitChildren(visitor);

    _mixins
      ..add(fragmentName)
      ..addAll(visitor._mixins);
  }

  @override
  void visitFragmentDefinitionNode(FragmentDefinitionNode node) {
    final partName = FragmentName(name: node.name.value);
    final nextContext = context.sameTypeWithNoPath(alias: partName);

    logFn(context, nextContext.align, '-> Fragment');
    logFn(context, nextContext.align,
        '┌ ${nextContext.path}[${node.name.value}]');
    nextContext.fragments.add(node);

    final nextType = gql.getTypeByName(
        nextContext.schema, node.typeCondition.on,
        context: 'fragment definition');

    final visitorContext = Context(
      schema: context.schema,
      options: context.options,
      schemaMap: context.schemaMap,
      path: [nextContext.alias],
      currentType: nextType,
      currentFieldName: null,
      currentClassName: null,
      alias: nextContext.alias,
      generatedClasses: nextContext.generatedClasses,
      inputsClasses: [],
      fragments: [],
      usedEnums: nextContext.usedEnums,
      usedInputObjects: nextContext.usedInputObjects,
    );

    final visitor = GeneratorVisitor(
      context: visitorContext,
    );

    node.selectionSet.visitChildren(visitor);

    final otherMixinsProps = nextContext.generatedClasses
        .whereType<FragmentClassDefinition>()
        .where((def) => visitor._mixins.contains(def.name))
        .map((def) => def.properties)
        .expand((a) => a)
        .mergeDuplicatesBy((a) => a.name, (a, b) => a);

    final fragmentName =
        FragmentName.fromPath(path: nextContext.fullPathName());
    logFn(context, nextContext.align,
        '└ ${nextContext.path}[${node.name.value}]');
    logFn(context, nextContext.align,
        '<- Generated fragment ${fragmentName.namePrintable}.');

    nextContext.generatedClasses.add(
      FragmentClassDefinition(
        name: fragmentName,
        properties:
            visitor._classProperties.followedBy(otherMixinsProps).toList(),
      ),
    );
  }
}
