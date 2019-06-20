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
