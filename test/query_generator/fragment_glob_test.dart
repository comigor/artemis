import 'package:artemis/builder.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:gql/ast.dart';
import 'package:test/test.dart';

import '../helpers.dart';

void main() {
  group('[Fragment generation]', () {
    test('Extracting', () async {
      final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
        'fragments_glob': '**.frag',
        'schema_mapping': [
          {
            'schema': 'pokemon.schema.json',
            'queries_glob': '**.graphql',
            'output': 'lib/query.dart',
          }
        ]
      }));

      anotherBuilder.onBuild = expectAsync1((definition) {
        expect(
            definition.queries.first.document,
            DocumentNode(definitions: [
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
                              value: StringValueNode(
                                  value: 'Pikachu', isBlock: false))
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
                                    name: NameNode(value: 'Pokemon'),
                                    directives: [])
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
                              name: NameNode(value: 'pokemonAttack'),
                              directives: [])
                        ]))
                  ])),
              FragmentDefinitionNode(
                  name: NameNode(value: 'weight'),
                  typeCondition: TypeConditionNode(
                      on: NamedTypeNode(
                          name: NameNode(value: 'PokemonDimension'),
                          isNonNull: false)),
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
                          name: NameNode(value: 'PokemonAttack'),
                          isNonNull: false)),
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
            ]));
      }, count: 1);

      await testBuilder(
        anotherBuilder,
        {
          'a|fragment.frag': '''
      fragment Pokemon on Pokemon {
            id
            weight {
              ...weight
            }
            attacks {
              ...pokemonAttack
            }
      }
      fragment weight on PokemonDimension { minimum }
      fragment pokemonAttack on PokemonAttack {
        special { ...attack }
      }
      fragment attack on Attack { name }
        ''',
          'a|pokemon.schema.json': pokemonSchema,
          'a|query.graphql': '''
      {
          pokemon(name: "Pikachu") {
            ...Pokemon
            evolutions {
              ...Pokemon
            }
          }
      }
        ''',
        },
        outputs: {
          'a|lib/query.dart': r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.g.dart';

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
class Query$Pokemon$Pokemon with EquatableMixin, PokemonMixin {
  Query$Pokemon$Pokemon();

  factory Query$Pokemon$Pokemon.fromJson(Map<String, dynamic> json) =>
      _$Query$Pokemon$PokemonFromJson(json);

  @override
  List<Object> get props => [id, weight, attacks];
  Map<String, dynamic> toJson() => _$Query$Pokemon$PokemonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Query$Pokemon with EquatableMixin, PokemonMixin {
  Query$Pokemon();

  factory Query$Pokemon.fromJson(Map<String, dynamic> json) =>
      _$Query$PokemonFromJson(json);

  List<Query$Pokemon$Pokemon> evolutions;

  @override
  List<Object> get props => [id, weight, attacks, evolutions];
  Map<String, dynamic> toJson() => _$Query$PokemonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Query with EquatableMixin {
  Query();

  factory Query.fromJson(Map<String, dynamic> json) => _$QueryFromJson(json);

  Query$Pokemon pokemon;

  @override
  List<Object> get props => [pokemon];
  Map<String, dynamic> toJson() => _$QueryToJson(this);
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

class QueryQuery extends GraphQLQuery<Query, JsonSerializable> {
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
  Query parse(Map<String, dynamic> json) => Query.fromJson(json);
}
'''
        },
        onLog: debug,
      );
    });
  });
}

const String pokemonSchema = '''
{
  "data": {
    "__schema": {
      "queryType": {
        "name": "Query"
      },
      "types": [
        {
          "kind": "OBJECT",
          "name": "Query",
          "fields": [
            {
              "name": "query",
              "type": {
                "kind": "OBJECT",
                "name": "Query"
              }
            },
            {
              "name": "pokemon",
              "args": [
                {
                  "name": "id",
                  "type": {
                    "kind": "SCALAR",
                    "name": "String"
                  }
                },
                {
                  "name": "name",
                  "type": {
                    "kind": "SCALAR",
                    "name": "String"
                  }
                }
              ],
              "type": {
                "kind": "OBJECT",
                "name": "Pokemon"
              }
            }
          ]
        },
        {
          "kind": "OBJECT",
          "name": "Pokemon",
          "fields": [
            {
              "name": "id",
              "type": {
                "kind": "NON_NULL",
                "ofType": {
                  "kind": "SCALAR",
                  "name": "ID"
                }
              }
            },
            {
              "name": "weight",
              "type": {
                "kind": "OBJECT",
                "name": "PokemonDimension"
              }
            },
            {
              "name": "attacks",
              "type": {
                "kind": "OBJECT",
                "name": "PokemonAttack"
              }
            },
            {
              "name": "evolutions",
              "type": {
                "kind": "LIST",
                "ofType": {
                  "kind": "OBJECT",
                  "name": "Pokemon"
                }
              }
            }
          ]
        },
        {
          "kind": "SCALAR",
          "name": "ID"
        },
        {
          "kind": "OBJECT",
          "name": "PokemonDimension",
          "fields": [
            {
              "name": "minimum",
              "type": {
                "kind": "SCALAR",
                "name": "String"
              }
            }
          ]
        },
        {
          "kind": "OBJECT",
          "name": "PokemonAttack",
          "fields": [
            {
              "name": "special",
              "type": {
                "kind": "LIST",
                "ofType": {
                  "kind": "OBJECT",
                  "name": "Attack"
                }
              }
            }
          ]
        },
        {
          "kind": "SCALAR",
          "name": "String"
        },
        {
          "kind": "OBJECT",
          "name": "Attack",
          "fields": [
            {
              "name": "name",
              "type": {
                "kind": "SCALAR",
                "name": "String"
              }
            }
          ]
        }
      ]
    }
  }
}
''';
