import 'package:artemis/generator/data/annotation.dart';
import 'package:artemis/generator/data/data.dart';
import 'package:artemis/generator/data/enum_value_definition.dart';
import 'package:artemis/schema/options.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:dart_style/dart_style.dart';
import 'package:gql_code_builder/src/ast.dart' as dart;
import 'package:recase/recase.dart';

import '../generator/helpers.dart';

final _overrideCodeExpresion = CodeExpression(Code(
  OverrideAnnotation().toAnnotation(),
));

/// Generates a [Spec] of a single enum definition.
Spec enumDefinitionToSpec(EnumDefinition definition) =>
    CodeExpression(Code('''enum ${definition.name.namePrintable} {
  ${definition.values.removeDuplicatedBy((i) => i).map(_enumValueToSpec).join()}
}'''));

String _enumValueToSpec(EnumValueDefinition value) {
  final annotations = value.annotations
      .map((annotation) => '@${annotation.toAnnotation()}')
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

String _toJsonBody(ClassDefinition definition, bool excludeNullable) {
  final buffer = StringBuffer();
  final typeName = definition.typeNameField.namePrintable;
  buffer.writeln('''switch ($typeName) {''');

  for (final p in definition.factoryPossibilities.entries) {
    buffer.writeln('''      case r'${p.key}':
        return (this as ${p.value.namePrintable}).toJson();''');
  }

  buffer.writeln('''      default:
    }''');

  if (definition.isInput && excludeNullable) {
    buffer.writeln(
        'return _excludeNullable(_\$${definition.name.namePrintable}ToJson(this));');
  } else {
    buffer.writeln('return _\$${definition.name.namePrintable}ToJson(this);');
  }

  return buffer.toString();
}

Method _propsMethod(String body) {
  return Method((m) => m
    ..type = MethodType.getter
    ..returns = refer('List<Object?>')
    ..annotations.add(_overrideCodeExpresion)
    ..name = 'props'
    ..lambda = true
    ..body = Code(body));
}

List<Annotation> _jsonKeyAnnotationNullable(
    List<Annotation> existingAnnotations) {
  final jsonKeyAnnotation =
      existingAnnotations.indexWhere((e) => e is JsonKeyAnnotation);

  if (jsonKeyAnnotation != -1) {
    final annotation =
        existingAnnotations[jsonKeyAnnotation] as JsonKeyAnnotation;
    final updatedJsonKeyAnnotation = JsonKeyAnnotation(
      jsonKey: annotation.jsonKey.copyWith(
        fromJson: '_nullableFromJson',
        toJson: '_nullableToJson',
      ),
    );

    return List.from(existingAnnotations)
      ..replaceRange(
        jsonKeyAnnotation,
        jsonKeyAnnotation,
        [updatedJsonKeyAnnotation],
      );
  }

  return List.from(existingAnnotations)
    ..add(
      JsonKeyAnnotation(
        jsonKey: JsonKeyItem(
          fromJson: '_nullableFromJson',
          toJson: '_nullableToJson',
        ),
      ),
    );
}

Method _excludeNullable(Iterable<QueryInput> inputs) {
  return Method(
    (m) => m
      ..name = '_excludeNullable'
      ..lambda = false
      ..returns = refer('Map<String, dynamic>')
      ..requiredParameters.add(Parameter(
        (p) => p
          ..name = 'json'
          ..type = refer('Map<String, dynamic>'),
      ))
      ..annotations.add(_overrideCodeExpresion)
      ..body = Code('''
            ${inputs.map((p) {
        if (!p.type.isNonNull) {
          return 'if(${p.name.namePrintable} == null) json.remove(\'${p.name.namePrintable}\');';
        }
        return '';
      }).join('')}

                return json;
          '''),
  );
}

/// Generates a [Spec] of a single class definition.
Spec classDefinitionToSpec(
  ClassDefinition definition,
  Iterable<FragmentClassDefinition> fragments,
  Iterable<ClassDefinition> classes,
  GeneratorOptions options,
  SchemaMap schemaMap,
) {
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
            ..annotations.add(_overrideCodeExpresion)
            ..returns = refer('Map<String, dynamic>')
            ..body = Code(_toJsonBody(definition, schemaMap.toJsonExclude)),
        )
      : Method(
          (m) => m
            ..name = 'toJson'
            ..lambda = true
            ..annotations.add(_overrideCodeExpresion)
            ..returns = refer('Map<String, dynamic>')
            ..body = Code(schemaMap.toJsonExclude && definition.isInput
                ? '_excludeNullable(_\$${definition.name.namePrintable}ToJson(this))'
                : '_\$${definition.name.namePrintable}ToJson(this)'),
        );

  final props = definition.mixins
      .map((i) {
        return fragments
            .firstWhere((f) {
              return f.name == i;
            })
            .properties
            .map((p) => p.name.namePrintable);
      })
      .expand((i) => i)
      .followedBy(definition.properties.map((p) => p.name.namePrintable));

  final extendedClass =
      classes.firstWhereOrNull((e) => e.name == definition.extension);

  return Class(
    (b) {
      b
        ..annotations
            .add(CodeExpression(Code('JsonSerializable(explicitToJson: true)')))
        ..name = definition.name.namePrintable
        ..mixins.add(refer('EquatableMixin'))
        ..mixins.addAll(definition.mixins.map((i) => refer(i.namePrintable)))
        ..methods.add(_propsMethod('[${props.join(',')}]'))
        ..extend = definition.extension != null
            ? refer(definition.extension!.namePrintable)
            : refer('JsonSerializable')
        ..implements.addAll(definition.implementations.map((i) => refer(i)))
        ..constructors.add(Constructor((b) {
          if (definition.isInput) {
            b.optionalParameters.addAll(definition.properties
                .where((property) =>
                    !property.isOverride && !property.isResolveType)
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
            p.annotations.add(OverrideAnnotation());
          }

          final lateModifier =
              p.type.isNonNull && !definition.isInput ? 'late ' : '';

          var annotations = p.annotations;

          if (schemaMap.toJsonExclude &&
              definition.isInput &&
              !p.type.isNonNull) {
            annotations = _jsonKeyAnnotationNullable(p.annotations);
          }

          final field = Field((f) {
            f
              ..name = p.name.namePrintable
              ..type = refer(lateModifier +
                  (schemaMap.toJsonExclude &&
                          definition.isInput &&
                          !p.type.isNonNull
                      ? 'Nullable<${p.type.namePrintable}>?'
                      : p.type.namePrintable))
              ..annotations.addAll(
                annotations.map((e) => CodeExpression(Code(e.toAnnotation()))),
              );
            if (definition.isInput) {
              f.modifier = FieldModifier.final$;
            }

            if (p.type.isNonNull) {
              // TODO: apply this fix when code_builder includes late field modifier:
              // https://github.com/dart-lang/code_builder/pull/310
              // f.modifier = FieldModifier.late$;
            }
          });
          return field;
        }));

      if (schemaMap.toJsonExclude && definition.isInput) {
        b.methods.add(_excludeNullable(definition.properties
            .where(
                (property) => !property.isOverride && !property.isResolveType)
            .map(
              (p) => QueryInput(
                  name: QueryInputName(name: p.name.name), type: p.type),
            )));
      }
    },
  );
}

/// Generates a [Spec] of a single fragment class definition.
Spec fragmentClassDefinitionToSpec(FragmentClassDefinition definition) {
  final fields = definition.properties.map((p) {
    final lines = <String>[];
    lines.addAll(p.annotations.map((e) => '@${e.toAnnotation()}'));
    lines.add(
        '${p.type.isNonNull ? 'late ' : ''}${p.type.namePrintable} ${p.name.namePrintable};');
    return lines.join('\n');
  });

  return CodeExpression(Code('''mixin ${definition.name.namePrintable} {
  ${fields.join('\n')}
}'''));
}

/// Generates a [Spec] of a mutation argument class.
Spec generateArgumentClassSpec(
  QueryDefinition definition,
  GeneratorOptions options,
  SchemaMap schemaMap,
) {
  return Class(
    (b) {
      b
        ..annotations
            .add(CodeExpression(Code('JsonSerializable(explicitToJson: true)')))
        ..name = '${definition.className}Arguments'
        ..extend = refer('JsonSerializable')
        ..mixins.add(refer('EquatableMixin'))
        ..methods.add(_propsMethod(
            '[${definition.inputs.map((input) => input.name.namePrintable).join(',')}]'))
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
            ..annotations.add(_overrideCodeExpresion)
            ..body = Code('_\$${definition.className}ArgumentsFromJson(json)'),
        ))
        ..methods.add(Method(
          (m) => m
            ..name = 'toJson'
            ..lambda = true
            ..returns = refer('Map<String, dynamic>')
            ..annotations.add(_overrideCodeExpresion)
            ..body = schemaMap.toJsonExclude
                ? Code(
                    '_excludeNullable(_\$${definition.className}ArgumentsToJson(this))')
                : Code('_\$${definition.className}ArgumentsToJson(this)'),
        ))
        ..fields.addAll(definition.inputs.map(
          (p) => Field(
            (f) {
              var annotations = p.annotations;

              if (schemaMap.toJsonExclude && !p.type.isNonNull) {
                annotations = _jsonKeyAnnotationNullable(p.annotations);
              }

              f
                ..name = p.name.namePrintable
                ..type = refer(schemaMap.toJsonExclude && !p.type.isNonNull
                    ? 'Nullable<${p.type.namePrintable}>?'
                    : p.type.namePrintable)
                ..annotations.addAll(annotations.map((e) => CodeExpression(
                      Code(e.toAnnotation()),
                    )))
                ..modifier = FieldModifier.final$;
            },
          ),
        ));

      if (schemaMap.toJsonExclude) {
        b.methods.add(_excludeNullable(definition.inputs));
      }
    },
  );
}

/// Generates a [Spec] of a query/mutation class.
List<Spec> generateQueryClassSpec(QueryDefinition definition) {
  final typeDeclaration = definition.inputs.isEmpty
      ? '${definition.name.namePrintable}, JsonSerializable'
      : '${definition.name.namePrintable}, ${definition.className}Arguments';

  final name = '${definition.className}${definition.suffix}';
  final documentName = ReCase('${name}Document').constantCase;

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
        ..annotations.add(_overrideCodeExpresion)
        ..modifier = FieldModifier.final$
        ..type = refer('DocumentNode', 'package:gql/ast.dart')
        ..name = 'document'
        ..assignment = Code(documentName),
    ),
    Field(
      (f) => f
        ..annotations.add(_overrideCodeExpresion)
        ..modifier = FieldModifier.final$
        ..type = refer('String')
        ..name = 'operationName'
        ..assignment = Code('\'${definition.operationName}\''),
    ),
  ];

  if (definition.inputs.isNotEmpty) {
    fields.add(Field(
      (f) => f
        ..annotations.add(_overrideCodeExpresion)
        ..modifier = FieldModifier.final$
        ..type = refer('${definition.className}Arguments')
        ..name = 'variables',
    ));
  }

  return [
    Block((b) => b
      ..statements.addAll([
        Code('final $documentName = '),
        dart.fromNode(definition.document).code,
        Code(';'),
      ])),
    Class(
      (b) => b
        ..name = name
        ..extend = refer('GraphQLQuery<$typeDeclaration>')
        ..constructors.add(constructor)
        ..fields.addAll(fields)
        ..methods.add(_propsMethod(
            '[document, operationName${definition.inputs.isNotEmpty ? ', variables' : ''}]'))
        ..methods.add(Method(
          (m) => m
            ..annotations.add(_overrideCodeExpresion)
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
    )
  ];
}

/// Gathers and generates a [Spec] of a whole query/mutation and its
/// dependencies into a single library file.
Spec generateLibrarySpec(
  LibraryDefinition definition,
  GeneratorOptions options,
  SchemaMap schemaMap,
) {
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

  if (schemaMap.toJsonExclude) {
    bodyDirectives.add(Code(r'''
            class Nullable<T> {
              final T _value;
            
              Nullable(this._value);
            
              T get value => _value;
            }
            
            dynamic _nullableToJson<T>(T? value) {
              if (value is Nullable?) {
                final objectValue = value?.value;
            
                if (objectValue is JsonSerializable) {
                  return objectValue.toJson();
                }
            
                return value?.value;
              }
              return null;
            }
            
            T? _nullableFromJson<T>(Object? value) {
              throw Exception('From JSON is not supported.');
            }
        '''));
  }

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
  bodyDirectives.addAll(classes.map((cDef) => classDefinitionToSpec(
        cDef,
        fragments,
        classes,
        options,
        schemaMap,
      )));
  bodyDirectives.addAll(enums.map(enumDefinitionToSpec));

  for (final queryDef in definition.queries) {
    if (queryDef.inputs.isNotEmpty && queryDef.generateHelpers) {
      bodyDirectives.add(generateArgumentClassSpec(
        queryDef,
        options,
        schemaMap,
      ));
    }
    if (queryDef.generateHelpers) {
      bodyDirectives.addAll(generateQueryClassSpec(queryDef));
    }
  }

  return Library(
    (b) => b..directives.addAll(importDirectives)..body.addAll(bodyDirectives),
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
  GeneratorOptions options,
  SchemaMap schemaMap,
  LibraryDefinition definition,
) {
  buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  buffer.writeln('// @dart = 2.12');
  if (options.ignoreForFile.isNotEmpty) {
    buffer.writeln(
      '// ignore_for_file: ${Set<String>.from(options.ignoreForFile).join(', ')}',
    );
  }
  buffer.write('\n');
  buffer.write(specToString(generateLibrarySpec(
    definition,
    options,
    schemaMap,
  )));
}

/// Generate an empty file just exporting the library. This is used to avoid
/// a breaking change on file generation.
String writeLibraryForwarder(LibraryDefinition definition) =>
    '''// GENERATED CODE - DO NOT MODIFY BY HAND
export '${definition.basename}.dart';
''';

String writeNullableFile(LibraryDefinition definition) =>
    '''// GENERATED CODE - DO NOT MODIFY BY HAND
export '${definition.basename}.dart';
''';
