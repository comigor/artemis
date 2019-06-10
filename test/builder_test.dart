import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';
import 'package:artemis/generator.dart';

const _emptyIntrospectionSchema = '''{
  "data": {
    "__schema": {
      "queryType": {
        "name": "Query"
      },
      "mutationType": null,
      "subscriptionType": null,
      "types": []
    }
  }
}''';

String emptyGeneratorResponse(String filename) =>
    '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part '$filename.api.g.dart';
''';

void main() {
  group('On file generation', () {
    final builder = graphQLTypesBuilder(BuilderOptions({}));

    test('A project can have no .schema.json files', () async {
      await testBuilder(builder, {
        'a|pubspec.yaml': 'a1',
        'a|lib/a2.dart': 'a2',
        'a|lib/a3.json': 'a3',
      }, outputs: {});
    });

    test('Multiple .schema.json can exist', () async {
      await testBuilder(builder, {
        'a|pubspec.yaml': 'a1',
        'a|lib/main.dart': 'a2',
        'a|lib/api.schema.json': _emptyIntrospectionSchema,
        'a|lib/schemas/project4.schema.json': _emptyIntrospectionSchema,
        'a|lib/schemas/project5.schema.json': _emptyIntrospectionSchema,
      }, outputs: {
        'a|lib/api.api.dart': emptyGeneratorResponse('api'),
        'a|lib/schemas/project4.api.dart': emptyGeneratorResponse('project4'),
        'a|lib/schemas/project5.api.dart': emptyGeneratorResponse('project5'),
      });
    });
  });
}
