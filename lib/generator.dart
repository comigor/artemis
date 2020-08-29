// @dart = 2.8

import 'package:artemis/generator/data/data.dart';
import 'package:artemis/generator/data/enum_value_definition.dart';
import 'package:artemis/visitor/canonical_visitor.dart';
import 'package:artemis/visitor/generator_visitor.dart';
import 'package:artemis/visitor/object_type_definition_visitor.dart';
import 'package:artemis/visitor/schema_definition_visitor.dart';
import 'package:artemis/visitor/type_definition_node_visitor.dart';
import 'package:meta/meta.dart';
import 'package:gql/ast.dart';
import 'package:path/path.dart' as p;

import './generator/ephemeral_data.dart';
import './generator/errors.dart';
import './generator/graphql_helpers.dart' as gql;
import './generator/helpers.dart';
import './schema/options.dart';

typedef _OnNewClassFoundCallback = void Function(Context context);

/// Enum value for values not mapped in the GraphQL enum
final EnumValueDefinition ARTEMIS_UNKNOWN = EnumValueDefinition(
  name: EnumValueName(name: 'ARTEMIS_UNKNOWN'),
);

/// Generate queries definitions from a GraphQL schema and a list of queries,
/// given Artemis options and schema mappings.
LibraryDefinition generateLibrary(
  String path,
  List<DocumentNode> gqlDocs,
  GeneratorOptions options,
  SchemaMap schemaMap,
  List<FragmentDefinitionNode> fragmentsCommon,
  DocumentNode schema,
) {
  final canonicalVisitor = CanonicalVisitor(
    context: Context(
      schema: schema,
      options: options,
      schemaMap: schemaMap,
      path: [],
      currentType: null,
      currentFieldName: null,
      currentClassName: null,
      generatedClasses: [],
      inputsClasses: [],
      fragments: [],
      usedEnums: {},
      usedInputObjects: {},
    ),
  );

  schema.accept(canonicalVisitor);

  final queryDefinitions = gqlDocs
      .map((doc) => generateDefinitions(
            schema,
            path,
            doc,
            options,
            schemaMap,
            fragmentsCommon,
            canonicalVisitor,
          ))
      .expand((e) => e)
      .toList();

  final allClassesNames = queryDefinitions
      .map((def) => def.classes.map((c) => c))
      .expand((e) => e)
      .toList();

  allClassesNames.mergeDuplicatesBy((a) => a.name, (a, b) {
    if (a.name == b.name && a != b) {
      throw DuplicatedClassesException(a, b);
    }

    return a;
  });

  final basename = p.basenameWithoutExtension(path);

  final customImports = _extractCustomImports(schema, options);
  return LibraryDefinition(
    basename: basename,
    queries: queryDefinitions,
    customImports: customImports,
  );
}

Set<FragmentDefinitionNode> _extractFragments(SelectionSetNode selectionSet,
    List<FragmentDefinitionNode> fragmentsCommon) {
  final result = <FragmentDefinitionNode>{};
  if (selectionSet != null) {
    selectionSet.selections.whereType<FieldNode>().forEach((selection) {
      result.addAll(_extractFragments(selection.selectionSet, fragmentsCommon));
    });

    selectionSet.selections
        .whereType<InlineFragmentNode>()
        .forEach((selection) {
      result.addAll(_extractFragments(selection.selectionSet, fragmentsCommon));
    });

    selectionSet.selections
        .whereType<FragmentSpreadNode>()
        .forEach((selection) {
      final fragmentDefinitions = fragmentsCommon.firstWhere(
          (fragmentDefinition) =>
              fragmentDefinition.name.value == selection.name.value);
      result.add(fragmentDefinitions);
      result.addAll(
          _extractFragments(fragmentDefinitions.selectionSet, fragmentsCommon));
    });
  }
  return result;
}

/// Generate a query definition from a GraphQL schema and a query, given
/// Artemis options and schema mappings.
Iterable<QueryDefinition> generateDefinitions(
  DocumentNode schema,
  String path,
  DocumentNode document,
  GeneratorOptions options,
  SchemaMap schemaMap,
  List<FragmentDefinitionNode> fragmentsCommon,
  CanonicalVisitor canonicalVisitor,
) {
  final fragments = <FragmentDefinitionNode>[];

  final documentFragments =
      document.definitions.whereType<FragmentDefinitionNode>();

  if (documentFragments.isNotEmpty && fragmentsCommon.isNotEmpty) {
    throw FragmentIgnoreException();
  }

  final operations =
      document.definitions.whereType<OperationDefinitionNode>().toList();

  return operations.map((operation) {
    if (fragmentsCommon.isEmpty) {
      fragments.addAll(documentFragments);
    } else {
      final fragmentsOperation =
          _extractFragments(operation.selectionSet, fragmentsCommon);
      document.definitions.addAll(fragmentsOperation);
      fragments.addAll(fragmentsOperation);
    }

    final basename = p.basenameWithoutExtension(path).split('.').first;
    final operationName = operation.name?.value ?? basename;

    final schemaVisitor = SchemaDefinitionVisitor();
    final objectVisitor = ObjectTypeDefinitionVisitor();

    schema.accept(schemaVisitor);
    schema.accept(objectVisitor);

    String suffix;
    switch (operation.type) {
      case OperationType.subscription:
        suffix = 'Subscription';
        break;
      case OperationType.mutation:
        suffix = 'Mutation';
        break;
      case OperationType.query:
      default:
        suffix = 'Query';
        break;
    }

    final rootTypeName =
        (schemaVisitor.schemaDefinitionNode?.operationTypes ?? [])
                .firstWhere((e) => e.operation == operation.type,
                    orElse: () => null)
                ?.type
                ?.name
                ?.value ??
            suffix;

    if (rootTypeName == null) {
      throw Exception(
          '''No root type was found for ${operation.type} $operationName.''');
    }

    final TypeDefinitionNode parentType = objectVisitor.getByName(rootTypeName);

    final name = QueryName.fromPath(
        path: createPathName([
      ClassName(name: operationName),
      ClassName(name: parentType.name.value)
    ], schemaMap.namingScheme));

    final context = Context(
      schema: schema,
      options: options,
      schemaMap: schemaMap,
      path: [
        TypeName(name: operationName),
        TypeName(name: parentType.name.value)
      ],
      currentType: parentType,
      currentFieldName: null,
      currentClassName: null,
      generatedClasses: [],
      inputsClasses: [],
      fragments: fragments,
      usedEnums: {},
      usedInputObjects: {},
    );

    final visitor = GeneratorVisitor(
      context: context,
    );

    DocumentNode(
      definitions: document.definitions
          // filtering unused operations
          .where((e) => e is! OperationDefinitionNode || e == operation)
          .toList(),
    ).accept(visitor);

    return QueryDefinition(
      name: name,
      operationName: operationName,
      document: document,
      classes: [
        ...canonicalVisitor.enums
            .where((e) => context.usedEnums.contains(e.name)),
        ...visitor.context.generatedClasses,
        ...canonicalVisitor.inputObjects
            .where((i) => context.usedInputObjects.contains(i.name)),
      ],
      inputs: visitor.context.inputsClasses,
      generateHelpers: options.generateHelpers,
      suffix: suffix,
    );
  });
}

List<String> _extractCustomImports(
  DocumentNode schema,
  GeneratorOptions options,
) {
  final typeVisitor = TypeDefinitionNodeVisitor();

  schema.accept(typeVisitor);

  return typeVisitor.types
      .whereType<ScalarTypeDefinitionNode>()
      .map((type) => gql.importsOfScalar(options, type.name.value))
      .expand((i) => i)
      .toSet()
      .toList();
}

/// Creates class property object
ClassProperty createClassProperty({
  @required ClassPropertyName fieldName,
  ClassPropertyName fieldAlias,
  @required Context context,
  _OnNewClassFoundCallback onNewClassFound,
  bool markAsUsed = true,
}) {
  if (fieldName.name == context.schemaMap.typeNameField) {
    return ClassProperty(
      type: TypeName(name: 'String'),
      name: fieldName,
      annotations: [
        'override',
        'JsonKey(name: \'${context.schemaMap.typeNameField}\')'
      ],
      isResolveType: true,
    );
  }

  var finalFields = <Node>[];

  if (context.currentType is ObjectTypeDefinitionNode) {
    finalFields = (context.currentType as ObjectTypeDefinitionNode).fields;
  } else if (context.currentType is InterfaceTypeDefinitionNode) {
    finalFields = (context.currentType as InterfaceTypeDefinitionNode).fields;
  } else if (context.currentType is InputObjectTypeDefinitionNode) {
    finalFields = (context.currentType as InputObjectTypeDefinitionNode).fields;
  }

  final regularField = finalFields
      .whereType<FieldDefinitionNode>()
      .firstWhere((f) => f.name.value == fieldName.name, orElse: () => null);
  final regularInputField = finalFields
      .whereType<InputValueDefinitionNode>()
      .firstWhere((f) => f.name.value == fieldName.name, orElse: () => null);

  final fieldType = regularField?.type ?? regularInputField?.type;

  if (fieldType == null) {
    throw Exception(
        '''Field $fieldName was not found in GraphQL type ${context.currentType?.name?.value}.
Make sure your query is correct and your schema is updated.''');
  }

  final nextType =
      gql.getTypeByName(context.schema, fieldType, context: 'field node');

  final aliasedContext = context.withAlias(
    nextFieldName: fieldName,
    nextClassName: ClassName(name: nextType.name.value),
    alias: fieldAlias,
  );

  final nextClassName = aliasedContext.fullPathName();

  final dartTypeName = gql.buildTypeName(fieldType, context.options,
      dartType: true,
      replaceLeafWith: ClassName.fromPath(path: nextClassName),
      schema: context.schema);

  logFn(context, aliasedContext.align + 1,
      '${aliasedContext.path}[${aliasedContext.currentType.name.value}][${aliasedContext.currentClassName} ${aliasedContext.currentFieldName}] ${fieldAlias == null ? '' : '(${fieldAlias}) '}-> ${dartTypeName.namePrintable}');

  if ((nextType is ObjectTypeDefinitionNode ||
          nextType is UnionTypeDefinitionNode ||
          nextType is InterfaceTypeDefinitionNode) &&
      onNewClassFound != null) {
    onNewClassFound(
      aliasedContext.next(
        nextType: nextType,
        nextFieldName: ClassPropertyName(
            name: regularField?.name?.value ?? regularInputField?.name?.value),
        nextClassName: ClassName(name: nextType.name.value),
        alias: fieldAlias,
      ),
    );
  }

  final name = fieldAlias ?? fieldName;

  // On custom scalars
  final jsonKeyAnnotation = <String, String>{};
  if (name.namePrintable != name.name) {
    jsonKeyAnnotation['name'] = '\'${name.name}\'';
  }

  if (nextType is ScalarTypeDefinitionNode) {
    final scalar = gql.getSingleScalarMap(context.options, nextType.name.value);

    if (scalar.customParserImport != null &&
        nextType.name.value == scalar.graphQLType) {
      final graphqlTypeSafeStr = TypeName(
          name: gql
              .buildTypeName(fieldType, context.options,
                  dartType: false, schema: context.schema)
              .dartTypeSafe);
      final dartTypeSafeStr = TypeName(name: dartTypeName.dartTypeSafe);
      jsonKeyAnnotation['fromJson'] =
          'fromGraphQL${graphqlTypeSafeStr.namePrintable}ToDart${dartTypeSafeStr.namePrintable}';
      jsonKeyAnnotation['toJson'] =
          'fromDart${dartTypeSafeStr.namePrintable}ToGraphQL${graphqlTypeSafeStr.namePrintable}';
    }
  } // On enums
  else if (nextType is EnumTypeDefinitionNode) {
    if (markAsUsed) {
      context.usedEnums.add(EnumName(name: nextType.name.value));
    }

    if (fieldType is! ListTypeNode) {
      jsonKeyAnnotation['unknownEnumValue'] =
          '${dartTypeName.namePrintable}.${ARTEMIS_UNKNOWN.name.namePrintable}';
    }
  }

  final fieldDirectives =
      regularField?.directives ?? regularInputField?.directives;

  var annotations = <String>[];

  if (jsonKeyAnnotation.isNotEmpty) {
    final jsonKey = jsonKeyAnnotation.entries
        .map<String>((e) => '${e.key}: ${e.value}')
        .join(', ');
    annotations.add('JsonKey(${jsonKey})');
  }
  annotations.addAll(proceedDeprecated(fieldDirectives));

  return ClassProperty(
    type: dartTypeName,
    name: name,
    annotations: annotations,
    isNonNull: fieldType.isNonNull,
  );
}
