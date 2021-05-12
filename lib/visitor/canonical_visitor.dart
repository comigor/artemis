import 'package:artemis/generator.dart';
import 'package:artemis/generator/data/data.dart';
import 'package:artemis/generator/data/enum_value_definition.dart';
import 'package:artemis/generator/data/nullable.dart';
import 'package:artemis/generator/ephemeral_data.dart';
import 'package:artemis/generator/helpers.dart';
import 'package:artemis/generator/graphql_helpers.dart' as gql;
import 'package:gql/ast.dart';

/// Visits canonical types Enums and InputObjects
class CanonicalVisitor extends RecursiveVisitor {
  /// Constructor
  CanonicalVisitor({
    required this.context,
  });

  /// Current context
  final Context context;

  /// List of visited input objects
  final List<ClassDefinition> inputObjects = [];

  /// List of visited enums
  final List<EnumDefinition> enums = [];

  @override
  void visitEnumTypeDefinitionNode(EnumTypeDefinitionNode node) {
    final enumName = EnumName(name: node.name.value);

    final nextContext = context.sameTypeWithNoPath(
      alias: enumName,
      ofUnion: Nullable<Name?>(null),
    );

    logFn(context, nextContext.align, '-> Enum');
    logFn(context, nextContext.align,
        '<- Generated enum ${enumName.namePrintable}.');

    enums.add(EnumDefinition(
      name: enumName,
      values: node.values
          .map((ev) => EnumValueDefinition(
                name: EnumValueName(name: ev.name.value),
                annotations: proceedDeprecated(ev.directives),
              ))
          .toList()
            ..add(ARTEMIS_UNKNOWN),
    ));
  }

  @override
  void visitInputObjectTypeDefinitionNode(InputObjectTypeDefinitionNode node) {
    final name = ClassName(name: node.name.value);
    final nextContext = context.sameTypeWithNoPath(
      alias: name,
      ofUnion: Nullable<Name?>(null),
    );

    logFn(context, nextContext.align, '-> Input class');
    logFn(context, nextContext.align,
        '┌ ${nextContext.path}[${node.name.value}]');
    final properties = <ClassProperty>[];

    properties.addAll(node.fields.map((i) {
      final nextType = gql.getTypeByName(nextContext.schema, i.type);
      return createClassProperty(
        fieldName: ClassPropertyName(name: i.name.value),
        context: nextContext.nextTypeWithNoPath(
          nextType: node,
          nextClassName: ClassName(name: nextType.name.value),
          nextFieldName: ClassName(name: i.name.value),
          ofUnion: Nullable<Name?>(null),
        ),
        markAsUsed: false,
      );
    }));

    logFn(context, nextContext.align,
        '└ ${nextContext.path}[${node.name.value}]');
    logFn(context, nextContext.align,
        '<- Generated input class ${name.namePrintable}.');

    inputObjects.add(ClassDefinition(
      isInput: true,
      name: name,
      properties: properties,
    ));
  }
}
