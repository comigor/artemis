import 'package:artemis/generator/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('[Fragment generation]', () {
    test(
      'Extracting',
      () async => testGenerator(
        query: queryString,
        schema: r'''
          schema {
            query: Query
          }

          type Query {
            pokemon(id: String, name: String): Pokemon
          }

          type Pokemon {
            id: String!
            name: String
            evolutions: [Pokemon]
            attacks: PokemonAttack
            weight: PokemonDimension
          }
          
          type PokemonAttack {
            special: [Attack]
          }
          
          type PokemonDimension {
            minimum: String
          }
          type Attack {
            name: String
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        builderOptionsMap: {'fragments_glob': '**.frag'},
        sourceAssetsMap: {'a|fragment.frag': fragmentsString},
        generateHelpers: true,
      ),
    );
  });
}

const fragmentsString = '''
  fragment Pokemon on Pokemon {
    id
    weight {
      ...weight
    }
    attacks {
      ...pokemonAttack
    }
  }
  
  fragment weight on PokemonDimension { 
    minimum 
  }
  
  fragment pokemonAttack on PokemonAttack {
    special { 
      ...attack 
    }
  }
  
  fragment attack on Attack { 
    name 
  }
''';

const queryString = '''
  {
      pokemon(name: "Pikachu") {
        ...Pokemon
        evolutions {
          ...Pokemon
        }
      }
  }
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      queryName: r'query',
      queryType: ClassName(name: r'Query$Query'),
      classes: [
        ClassDefinition(
            name: ClassName(name: r'Query$Query$Pokemon$Pokemon'),
            mixins: [r'PokemonMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Query$Query$Pokemon'),
            properties: [
              ClassProperty(
                  type: ClassName(name: r'List<Query$Query$Pokemon$Pokemon>'),
                  name: VariableName(name: r'evolutions'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            mixins: [r'PokemonMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Query$Query'),
            properties: [
              ClassProperty(
                  type: ClassName(name: r'Query$Query$Pokemon'),
                  name: VariableName(name: r'pokemon'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'PokemonMixin$PokemonDimension'),
            mixins: [r'WeightMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'PokemonMixin$PokemonAttack'),
            mixins: [r'PokemonAttackMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        FragmentClassDefinition(
            name: ClassName(name: r'PokemonMixin'),
            properties: [
              ClassProperty(
                  type: ClassName(name: r'String'),
                  name: VariableName(name: r'id'),
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: ClassName(name: r'PokemonMixin$PokemonDimension'),
                  name: VariableName(name: r'weight'),
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: ClassName(name: r'PokemonMixin$PokemonAttack'),
                  name: VariableName(name: r'attacks'),
                  isNonNull: false,
                  isResolveType: false)
            ]),
        FragmentClassDefinition(
            name: ClassName(name: r'WeightMixin'),
            properties: [
              ClassProperty(
                  type: ClassName(name: r'String'),
                  name: VariableName(name: r'minimum'),
                  isNonNull: false,
                  isResolveType: false)
            ]),
        ClassDefinition(
            name: ClassName(name: r'PokemonAttackMixin$Attack'),
            mixins: [r'AttackMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        FragmentClassDefinition(
            name: ClassName(name: r'PokemonAttackMixin'),
            properties: [
              ClassProperty(
                  type: ClassName(name: r'List<PokemonAttackMixin$Attack>'),
                  name: VariableName(name: r'special'),
                  isNonNull: false,
                  isResolveType: false)
            ]),
        FragmentClassDefinition(
            name: ClassName(name: r'AttackMixin'),
            properties: [
              ClassProperty(
                  type: ClassName(name: r'String'),
                  name: VariableName(name: r'name'),
                  isNonNull: false,
                  isResolveType: false)
            ])
      ],
      generateHelpers: true,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

mixin PokemonMixin {
  String id;
  PokemonMixin$PokemonDimension weight;
  PokemonMixin$PokemonAttack attacks;
}
mixin WeightMixin {
  String minimum;
}
mixin PokemonAttackMixin {
  List<PokemonAttackMixin$Attack> special;
}
mixin AttackMixin {
  String name;
}

@JsonSerializable(explicitToJson: true)
class Query$Query$Pokemon$Pokemon with EquatableMixin, PokemonMixin {
  Query$Query$Pokemon$Pokemon();

  factory Query$Query$Pokemon$Pokemon.fromJson(Map<String, dynamic> json) =>
      _$Query$Query$Pokemon$PokemonFromJson(json);

  @override
  List<Object> get props => [id, weight, attacks];
  Map<String, dynamic> toJson() => _$Query$Query$Pokemon$PokemonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Query$Query$Pokemon with EquatableMixin, PokemonMixin {
  Query$Query$Pokemon();

  factory Query$Query$Pokemon.fromJson(Map<String, dynamic> json) =>
      _$Query$Query$PokemonFromJson(json);

  List<Query$Query$Pokemon$Pokemon> evolutions;

  @override
  List<Object> get props => [id, weight, attacks, evolutions];
  Map<String, dynamic> toJson() => _$Query$Query$PokemonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Query$Query with EquatableMixin {
  Query$Query();

  factory Query$Query.fromJson(Map<String, dynamic> json) =>
      _$Query$QueryFromJson(json);

  Query$Query$Pokemon pokemon;

  @override
  List<Object> get props => [pokemon];
  Map<String, dynamic> toJson() => _$Query$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PokemonMixin$PokemonDimension with EquatableMixin, WeightMixin {
  PokemonMixin$PokemonDimension();

  factory PokemonMixin$PokemonDimension.fromJson(Map<String, dynamic> json) =>
      _$PokemonMixin$PokemonDimensionFromJson(json);

  @override
  List<Object> get props => [minimum];
  Map<String, dynamic> toJson() => _$PokemonMixin$PokemonDimensionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PokemonMixin$PokemonAttack with EquatableMixin, PokemonAttackMixin {
  PokemonMixin$PokemonAttack();

  factory PokemonMixin$PokemonAttack.fromJson(Map<String, dynamic> json) =>
      _$PokemonMixin$PokemonAttackFromJson(json);

  @override
  List<Object> get props => [special];
  Map<String, dynamic> toJson() => _$PokemonMixin$PokemonAttackToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PokemonAttackMixin$Attack with EquatableMixin, AttackMixin {
  PokemonAttackMixin$Attack();

  factory PokemonAttackMixin$Attack.fromJson(Map<String, dynamic> json) =>
      _$PokemonAttackMixin$AttackFromJson(json);

  @override
  List<Object> get props => [name];
  Map<String, dynamic> toJson() => _$PokemonAttackMixin$AttackToJson(this);
}

class QueryQuery extends GraphQLQuery<Query$Query, JsonSerializable> {
  QueryQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: null,
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'pokemon'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'name'),
                    value: StringValueNode(value: 'Pikachu', isBlock: false))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FragmentSpreadNode(
                    name: NameNode(value: 'Pokemon'), directives: []),
                FieldNode(
                    name: NameNode(value: 'evolutions'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FragmentSpreadNode(
                          name: NameNode(value: 'Pokemon'), directives: [])
                    ]))
              ]))
        ])),
    FragmentDefinitionNode(
        name: NameNode(value: 'Pokemon'),
        typeCondition: TypeConditionNode(
            on: NamedTypeNode(
                name: NameNode(value: 'Pokemon'), isNonNull: false)),
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'id'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'weight'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FragmentSpreadNode(
                    name: NameNode(value: 'weight'), directives: [])
              ])),
          FieldNode(
              name: NameNode(value: 'attacks'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FragmentSpreadNode(
                    name: NameNode(value: 'pokemonAttack'), directives: [])
              ]))
        ])),
    FragmentDefinitionNode(
        name: NameNode(value: 'weight'),
        typeCondition: TypeConditionNode(
            on: NamedTypeNode(
                name: NameNode(value: 'PokemonDimension'), isNonNull: false)),
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'minimum'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null)
        ])),
    FragmentDefinitionNode(
        name: NameNode(value: 'pokemonAttack'),
        typeCondition: TypeConditionNode(
            on: NamedTypeNode(
                name: NameNode(value: 'PokemonAttack'), isNonNull: false)),
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'special'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FragmentSpreadNode(
                    name: NameNode(value: 'attack'), directives: [])
              ]))
        ])),
    FragmentDefinitionNode(
        name: NameNode(value: 'attack'),
        typeCondition: TypeConditionNode(
            on: NamedTypeNode(
                name: NameNode(value: 'Attack'), isNonNull: false)),
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'name'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null)
        ]))
  ]);

  @override
  final String operationName = 'query';

  @override
  List<Object> get props => [document, operationName];
  @override
  Query$Query parse(Map<String, dynamic> json) => Query$Query.fromJson(json);
}
''';
