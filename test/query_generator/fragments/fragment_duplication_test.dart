// @dart = 2.8

import 'package:artemis/generator/data/data.dart';
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
      name: QueryName(name: r'PokemonData$_Query'),
      operationName: r'PokemonData',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'PokemonData$_Query$_pokemon'),
            mixins: [
              FragmentName(name: r'PokemonMixin'),
              FragmentName(name: r'PokemonPartsMixin')
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'PokemonData$_Query'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'PokemonData$_Query$_pokemon'),
                  name: ClassPropertyName(name: r'pokemon'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'PokemonMixin$_evolution'),
            mixins: [FragmentName(name: r'PokemonNameMixin')],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        FragmentClassDefinition(
            name: FragmentName(name: r'PokemonMixin'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'id'),
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'PokemonMixin$_evolution'),
                  name: ClassPropertyName(name: r'evolution'),
                  isNonNull: false,
                  isResolveType: false)
            ]),
        FragmentClassDefinition(
            name: FragmentName(name: r'PokemonNameMixin'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'name'),
                  isNonNull: false,
                  isResolveType: false)
            ]),
        FragmentClassDefinition(
            name: FragmentName(name: r'PokemonPartsMixin'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'number'),
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'name'),
                  isNonNull: false,
                  isResolveType: false)
            ])
      ],
      generateHelpers: false,
      suffix: r'Query'),
  QueryDefinition(
      name: QueryName(name: r'AllPokemonsData$_Query'),
      operationName: r'AllPokemonsData',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'AllPokemonsData$_Query$_allPokemons'),
            mixins: [
              FragmentName(name: r'PokemonMixin'),
              FragmentName(name: r'PokemonPartsMixin')
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'AllPokemonsData$_Query'),
            properties: [
              ClassProperty(
                  type: TypeName(
                      name: r'List<AllPokemonsData$Query$AllPokemons>'),
                  name: ClassPropertyName(name: r'allPokemons'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'PokemonMixin$_evolution'),
            mixins: [FragmentName(name: r'PokemonNameMixin')],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        FragmentClassDefinition(
            name: FragmentName(name: r'PokemonMixin'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'id'),
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'PokemonMixin$_evolution'),
                  name: ClassPropertyName(name: r'evolution'),
                  isNonNull: false,
                  isResolveType: false)
            ]),
        FragmentClassDefinition(
            name: FragmentName(name: r'PokemonNameMixin'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'name'),
                  isNonNull: false,
                  isResolveType: false)
            ]),
        FragmentClassDefinition(
            name: FragmentName(name: r'PokemonPartsMixin'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'number'),
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'name'),
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
