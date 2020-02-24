import 'package:artemis/generator/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On naming', () {
    test(
      'On pathedWithClassNames naming scheme',
      () async => testNaming(
        query: query,
        schema: schema,
        libraryDefinition: libraryDefinition,
      ),
    );
  });
}

const schema = r'''
type Pokemon {
  number: String
  evolutions: [Pokemon]
}

type Query {
  pokemons(first: Int!): [Pokemon]
  pokemon(id: String, name: String): Pokemon
}
''';

const query = r'''
query big_query($quantity: Int!) {
  charmander: pokemon(name: "Charmander") {
    number
  }
  pokemons(first: $quantity) {
    number
    evolutions {
      ...pokemonParts
    }
    next: evolutions {
      ...pokemonParts
    }
  }
}

fragment pokemonParts on Pokemon {
  number
}
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query', queries: [
  QueryDefinition(
      queryName: r'big_query',
      queryType: r'BigQuery$Query',
      classes: [
        ClassDefinition(
            name: r'BigQuery$Query$Charmander',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r'number',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'BigQuery$Query$Pokemon$Pokemon',
            mixins: [r'BigQuery$PokemonPartsMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'BigQuery$Query$Pokemon$Next',
            mixins: [r'BigQuery$PokemonPartsMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'BigQuery$Query$Pokemon',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r'number',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: r'List<BigQuery$Query$Pokemon$Pokemon>',
                  name: r'evolutions',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: r'List<BigQuery$Query$Pokemon$Next>',
                  name: r'next',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'BigQuery$Query',
            properties: [
              ClassProperty(
                  type: r'BigQuery$Query$Charmander',
                  name: r'charmander',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: r'List<BigQuery$Query$Pokemon>',
                  name: r'pokemons',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        FragmentClassDefinition(
            name: r'BigQuery$PokemonPartsMixin',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r'number',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false)
            ])
      ],
      inputs: [QueryInput(type: r'int', name: r'quantity', isNonNull: true)],
      generateHelpers: false,
      suffix: r'Query')
]);
