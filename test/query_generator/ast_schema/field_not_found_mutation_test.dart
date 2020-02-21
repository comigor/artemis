import 'package:artemis/generator/data.dart';
import 'package:gql/language.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On AST schema', () {
    test(
      'Field was not found on mutation',
      () async => testGenerator(
        query: query,
        schema: r'''
          schema {
            mutation: MutationRoot
          }

          input CreateThingInput {
            clientId: ID!
            message: String
          }

          type Thing {
            id: ID!
            message: String
          }

          type CreateThingResponse {
            thing: Thing
          }

          type MutationRoot {
            createThing(input: CreateThingInput): CreateThingResponse
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
      ),
    );
  });
}

const query = r'''
mutation createThing($createThingInput: CreateThingInput) {
  createThing(input: $createThingInput) {
    thing {
      id
      message
    }
  }
}
''';

final LibraryDefinition libraryDefinition = null;

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND''';
