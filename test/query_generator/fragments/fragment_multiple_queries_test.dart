import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On fragments', () {
    test(
      'One fragment with multiple queries per file',
      () async => testGenerator(
        query: r'''
          query getPokemon($name: String!) {
            pokemon(name: $name) {
              ...pokemonFragment
            }
          }
          
          query getAllPokemons($first: Int!) {
            pokemons(first: $first) {
              ...pokemonFragment
            }
          }
        ''',
        schema: r'''
         schema {
            query: Query
          }

          type Attack {
            name: String
            type: String
            damage: Int
          }
          
          type Pokemon {
            id: ID!
            number: String
            name: String
            weight: PokemonDimension
            height: PokemonDimension
            classification: String
            types: [String]
            resistant: [String]
            attacks: PokemonAttack
            weaknesses: [String]
            fleeRate: Float
            maxCP: Int
            evolutions: [Pokemon]
            evolutionRequirements: PokemonEvolutionRequirement
            maxHP: Int
            image: String
          }
          
          type PokemonAttack {
            fast: [Attack]
            special: [Attack]
          }
          
          type PokemonDimension {
            minimum: String
            maximum: String
          }
          
          type PokemonEvolutionRequirement {
            amount: Int
            name: String
          }
          
          type Query {
            pokemons(first: Int!): [Pokemon]
            pokemon(id: String, name: String): Pokemon
          }

        ''',
        builderOptionsMap: {'fragments_glob': '**.frag'},
        sourceAssetsMap: {'a|fragment.frag': fragmentsString},
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        generateHelpers: true,
      ),
    );
  });
}

const fragmentsString = '''
  fragment pokemonFragment on Pokemon {
    number
    name
  }
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'GetPokemon$_Query'),
      operationName: r'getPokemon',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'GetPokemon$_Query$_Pokemon'),
            mixins: [FragmentName(name: r'PokemonFragmentMixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'GetPokemon$_Query'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'GetPokemon$_Query$_Pokemon'),
                  name: ClassPropertyName(name: r'pokemon'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        FragmentClassDefinition(
            name: FragmentName(name: r'PokemonFragmentMixin'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r'number'),
                  isResolveType: false),
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r'name'),
                  isResolveType: false)
            ])
      ],
      inputs: [
        QueryInput(
            type: DartTypeName(name: r'String', isNonNull: true),
            name: QueryInputName(name: r'name'))
      ],
      generateHelpers: true,
      suffix: r'Query'),
  QueryDefinition(
      name: QueryName(name: r'GetAllPokemons$_Query'),
      operationName: r'getAllPokemons',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'GetAllPokemons$_Query$_Pokemon'),
            mixins: [FragmentName(name: r'PokemonFragmentMixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'GetAllPokemons$_Query'),
            properties: [
              ClassProperty(
                  type: ListOfTypeName(
                      typeName:
                          TypeName(name: r'GetAllPokemons$_Query$_Pokemon'),
                      isNonNull: false),
                  name: ClassPropertyName(name: r'pokemons'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        FragmentClassDefinition(
            name: FragmentName(name: r'PokemonFragmentMixin'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r'number'),
                  isResolveType: false),
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r'name'),
                  isResolveType: false)
            ])
      ],
      inputs: [
        QueryInput(
            type: DartTypeName(name: r'int', isNonNull: true),
            name: QueryInputName(name: r'first'))
      ],
      generateHelpers: true,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

mixin PokemonFragmentMixin {
  String? number;
  String? name;
}

@JsonSerializable(explicitToJson: true)
class GetPokemon$Query$Pokemon extends JsonSerializable
    with EquatableMixin, PokemonFragmentMixin {
  GetPokemon$Query$Pokemon();

  factory GetPokemon$Query$Pokemon.fromJson(Map<String, dynamic> json) =>
      _$GetPokemon$Query$PokemonFromJson(json);

  @override
  List<Object?> get props => [number, name];
  @override
  Map<String, dynamic> toJson() => _$GetPokemon$Query$PokemonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetPokemon$Query extends JsonSerializable with EquatableMixin {
  GetPokemon$Query();

  factory GetPokemon$Query.fromJson(Map<String, dynamic> json) =>
      _$GetPokemon$QueryFromJson(json);

  GetPokemon$Query$Pokemon? pokemon;

  @override
  List<Object?> get props => [pokemon];
  @override
  Map<String, dynamic> toJson() => _$GetPokemon$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetAllPokemons$Query$Pokemon extends JsonSerializable
    with EquatableMixin, PokemonFragmentMixin {
  GetAllPokemons$Query$Pokemon();

  factory GetAllPokemons$Query$Pokemon.fromJson(Map<String, dynamic> json) =>
      _$GetAllPokemons$Query$PokemonFromJson(json);

  @override
  List<Object?> get props => [number, name];
  @override
  Map<String, dynamic> toJson() => _$GetAllPokemons$Query$PokemonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetAllPokemons$Query extends JsonSerializable with EquatableMixin {
  GetAllPokemons$Query();

  factory GetAllPokemons$Query.fromJson(Map<String, dynamic> json) =>
      _$GetAllPokemons$QueryFromJson(json);

  List<GetAllPokemons$Query$Pokemon?>? pokemons;

  @override
  List<Object?> get props => [pokemons];
  @override
  Map<String, dynamic> toJson() => _$GetAllPokemons$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetPokemonArguments extends JsonSerializable with EquatableMixin {
  GetPokemonArguments({required this.name});

  @override
  factory GetPokemonArguments.fromJson(Map<String, dynamic> json) =>
      _$GetPokemonArgumentsFromJson(json);

  late String name;

  @override
  List<Object?> get props => [name];
  @override
  Map<String, dynamic> toJson() => _$GetPokemonArgumentsToJson(this);
}

final GET_POKEMON_QUERY_DOCUMENT_OPERATION_NAME = 'getPokemon';
final GET_POKEMON_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'getPokemon'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'name')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'pokemon'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'name'),
                  value: VariableNode(name: NameNode(value: 'name')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'pokemonFragment'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'pokemonFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'Pokemon'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'number'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class GetPokemonQuery
    extends GraphQLQuery<GetPokemon$Query, GetPokemonArguments> {
  GetPokemonQuery({required this.variables});

  @override
  final DocumentNode document = GET_POKEMON_QUERY_DOCUMENT;

  @override
  final String operationName = GET_POKEMON_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  final GetPokemonArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  GetPokemon$Query parse(Map<String, dynamic> json) =>
      GetPokemon$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class GetAllPokemonsArguments extends JsonSerializable with EquatableMixin {
  GetAllPokemonsArguments({required this.first});

  @override
  factory GetAllPokemonsArguments.fromJson(Map<String, dynamic> json) =>
      _$GetAllPokemonsArgumentsFromJson(json);

  late int first;

  @override
  List<Object?> get props => [first];
  @override
  Map<String, dynamic> toJson() => _$GetAllPokemonsArgumentsToJson(this);
}

final GET_ALL_POKEMONS_QUERY_DOCUMENT_OPERATION_NAME = 'getAllPokemons';
final GET_ALL_POKEMONS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'getAllPokemons'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'first')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'pokemons'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'first'),
                  value: VariableNode(name: NameNode(value: 'first')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'pokemonFragment'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'pokemonFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'Pokemon'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'number'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class GetAllPokemonsQuery
    extends GraphQLQuery<GetAllPokemons$Query, GetAllPokemonsArguments> {
  GetAllPokemonsQuery({required this.variables});

  @override
  final DocumentNode document = GET_ALL_POKEMONS_QUERY_DOCUMENT;

  @override
  final String operationName = GET_ALL_POKEMONS_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  final GetAllPokemonsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  GetAllPokemons$Query parse(Map<String, dynamic> json) =>
      GetAllPokemons$Query.fromJson(json);
}
''';
