import 'package:artemis/generator/data/data.dart';
import 'package:artemis/generator/data/enum_value_definition.dart';
import 'package:artemis/generator/errors.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:dart_style/dart_style.dart';
// ignore: implementation_imports
import 'package:gql_code_builder/src/ast.dart' as dart;
import 'package:recase/recase.dart';

import '../generator/helpers.dart';

/// Generates a [Spec] of a single enum definition.
Spec enumDefinitionToSpec(EnumDefinition definition) =>
    CodeExpression(Code('''enum ${definition.name.namePrintable} {
  ${definition.values.removeDuplicatedBy((i) => i).map(_enumValueToSpec).join()}
}'''));

String _enumValueToSpec(EnumValueDefinition value) {
  final annotations = value.annotations
      .map((annotation) => '@$annotation')
      .followedBy(['@JsonValue(\'${value.name.name}\')']).join(' ');

  return '$annotations${value.name.namePrintable}, ';
}

String _fromJsonBody(ClassDefinition definition) {
  final buffer = StringBuffer();
  buffer.writeln(
      '''switch (json['${definition.typeNameField.name}'].toString()) {''');

  for (final p in definition.factoryPossibilities.entries) {
    buffer.writeln('''      case r'${p.key}':
        return ${p.value.namePrintable}.fromJson(json);''');
  }

  buffer.writeln('''      default:
    }
    return _\$${definition.name.namePrintable}FromJson(json);''');
  return buffer.toString();
}

String _toJsonBody(ClassDefinition definition) {
  final buffer = StringBuffer();
  final typeName = definition.typeNameField.namePrintable;
  buffer.writeln('''switch ($typeName) {''');

  for (final p in definition.factoryPossibilities.entries) {
    buffer.writeln('''      case r'${p.key}':
        return (this as ${p.value.namePrintable}).toJson();''');
  }

  buffer.writeln('''      default:
    }
    return _\$${definition.name.namePrintable}ToJson(this);''');
  return buffer.toString();
}

Method _propsMethod(Iterable<String> body) {
  return Method((m) => m
    ..type = MethodType.getter
    ..returns = refer('List<Object?>')
    ..annotations.add(CodeExpression(Code('override')))
    ..name = 'props'
    ..lambda = true
    ..body =
        Code('[${body.mergeDuplicatesBy((i) => i, (a, b) => a).join(', ')}]'));
}

/// Generates a [Spec] of a single class definition.
Spec classDefinitionToSpec(
    ClassDefinition definition,
    Iterable<FragmentClassDefinition> fragments,
    Iterable<ClassDefinition> classes) {
  final fromJson = definition.factoryPossibilities.isNotEmpty
      ? Constructor(
          (b) => b
            ..factory = true
            ..name = 'fromJson'
            ..requiredParameters.add(Parameter(
              (p) => p
                ..type = refer('Map<String, dynamic>')
                ..name = 'json',
            ))
            ..body = Code(_fromJsonBody(definition)),
        )
      : Constructor(
          (b) => b
            ..factory = true
            ..name = 'fromJson'
            ..lambda = true
            ..requiredParameters.add(Parameter(
              (p) => p
                ..type = refer('Map<String, dynamic>')
                ..name = 'json',
            ))
            ..body = Code('_\$${definition.name.namePrintable}FromJson(json)'),
        );

  final toJson = definition.factoryPossibilities.isNotEmpty
      ? Method(
          (m) => m
            ..name = 'toJson'
            ..annotations.add(CodeExpression(Code('override')))
            ..returns = refer('Map<String, dynamic>')
            ..body = Code(_toJsonBody(definition)),
        )
      : Method(
          (m) => m
            ..name = 'toJson'
            ..lambda = true
            ..annotations.add(CodeExpression(Code('override')))
            ..returns = refer('Map<String, dynamic>')
            ..body = Code('_\$${definition.name.namePrintable}ToJson(this)'),
        );

  final props = definition.mixins
      .map((i) {
        return fragments
            .firstWhere((f) {
              return f.name == i;
            }, orElse: () {
              throw MissingFragmentException(
                  i.namePrintable, definition.name.namePrintable);
            })
            .properties
            .map((p) => p.name.namePrintable);
      })
      .expand((i) => i)
      .followedBy(definition.properties.map((p) => p.name.namePrintable));

  final extendedClass =
      classes.firstWhereOrNull((e) => e.name == definition.extension);

  return Class(
    (b) => b
      ..annotations
          .add(CodeExpression(Code('JsonSerializable(explicitToJson: true)')))
      ..name = definition.name.namePrintable
      ..mixins.add(refer('EquatableMixin'))
      ..mixins.addAll(definition.mixins.map((i) => refer(i.namePrintable)))
      ..methods.add(_propsMethod(props))
      ..extend = definition.extension != null
          ? refer(definition.extension!.namePrintable)
          : refer('JsonSerializable')
      ..implements.addAll(definition.implementations.map((i) => refer(i)))
      ..constructors.add(Constructor((b) {
        if (definition.isInput) {
          b.optionalParameters.addAll(definition.properties
              .where(
                  (property) => !property.isOverride && !property.isResolveType)
              .map(
                (property) => Parameter(
                  (p) {
                    p
                      ..name = property.name.namePrintable
                      ..named = true
                      ..toThis = true
                      ..required = property.type.isNonNull;
                  },
                ),
              ));
        }
      }))
      ..constructors.add(fromJson)
      ..methods.add(toJson)
      ..fields.addAll(definition.properties.map((p) {
        if (extendedClass != null &&
            extendedClass.properties.any((e) => e == p)) {
          // if class has the same prop as in extension
          p.annotations.add('override');
        }

        final field = Field((f) {
          f
            ..name = p.name.namePrintable
            // TODO: remove this workaround when code_builder includes late field modifier:
            // https://github.com/dart-lang/code_builder/pull/310
            ..type = refer(
                '${p.type.isNonNull ? 'late ' : ''} ${p.type.namePrintable}')
            ..annotations.addAll(
              p.annotations.map((e) => CodeExpression(Code(e))),
            );

          if (p.type.isNonNull) {
            // TODO: apply this fix when code_builder includes late field modifier:
            // https://github.com/dart-lang/code_builder/pull/310
            // f.modifier = FieldModifier.late$;
          }
        });
        return field;
      })),
  );
}

/// Generates a [Spec] of a single fragment class definition.
Spec fragmentClassDefinitionToSpec(FragmentClassDefinition definition) {
  final fields = definition.properties.map((p) {
    final lines = <String>[];
    lines.addAll(p.annotations.map((e) => '@$e'));
    lines.add(
        '${p.type.isNonNull ? 'late ' : ''}${p.type.namePrintable} ${p.name.namePrintable};');
    return lines.join('\n');
  });

  return CodeExpression(Code('''mixin ${definition.name.namePrintable} {
  ${fields.join('\n')}
}'''));
}

/// Generates a [Spec] of a mutation argument class.
Spec generateArgumentClassSpec(QueryDefinition definition) {
  return Class(
    (b) => b
      ..annotations
          .add(CodeExpression(Code('JsonSerializable(explicitToJson: true)')))
      ..name = '${definition.className}Arguments'
      ..extend = refer('JsonSerializable')
      ..mixins.add(refer('EquatableMixin'))
      ..methods.add(_propsMethod(
          definition.inputs.map((input) => input.name.namePrintable)))
      ..constructors.add(Constructor(
        (b) => b
          ..optionalParameters.addAll(definition.inputs.map(
            (input) => Parameter(
              (p) {
                p
                  ..name = input.name.namePrintable
                  ..named = true
                  ..toThis = true
                  ..required = input.type.isNonNull;
              },
            ),
          )),
      ))
      ..constructors.add(Constructor(
        (b) => b
          ..factory = true
          ..name = 'fromJson'
          ..lambda = true
          ..requiredParameters.add(Parameter(
            (p) => p
              ..type = refer('Map<String, dynamic>')
              ..name = 'json',
          ))
          ..annotations.add(CodeExpression(Code('override')))
          ..body = Code('_\$${definition.className}ArgumentsFromJson(json)'),
      ))
      ..methods.add(Method(
        (m) => m
          ..name = 'toJson'
          ..lambda = true
          ..returns = refer('Map<String, dynamic>')
          ..annotations.add(CodeExpression(Code('override')))
          ..body = Code('_\$${definition.className}ArgumentsToJson(this)'),
      ))
      ..fields.addAll(definition.inputs.map(
        (p) => Field(
          (f) {
            f
              ..name = p.name.namePrintable
              // TODO: remove this workaround when code_builder includes late field modifier:
              // https://github.com/dart-lang/code_builder/pull/310
              ..type = refer(
                  '${p.type.isNonNull ? 'late ' : ''} ${p.type.namePrintable}')
              ..annotations
                  .addAll(p.annotations.map((e) => CodeExpression(Code(e))));

            if (!p.type.isNonNull) {
              f.modifier = FieldModifier.final$;
            }
          },
        ),
      )),
  );
}

Spec generateQuerySpec(QueryDefinition definition) {
  return Block((b) => b
    ..statements.addAll([
      Code(
          "final ${definition.documentOperationName.constantCase} = '${definition.operationName}';"),
      Code('final ${definition.documentName.constantCase} = '),
      dart.fromNode(definition.document).code,
      Code(';'),
    ]));
}

/// Generates a [Spec] of a query/mutation class.
Spec generateQueryClassSpec(QueryDefinition definition) {
  final typeDeclaration = definition.inputs.isEmpty
      ? '${definition.name.namePrintable}, JsonSerializable'
      : '${definition.name.namePrintable}, ${definition.className}Arguments';

  final name = '${definition.className}${definition.suffix}';

  final constructor = definition.inputs.isEmpty
      ? Constructor()
      : Constructor((b) => b
        ..optionalParameters.add(Parameter(
          (p) => p
            ..name = 'variables'
            ..toThis = true
            ..named = true
            ..required = true,
        )));

  final fields = [
    Field(
      (f) => f
        ..annotations.add(CodeExpression(Code('override')))
        ..modifier = FieldModifier.final$
        ..type = refer('DocumentNode', 'package:gql/ast.dart')
        ..name = 'document'
        ..assignment = Code(definition.documentName.constantCase),
    ),
    Field(
      (f) => f
        ..annotations.add(CodeExpression(Code('override')))
        ..modifier = FieldModifier.final$
        ..type = refer('String')
        ..name = 'operationName'
        ..assignment = Code(definition.documentOperationName.constantCase),
    ),
  ];

  if (definition.inputs.isNotEmpty) {
    fields.add(Field(
      (f) => f
        ..annotations.add(CodeExpression(Code('override')))
        ..modifier = FieldModifier.final$
        ..type = refer('${definition.className}Arguments')
        ..name = 'variables',
    ));
  }

  return Class(
    (b) => b
      ..name = name
      ..extend = refer('GraphQLQuery<$typeDeclaration>')
      ..constructors.add(constructor)
      ..fields.addAll(fields)
      ..methods.add(_propsMethod([
        'document',
        'operationName${definition.inputs.isNotEmpty ? ', variables' : ''}'
      ]))
      ..methods.add(Method(
        (m) => m
          ..annotations.add(CodeExpression(Code('override')))
          ..returns = refer(definition.name.namePrintable)
          ..name = 'parse'
          ..requiredParameters.add(Parameter(
            (p) => p
              ..type = refer('Map<String, dynamic>')
              ..name = 'json',
          ))
          ..lambda = true
          ..body = Code('${definition.name.namePrintable}.fromJson(json)'),
      )),
  );
}

/// Gathers and generates a [Spec] of a whole query/mutation and its
/// dependencies into a single library file.
Spec generateLibrarySpec(LibraryDefinition definition) {
  final importDirectives = [
    Directive.import('package:json_annotation/json_annotation.dart'),
    Directive.import('package:equatable/equatable.dart'),
    Directive.import('package:gql/ast.dart'),
  ];

  if (definition.queries.any((q) => q.generateHelpers)) {
    importDirectives.insertAll(
      0,
      [
        Directive.import('package:artemis/artemis.dart'),
      ],
    );
  }

  importDirectives.addAll(definition.customImports
      .map((customImport) => Directive.import(customImport)));

  final bodyDirectives = <Spec>[
    CodeExpression(Code('part \'${definition.basename}.g.dart\';')),
  ];

  final uniqueDefinitions = definition.queries
      .map((e) => e.classes.map((e) => e))
      .expand((e) => e)
      .fold<Map<String?, Definition>>(<String?, Definition>{}, (acc, element) {
    acc[element.name.name] = element;

    return acc;
  }).values;

  final fragments = uniqueDefinitions.whereType<FragmentClassDefinition>();
  final classes = uniqueDefinitions.whereType<ClassDefinition>();
  final enums = uniqueDefinitions.whereType<EnumDefinition>();

  bodyDirectives.addAll(fragments.map(fragmentClassDefinitionToSpec));
  bodyDirectives.addAll(
      classes.map((cDef) => classDefinitionToSpec(cDef, fragments, classes)));
  bodyDirectives.addAll(enums.map(enumDefinitionToSpec));

  for (final queryDef in definition.queries) {
    if (queryDef.inputs.isNotEmpty &&
        (queryDef.generateHelpers || queryDef.generateQueries)) {
      bodyDirectives.add(generateArgumentClassSpec(queryDef));
    }

    if (queryDef.generateHelpers || queryDef.generateQueries) {
      bodyDirectives.add(generateQuerySpec(queryDef));
    }

    if (queryDef.generateHelpers) {
      bodyDirectives.add(generateQueryClassSpec(queryDef));
    }
  }

  return Library(
    (b) => b
      ..directives.addAll(importDirectives)
      ..body.addAll(bodyDirectives),
  );
}

/// Emit a [Spec] into a String, considering Dart formatting.
String specToString(Spec spec) {
  final emitter = DartEmitter();
  return DartFormatter().format(spec.accept(emitter).toString());
}

/// Generate Dart code typings from a query or mutation and its response from
/// a [QueryDefinition] into a buffer.
void writeLibraryDefinitionToBuffer(
  StringBuffer buffer,
  List<String> ignoreForFile,
  LibraryDefinition definition,
) {
  buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  buffer.writeln('// @dart = 2.12');
  if (ignoreForFile.isNotEmpty) {
    buffer.writeln(
      '// ignore_for_file: ${Set<String>.from(ignoreForFile).join(', ')}',
    );
  }
  buffer.write('\n');
  buffer.write(specToString(generateLibrarySpec(definition)));
}

/// Generate an empty file just exporting the library. This is used to avoid
/// a breaking change on file generation.
String writeLibraryForwarder(LibraryDefinition definition) =>
    '''// GENERATED CODE - DO NOT MODIFY BY HAND
export '${definition.basename}.dart';
''';
