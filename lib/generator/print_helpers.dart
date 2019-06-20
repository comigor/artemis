import 'package:recase/recase.dart';
import 'package:artemis/generator/data.dart';

void printCustomEnum(
    StringBuffer buffer, String enumName, List<String> enumValues) {
  buffer.writeln('enum $enumName {');
  for (final enumValue in enumValues) {
    buffer.writeln('  $enumValue,');
  }
  buffer.writeln('}');
}

void printCustomClass(StringBuffer buffer, ClassDefinition definition) async {
  buffer.writeln('''

@JsonSerializable()
class ${definition.className} ${definition.mixins} {''');

  for (final prop in definition.classProperties) {
    if (prop.override) buffer.writeln('  @override');
    if (prop.annotation != null) buffer.writeln('  ${prop.annotation}');
    buffer.writeln('  ${prop.type} ${prop.name};');
  }

  buffer.writeln('''

  ${definition.className}();''');

  if (definition.factoryPossibilities.isNotEmpty) {
    buffer.writeln('''

  factory ${definition.className}.fromJson(Map<String, dynamic> json) {
    switch (json['${definition.resolveTypeField}']) {''');

    for (final p in definition.factoryPossibilities) {
      buffer.writeln('''case '$p':
        return ${p}.fromJson(json);''');
    }

    buffer.writeln('''default:
    }
    return _\$${definition.className}FromJson(json);
  }
  Map<String, dynamic> toJson() {
    switch (resolveType) {''');

    for (final p in definition.factoryPossibilities) {
      buffer.writeln('''case '$p':
        return (this as ${p}).toJson();''');
    }

    buffer.writeln('''default:
    }
    return _\$${definition.className}ToJson(this);
  }''');
  } else {
    buffer.writeln(
        '''factory ${definition.className}.fromJson(Map<String, dynamic> json) => _\$${definition.className}FromJson(json);
  Map<String, dynamic> toJson() => _\$${definition.className}ToJson(this);''');
  }

  buffer.writeln('}');
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
    buffer.writeln('  import \'${definition.customParserImport}\';');
  }

  buffer.writeln('\npart \'${definition.basename}.query.g.dart\';');

  definition.classes.forEach((c) => printCustomClass(buffer, c));

  if (definition.generateHelpers) {
    final sanitizedQueryStr = definition.query
        .replaceAll(RegExp(r'\s+'), ' ')
        .replaceAll(RegExp(r'\$'), '\\\$')
        .trim();

    String buildArguments = '';
    if (definition.inputs.isNotEmpty) {
      buildArguments =
          definition.inputs.map((i) => '${i.type} ${i.name}').join(',') + ',';
    }

    buffer.writeln('''
Future<${definition.queryName}> execute${definition.queryName}Query(String graphQLEndpoint, $buildArguments {http.Client client}) async {
  final httpClient = client ?? http.Client();
  final dataResponse = await httpClient.post(graphQLEndpoint, body: json.encode({
    'operationName': '${ReCase(definition.queryName).snakeCase}',
    'query': '$sanitizedQueryStr',''');

    if (definition.inputs.isNotEmpty) {
      final variableMap =
          definition.inputs.map((i) => '\'${i.name}\': ${i.name}').join(', ');
      buffer.writeln('\'variables\': {$variableMap},');
    }

    buffer.writeln('''}),  
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
  );
  httpClient.close();

  return ${definition.queryName}.fromJson(json.decode(dataResponse.body)['data']);
}
''');
  }
}
