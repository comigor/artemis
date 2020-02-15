import 'package:artemis/generator/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('[Fragment generation]', () {
    test(
      'Extracting',
      () async => testGenerator(
        query: queryString,
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        stringSchema: pokemonSchema,
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
      fragment weight on PokemonDimension { minimum }
      fragment pokemonAttack on PokemonAttack {
        special { ...attack }
      }
      fragment attack on Attack { name }
        ''';

const queryString = '''
      {
          pokemon(name: "Pikachu") {
            ...Pokemon
            evolutions {
              ...Pokemon
            }
          }
      }''';

final libraryDefinition = LibraryDefinition(basename: r'query', queries: [
  QueryDefinition(
      queryName: r'query',
      queryType: r'Query$Query',
      classes: [
        ClassDefinition(
            name: r'Query$Query$Pokemon$Pokemon',
            mixins: [r'Query$PokemonMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'Query$Query$Pokemon',
            properties: [
              ClassProperty(
                  type: r'List<Query$Query$Pokemon$Pokemon>',
                  name: r'evolutions',
                  isOverride: false,
                  isNonNull: false)
            ],
            mixins: [r'Query$PokemonMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'Query$Query',
            properties: [
              ClassProperty(
                  type: r'Query$Query$Pokemon',
                  name: r'pokemon',
                  isOverride: false,
                  isNonNull: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'Query$Query$Pokemon$PokemonDimension',
            mixins: [r'Query$WeightMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'Query$Query$Pokemon$PokemonAttack',
            mixins: [r'Query$PokemonAttackMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        FragmentClassDefinition(name: r'Query$PokemonMixin', properties: [
          ClassProperty(
              type: r'String', name: r'id', isOverride: false, isNonNull: true),
          ClassProperty(
              type: r'Query$Query$Pokemon$PokemonDimension',
              name: r'weight',
              isOverride: false,
              isNonNull: false),
          ClassProperty(
              type: r'Query$Query$Pokemon$PokemonAttack',
              name: r'attacks',
              isOverride: false,
              isNonNull: false)
        ]),
        FragmentClassDefinition(name: r'Query$WeightMixin', properties: [
          ClassProperty(
              type: r'String',
              name: r'minimum',
              isOverride: false,
              isNonNull: false)
        ]),
        ClassDefinition(
            name: r'Query$Query$PokemonAttack$Attack',
            mixins: [r'Query$AttackMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        FragmentClassDefinition(name: r'Query$PokemonAttackMixin', properties: [
          ClassProperty(
              type: r'List<Query$Query$PokemonAttack$Attack>',
              name: r'special',
              isOverride: false,
              isNonNull: false)
        ]),
        FragmentClassDefinition(name: r'Query$AttackMixin', properties: [
          ClassProperty(
              type: r'String',
              name: r'name',
              isOverride: false,
              isNonNull: false)
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
part 'query.g.dart';

mixin Query$PokemonMixin {
  String id;
  Query$Query$Pokemon$PokemonDimension weight;
  Query$Query$Pokemon$PokemonAttack attacks;
}
mixin Query$WeightMixin {
  String minimum;
}
mixin Query$PokemonAttackMixin {
  List<Query$Query$PokemonAttack$Attack> special;
}
mixin Query$AttackMixin {
  String name;
}

@JsonSerializable(explicitToJson: true)
class Query$Query$Pokemon$Pokemon with EquatableMixin, Query$PokemonMixin {
  Query$Query$Pokemon$Pokemon();

  factory Query$Query$Pokemon$Pokemon.fromJson(Map<String, dynamic> json) =>
      _$Query$Query$Pokemon$PokemonFromJson(json);

  @override
  List<Object> get props => [id, weight, attacks];
  Map<String, dynamic> toJson() => _$Query$Query$Pokemon$PokemonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Query$Query$Pokemon with EquatableMixin, Query$PokemonMixin {
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
class Query$Query$Pokemon$PokemonDimension
    with EquatableMixin, Query$WeightMixin {
  Query$Query$Pokemon$PokemonDimension();

  factory Query$Query$Pokemon$PokemonDimension.fromJson(
          Map<String, dynamic> json) =>
      _$Query$Query$Pokemon$PokemonDimensionFromJson(json);

  @override
  List<Object> get props => [minimum];
  Map<String, dynamic> toJson() =>
      _$Query$Query$Pokemon$PokemonDimensionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Query$Query$Pokemon$PokemonAttack
    with EquatableMixin, Query$PokemonAttackMixin {
  Query$Query$Pokemon$PokemonAttack();

  factory Query$Query$Pokemon$PokemonAttack.fromJson(
          Map<String, dynamic> json) =>
      _$Query$Query$Pokemon$PokemonAttackFromJson(json);

  @override
  List<Object> get props => [special];
  Map<String, dynamic> toJson() =>
      _$Query$Query$Pokemon$PokemonAttackToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Query$Query$PokemonAttack$Attack with EquatableMixin, Query$AttackMixin {
  Query$Query$PokemonAttack$Attack();

  factory Query$Query$PokemonAttack$Attack.fromJson(
          Map<String, dynamic> json) =>
      _$Query$Query$PokemonAttack$AttackFromJson(json);

  @override
  List<Object> get props => [name];
  Map<String, dynamic> toJson() =>
      _$Query$Query$PokemonAttack$AttackToJson(this);
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

const pokemonSchema = '''
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
