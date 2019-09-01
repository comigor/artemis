import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:recase/recase.dart';
import '../generator/data.dart';
import '../generator/helpers.dart';

void printCustomEnum(StringBuffer buffer, EnumDefinition definition) {
  buffer.writeln('enum ${definition.name} {');
  for (final enumValue in removeDuplicatedBy(definition.values, (i) => i)) {
    buffer.writeln('  $enumValue,');
  }
  buffer.writeln('}');
}

String _fromJsonBody(ClassDefinition definition) {
  final buffer = StringBuffer();
  buffer.writeln('''switch (json['${definition.resolveTypeField}']) {''');

  for (final p in definition.factoryPossibilities) {
    buffer.writeln('''      case '$p':
        return ${p}.fromJson(json);''');
  }

  buffer.writeln('''      default:
    }
    return _\$${definition.name}FromJson(json);''');
  return buffer.toString();
}

String _toJsonBody(ClassDefinition definition) {
  final buffer = StringBuffer();
  buffer.writeln('''switch (resolveType) {''');

  for (final p in definition.factoryPossibilities) {
    buffer.writeln('''      case '$p':
        return (this as ${p}).toJson();''');
  }

  buffer.writeln('''      default:
    }
    return _\$${definition.name}ToJson(this);''');
  return buffer.toString();
}

void printCustomClass(StringBuffer buffer, ClassDefinition definition) {
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
            ..body = Code('_\$${definition.name}FromJson(json)'),
        );

  final toJson = definition.factoryPossibilities.isNotEmpty
      ? Method(
          (m) => m
            ..name = 'toJson'
            ..returns = refer('Map<String, dynamic>')
            ..body = Code(_toJsonBody(definition)),
        )
      : Method(
          (m) => m
            ..name = 'toJson'
            ..lambda = true
            ..returns = refer('Map<String, dynamic>')
            ..body = Code('_\$${definition.name}ToJson(this)'),
        );

  final classDef = Class(
    (b) => b
      ..annotations
          .add(CodeExpression(Code('JsonSerializable(explicitToJson: true)')))
      ..name = definition.name
      ..extend =
          definition.extension != null ? refer(definition.extension) : null
      ..implements.addAll(definition.implementations.map((i) => refer(i)))
      ..constructors.add(Constructor())
      ..constructors.add(fromJson)
      ..methods.add(toJson)
      ..fields.addAll(definition.properties.map((p) {
        final annotations = <CodeExpression>[];
        if (p.override) annotations.add(CodeExpression(Code('override')));
        if (p.annotation != null)
          annotations.add(CodeExpression(Code(p.annotation)));
        final field = Field(
          (f) => f
            ..name = p.name
            ..type = refer(p.type)
            ..annotations.addAll(annotations),
        );
        return field;
      })),
  );

  final emitter = DartEmitter();
  buffer.writeln(DartFormatter().format(classDef.accept(emitter).toString()));
}

void printArgumentsClass(StringBuffer buffer, QueryDefinition definition) {
  String argumentsDeclarations = '';
  String argumentConstructor = '';
  if (definition.inputs.isNotEmpty) {
    argumentsDeclarations =
        definition.inputs.map((i) => 'final ${i.type} ${i.name};').join('\n');
    argumentConstructor =
        '{' + definition.inputs.map((i) => 'this.${i.name}').join(',\n') + '}';
  }
  buffer.write('''@JsonSerializable(explicitToJson: true)
class ${definition.queryName}Arguments extends JsonSerializable {
  ${definition.queryName}Arguments(${argumentConstructor});

  ${argumentsDeclarations}
  
  factory ${definition.queryName}Arguments.fromJson(Map<String, dynamic> json) =>
      _\$${definition.queryName}ArgumentsFromJson(json);
  Map<String, dynamic> toJson() => _\$${definition.queryName}ArgumentsToJson(this);
}
''');
}

void printQueryClass(StringBuffer buffer, QueryDefinition definition) {
  final sanitizedQueryStr = definition.query
      .replaceAll(RegExp(r'\s+'), ' ')
      .replaceAll(RegExp(r'\$'), '\\\$')
      .trim();

  String variablesDeclaration = '';
  String constructor = '()';
  String typeDeclaration = '${definition.queryName}, JsonSerializable';
  if (definition.inputs.isNotEmpty) {
    variablesDeclaration = '''  @override
  final ${definition.queryName}Arguments variables;''';
    constructor = '''({this.variables})''';
    typeDeclaration =
        '${definition.queryName}, ${definition.queryName}Arguments';
  }

  buffer.write(
      '''class ${definition.queryName}Query extends GraphQLQuery<$typeDeclaration> {
  ${definition.queryName}Query${constructor};
${variablesDeclaration}
  @override
  final String query = '${sanitizedQueryStr}';
  @override
  final String operationName = '${ReCase(definition.queryName).snakeCase}';

  @override
  ${definition.queryName} parse(Map<String, dynamic> json) {
    return ${definition.queryName}.fromJson(json);
  }
}
''');
}

void printCustomQuery(StringBuffer buffer, QueryDefinition definition) {
  buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND\n');
  if (definition.generateHelpers) {
    buffer.writeln('''import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;''');
  }

  buffer.writeln('import \'package:json_annotation/json_annotation.dart\';');
  if (definition.customParserImport != null) {
    buffer.writeln('import \'${definition.customParserImport}\';');
  }

  definition.customImports
      .forEach((customImport) => buffer.writeln('import \'$customImport\';'));

  if (definition.generateHelpers) {
    buffer.writeln('import \'package:artemis/artemis.dart\';');
  }

  buffer.writeln('\npart \'${definition.basename}.query.g.dart\';');

  definition.classes.forEach((d) {
    if (d is ClassDefinition) {
      printCustomClass(buffer, d);
    } else if (d is EnumDefinition) {
      printCustomEnum(buffer, d);
    }
  });
  if (definition.inputs.isNotEmpty) {
    printArgumentsClass(buffer, definition);
  }
  if (definition.generateHelpers) {
    printQueryClass(buffer, definition);
  }
}
