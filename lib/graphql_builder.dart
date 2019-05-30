library graphql_builder;

import 'dart:io';
import 'dart:convert';
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

typedef String ScalarMapping(GraphQLType type);

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

        final addListIfNecessary = (String typeStr) {
          if (isList) return '  List<$typeStr> ${subField.name};';
          return '  $typeStr ${subField.name};';
        };

        print(addListIfNecessary(subType.kind == GraphQLTypeKind.SCALAR
            ? scalarMap(subType)
            : subType.name));
      }
      print(
          '''\n  factory $className.fromJson(Map<String, dynamic> json) => _\$${className}FromJson(json);
  Map<String, dynamic> toJson() => _\$${className}ToJson(this);''');
      print('}');
      return;
    default:
  }
}

void main() async {
  final file = File(
      '/Users/igor/Projects/nu/mini-meta-repo/cross-platform/react-native/data/schema.json');
  final schema = GraphQLSchema.fromJson(
      await file.readAsString().then((s) => json.decode(s)));

  final queryRoot = getTypeByName(schema, schema.queryType.name);

  // printFields(schema, queryRoot);
  final nubankInfo = queryRoot.fields.firstWhere((f) => f.name == 'nubankInfo');

  // printFields(schema, nubankInfo);

  for (final t in schema.types) {
    generateClass(schema, t, scalarMap: (GraphQLType type) {
      final map = {
        'Boolean': 'bool',
        'Date': 'DateTime',
        'DateTime': 'DateTime',
        'Float': 'double',
        'ID': 'String',
        'Int': 'int',
        'Map': 'Map',
        'String': 'String',
        'Time': 'DateTime',
      };
      return map[type.name];
    });
    print('');
  }

  debugger(message: 'aaaaaaaaaaaaaaaaa', when: true);

  // print(schema);

  // final queryRootObject =
  //     schema.types.firstWhere((t) => t.name == schema.queryType.name);
  // final List<String> queries =
  //     queryRootObject.fields.map((f) => f.name).toList();

  // print(queries);
  // print(displayQuery(
  //     schema, queryRootObject, getFieldByName(queryRootObject, 'nubankInfo')));
  // print(displayQuery(schema, getFieldByName(queryRootObject, 'viewer')));
}
