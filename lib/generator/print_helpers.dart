import 'package:recase/recase.dart';
import 'package:artemis/generator/data.dart';
import 'package:artemis/generator/helpers.dart';

void printCustomEnum(StringBuffer buffer, EnumDefinition definition) {
  buffer.writeln('enum ${definition.name} {');
  for (final enumValue in removeDuplicatedBy(definition.values, (i) => i)) {
    buffer.writeln('  $enumValue,');
  }
  buffer.writeln('}');
}

void printCustomClass(StringBuffer buffer, ClassDefinition definition) async {
  buffer.writeln('''

@JsonSerializable(explicitToJson: true)
class ${definition.name} ${definition.mixins} {''');

  for (final prop in definition.properties) {
    if (prop.override) buffer.writeln('  @override');
    if (prop.annotation != null) buffer.writeln('  ${prop.annotation}');
    buffer.writeln('  ${prop.type} ${prop.name};');
  }

  buffer.writeln('''

  ${definition.name}();
''');

  if (definition.factoryPossibilities.isNotEmpty) {
    buffer.writeln('''
  factory ${definition.name}.fromJson(Map<String, dynamic> json) {
    switch (json['${definition.resolveTypeField}']) {''');

    for (final p in definition.factoryPossibilities) {
      buffer.writeln('''      case '$p':
        return ${p}.fromJson(json);''');
    }

    buffer.writeln('''      default:
    }
    return _\$${definition.name}FromJson(json);
  }
  Map<String, dynamic> toJson() {
    switch (resolveType) {''');

    for (final p in definition.factoryPossibilities) {
      buffer.writeln('''      case '$p':
        return (this as ${p}).toJson();''');
    }

    buffer.writeln('''      default:
    }
    return _\$${definition.name}ToJson(this);
  }''');
  } else {
    buffer.writeln(
        '''  factory ${definition.name}.fromJson(Map<String, dynamic> json) => _\$${definition.name}FromJson(json);
  Map<String, dynamic> toJson() => _\$${definition.name}ToJson(this);''');
  }

  buffer.writeln('}');
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
