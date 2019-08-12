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

@JsonSerializable()
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
  String argumentsMap = '';
  String argumentsDeclarations = '';
  String argumentConstructor = '';
  if (definition.inputs.isNotEmpty) {
    argumentsDeclarations =
        definition.inputs.map((i) => 'final ${i.type} ${i.name};').join('\n');
    argumentConstructor =
        '{' + definition.inputs.map((i) => 'this.${i.name}').join(',\n') + '}';
    argumentsMap = '{' +
        definition.inputs.map((i) => "'${i.name}': this.${i.name}").join(',') +
        '}';
  }
  final str = '''class ${definition.queryName}Arguments {
  ${definition.queryName}Arguments(${argumentConstructor});

  ${argumentsDeclarations}
  
  Map<String, dynamic> toMap() {
    return ${argumentsMap};
  }
}
''';
  buffer.write(str);
}

void printQueryClass(StringBuffer buffer, QueryDefinition definition) {
  final sanitizedQueryStr = definition.query
      .replaceAll(RegExp(r'\s+'), ' ')
      .replaceAll(RegExp(r'\$'), '\\\$')
      .trim();

  String variablesDeclaration = '';
  String constructor = '()';
  String typeDeclaration = '${definition.queryName}, void';
  if (definition.inputs.isNotEmpty) {
    variablesDeclaration = '''  @override
  final ${definition.queryName}Arguments variables;''';
    constructor = '''({this.variables})''';
    typeDeclaration =
        '${definition.queryName}, ${definition.queryName}Arguments';
  }

  final str =
      '''class ${definition.queryName}Query extends GraphQLQuery<$typeDeclaration> {
  ${definition.queryName}Query${constructor};
${variablesDeclaration}
  @override
  final String query = '${sanitizedQueryStr}';

  @override
  ${definition.queryName} parse(Map<String, dynamic> json) {
    return ${definition.queryName}.fromJson(json);
  }
}
''';
  buffer.write(str);
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
  if (definition.generateHelpers) {
    buffer.writeln('import \'package:artemis/schema/graphql_query.dart\';');
    buffer.writeln('import \'package:artemis/schema/graphql_error.dart\';');
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
Future<GraphQLResponse<${definition.queryName}>> execute${definition.queryName}Query(String graphQLEndpoint, $buildArguments {http.Client client}) async {
  final httpClient = client ?? http.Client();
  final dataResponse = await httpClient.post(graphQLEndpoint,
    body: json.encode({
      'operationName': '${ReCase(definition.queryName).snakeCase}',
      'query': '$sanitizedQueryStr',''');

    if (definition.inputs.isNotEmpty) {
      final variableMap =
          definition.inputs.map((i) => '\'${i.name}\': ${i.name}').join(', ');
      buffer.writeln('      \'variables\': {$variableMap},');
    }

    buffer.writeln('''    }),
    headers: (client != null)
        ? null
        : {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
  );

  final Map<String, dynamic> jsonBody = json.decode(dataResponse.body);
  final response = GraphQLResponse<${definition.queryName}>.fromJson(jsonBody)
    ..data = ${definition.queryName}.fromJson(jsonBody['data'] ?? <Map<String, dynamic>>{});

  if (client == null) {
    httpClient.close();
  }

  return response;
}''');
  }
}
