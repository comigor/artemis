import 'package:artemis/generator/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('Fragment duplication', () {
    test(
      'Fragment duplication should be properly handeled',
      () async => testGenerator(
        namingScheme: 'pathedWithFields',
        query: queryString,
        schema: r'''
          schema {
            query: Query
          }

          type Query {
            pokemon(id: String, name: String): Pokemon
            allPokemons: [Pokemon]
          }

          type Pokemon {
            id: String!
            name: String
            number: String
            evolution: Pokemon
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        builderOptionsMap: {'fragments_glob': '**.frag'},
        sourceAssetsMap: {
          'a|fragment.frag': fragmentsString,
          'a|queries/another_query.graphql': anotherQueryString,
        },
      ),
    );
  });
}

const fragmentsString = '''
  fragment PokemonParts on Pokemon {
    number
    name
  }
  
  fragment PokemonName on Pokemon {
    name
  }
  
  fragment Pokemon on Pokemon {
    id
    ...PokemonParts
    evolution {
      ...PokemonName
    }
  }
''';

const queryString = '''
  query PokemonData {
      pokemon(name: "Pikachu") {
        ...Pokemon
      }
  }
''';

const anotherQueryString = '''
  query AllPokemonsData {
      allPokemons {
        ...Pokemon
      }
  }
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      queryName: r'PokemonData',
      queryType: r'PokemonData$Query',
      classes: [
        ClassDefinition(
            name: TempName(name: r'PokemonData$Query$Pokemon'),
            mixins: [r'PokemonMixin', r'PokemonPartsMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: TempName(name: r'PokemonData$Query'),
            properties: [
              ClassProperty(
                  type: r'PokemonData$Query$Pokemon',
                  name: VariableName(name: r'pokemon'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: TempName(name: r'PokemonMixin$Evolution'),
            mixins: [r'PokemonNameMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        FragmentClassDefinition(
            name: TempName(name: r'PokemonMixin'),
            properties: [
              ClassProperty(
                  type: r'String',
                  name: VariableName(name: r'id'),
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: r'PokemonMixin$Evolution',
                  name: VariableName(name: r'evolution'),
                  isNonNull: false,
                  isResolveType: false)
            ]),
        FragmentClassDefinition(
            name: TempName(name: r'PokemonNameMixin'),
            properties: [
              ClassProperty(
                  type: r'String',
                  name: VariableName(name: r'name'),
                  isNonNull: false,
                  isResolveType: false)
            ]),
        FragmentClassDefinition(
            name: TempName(name: r'PokemonPartsMixin'),
            properties: [
              ClassProperty(
                  type: r'String',
                  name: VariableName(name: r'number'),
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: r'String',
                  name: VariableName(name: r'name'),
                  isNonNull: false,
                  isResolveType: false)
            ])
      ],
      generateHelpers: false,
      suffix: r'Query'),
  QueryDefinition(
      queryName: r'AllPokemonsData',
      queryType: r'AllPokemonsData$Query',
      classes: [
        ClassDefinition(
            name: TempName(name: r'AllPokemonsData$Query$AllPokemons'),
            mixins: [r'PokemonMixin', r'PokemonPartsMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: TempName(name: r'AllPokemonsData$Query'),
            properties: [
              ClassProperty(
                  type: r'List<AllPokemonsData$Query$AllPokemons>',
                  name: VariableName(name: r'allPokemons'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: TempName(name: r'PokemonMixin$Evolution'),
            mixins: [r'PokemonNameMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        FragmentClassDefinition(
            name: TempName(name: r'PokemonMixin'),
            properties: [
              ClassProperty(
                  type: r'String',
                  name: VariableName(name: r'id'),
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: r'PokemonMixin$Evolution',
                  name: VariableName(name: r'evolution'),
                  isNonNull: false,
                  isResolveType: false)
            ]),
        FragmentClassDefinition(
            name: TempName(name: r'PokemonNameMixin'),
            properties: [
              ClassProperty(
                  type: r'String',
                  name: VariableName(name: r'name'),
                  isNonNull: false,
                  isResolveType: false)
            ]),
        FragmentClassDefinition(
            name: TempName(name: r'PokemonPartsMixin'),
            properties: [
              ClassProperty(
                  type: r'String',
                  name: VariableName(name: r'number'),
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: r'String',
                  name: VariableName(name: r'name'),
                  isNonNull: false,
                  isResolveType: false)
            ])
      ],
      generateHelpers: false,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

mixin PokemonMixin {
  String id;
  PokemonMixin$Evolution evolution;
}
mixin PokemonNameMixin {
  String name;
}
mixin PokemonPartsMixin {
  String number;
  String name;
}

@JsonSerializable(explicitToJson: true)
class PokemonData$Query$Pokemon
    with EquatableMixin, PokemonMixin, PokemonPartsMixin {
  PokemonData$Query$Pokemon();

  factory PokemonData$Query$Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonData$Query$PokemonFromJson(json);

  @override
  List<Object> get props => [id, evolution, number, name];
  Map<String, dynamic> toJson() => _$PokemonData$Query$PokemonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PokemonData$Query with EquatableMixin {
  PokemonData$Query();

  factory PokemonData$Query.fromJson(Map<String, dynamic> json) =>
      _$PokemonData$QueryFromJson(json);

  PokemonData$Query$Pokemon pokemon;

  @override
  List<Object> get props => [pokemon];
  Map<String, dynamic> toJson() => _$PokemonData$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PokemonMixin$Evolution with EquatableMixin, PokemonNameMixin {
  PokemonMixin$Evolution();

  factory PokemonMixin$Evolution.fromJson(Map<String, dynamic> json) =>
      _$PokemonMixin$EvolutionFromJson(json);

  @override
  List<Object> get props => [name];
  Map<String, dynamic> toJson() => _$PokemonMixin$EvolutionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AllPokemonsData$Query$AllPokemons
    with EquatableMixin, PokemonMixin, PokemonPartsMixin {
  AllPokemonsData$Query$AllPokemons();

  factory AllPokemonsData$Query$AllPokemons.fromJson(
          Map<String, dynamic> json) =>
      _$AllPokemonsData$Query$AllPokemonsFromJson(json);

  @override
  List<Object> get props => [id, evolution, number, name];
  Map<String, dynamic> toJson() =>
      _$AllPokemonsData$Query$AllPokemonsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AllPokemonsData$Query with EquatableMixin {
  AllPokemonsData$Query();

  factory AllPokemonsData$Query.fromJson(Map<String, dynamic> json) =>
      _$AllPokemonsData$QueryFromJson(json);

  List<AllPokemonsData$Query$AllPokemons> allPokemons;

  @override
  List<Object> get props => [allPokemons];
  Map<String, dynamic> toJson() => _$AllPokemonsData$QueryToJson(this);
}
''';
