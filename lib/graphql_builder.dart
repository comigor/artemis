library graphql_builder;

import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'schema/graphql.dart';
import 'dart:developer';

GraphQLType getTypeByName(GraphQLSchema schema, String name) =>
    schema.types.firstWhere((t) => t.name == name);

GraphQLType followType(GraphQLType type) {
  switch (type.kind) {
    case GraphQLTypeKind.LIST:
    case GraphQLTypeKind.NON_NULL:
      return followType(type.ofType);
    default:
      return type;
  }
}

bool isEventuallyList(GraphQLType type) {
  if (type == null) return false;
  switch (type.kind) {
    case GraphQLTypeKind.LIST:
      return true;
    default:
      return isEventuallyList(type.ofType);
  }
}

GraphQLType getTypeFromField(GraphQLSchema schema, GraphQLField field) {
  final finalType = followType(field.type);
  return getTypeByName(schema, finalType.name);
}

void printFields(GraphQLSchema schema, GraphQLField field, {int depth = 0}) {
  if (depth >= 5) return;

  final type = getTypeFromField(schema, field);
  final padding = List.filled(2 * depth, ' ').join();
  final argsStr = field.args.map((iv) => iv.name).join(', ');
  final hasChildren = type.fields.isNotEmpty;
  print(padding +
      field.name +
      (argsStr.isEmpty ? '' : '($argsStr)') +
      (hasChildren ? ' {' : ''));

  for (final subField in type.fields) {
    printFields(schema, subField, depth: depth + 1);
  }

  if (hasChildren) print(padding + '}');
}

typedef ScalarMap ScalarMapping(GraphQLType type);

void generateClass(GraphQLSchema schema, GraphQLType type,
    {String prefix = '', ScalarMapping scalarMap}) {
  final className = '$prefix${type.name}';
  switch (type.kind) {
    case GraphQLTypeKind.ENUM:
      print('enum $className {');
      for (final subEnumValue in type.enumValues) {
        print('  ${subEnumValue.name},');
      }
      print('}');
      return;
    case GraphQLTypeKind.OBJECT:
      print('@JsonSerializable()');
      print('class $className {');
      for (final subField in type.fields) {
        final subType = getTypeFromField(schema, subField);
        final isList = isEventuallyList(subField.type);

        final typeStr = subType.kind == GraphQLTypeKind.SCALAR
            ? scalarMap(subType).dartType
            : subType.name;

        if (subType.kind == GraphQLTypeKind.SCALAR &&
            scalarMap(subType).useCustomParsers) {
          final graphqlType = scalarMap(subType).graphqlType;
          print(
              '  @JsonKey(fromJson: fromGraphQL${graphqlType}ToDart$typeStr, toJson: fromDart${typeStr}ToGraphQL$graphqlType)');
        }

        final addListIfNecessary = () {
          if (isList) return '  List<$typeStr> ${subField.name};';
          return '  $typeStr ${subField.name};';
        };

        print(addListIfNecessary());
      }
      print(
          '''\n  factory $className.fromJson(Map<String, dynamic> json) => _\$${className}FromJson(json);
  Map<String, dynamic> toJson() => _\$${className}ToJson(this);''');
      print('}');
      return;
    default:
  }
}

class ScalarMap {
  final String graphqlType;
  final String dartType;
  final bool useCustomParsers;

  ScalarMap(
    this.graphqlType,
    this.dartType, {
    this.useCustomParsers = false,
  });
}

final dateFormatter = DateFormat('yyyy-MM-dd');
final timeFormatter = DateFormat('HH:mm:ss');

DateTime fromGraphQLDateToDartDateTime(String date) => DateTime.parse(date);
String fromDartDateTimeToGraphQLDate(DateTime date) =>
    dateFormatter.format(date);
DateTime fromGraphQLTimeToDartDateTime(String time) =>
    DateTime.parse('1970-01-01T${time}Z');
String fromDartDateTimeToGraphQLTime(DateTime date) =>
    timeFormatter.format(date);
DateTime fromGraphQLDateTimeToDartDateTime(String date) => DateTime.parse(date);
String fromDartDateTimeToGraphQLDateTime(DateTime date) =>
    date.toIso8601String();

void main() async {
  final file = File(
      '/Users/igor/Projects/nu/mini-meta-repo/cross-platform/react-native/data/schema.json');
  final schema = GraphQLSchema.fromJson(
      await file.readAsString().then((s) => json.decode(s)));

  final queryRoot = getTypeByName(schema, schema.queryType.name);

  // printFields(schema, queryRoot);
  final nubankInfo = queryRoot.fields.firstWhere((f) => f.name == 'nubankInfo');

  // printFields(schema, nubankInfo);

  print('''import 'package:json_annotation/json_annotation.dart';
  
part 'graphql_api.g.dart';
''');

  for (final t in schema.types) {
    generateClass(schema, t, scalarMap: (GraphQLType type) {
      final mappings = [
        ScalarMap('Boolean', 'bool'),
        ScalarMap('Date', 'DateTime', useCustomParsers: true),
        ScalarMap('DateTime', 'DateTime', useCustomParsers: true),
        ScalarMap('Float', 'double'),
        ScalarMap('ID', 'String'),
        ScalarMap('Int', 'int'),
        ScalarMap('Map', 'Map'),
        ScalarMap('String', 'String'),
        ScalarMap('Time', 'DateTime', useCustomParsers: true),
      ];
      return mappings.firstWhere((m) => m.graphqlType == type.name);
    });
    print('');
  }

  // debugger(message: 'aaaaaaaaaaaaaaaaa', when: true);
}
