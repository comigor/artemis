import 'package:artemis/generator/data/data.dart';
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
      name: QueryName(name: r'Query$_Query'),
      operationName: r'query',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'Query$_Query$_Pokemon$_Pokemon'),
            mixins: [FragmentName(name: r'PokemonMixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Query$_Query$_Pokemon'),
            properties: [
              ClassProperty(
                  type: ListOfTypeName(
                      typeName:
                          TypeName(name: r'Query$_Query$_Pokemon$_Pokemon'),
                      isNonNull: false),
                  name: ClassPropertyName(name: r'evolutions'),
                  isResolveType: false)
            ],
            mixins: [FragmentName(name: r'PokemonMixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Query$_Query'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'Query$_Query$_Pokemon'),
                  name: ClassPropertyName(name: r'pokemon'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'PokemonMixin$_PokemonDimension'),
            mixins: [FragmentName(name: r'WeightMixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'PokemonMixin$_PokemonAttack'),
            mixins: [FragmentName(name: r'PokemonAttackMixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        FragmentClassDefinition(
            name: FragmentName(name: r'PokemonMixin'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'id'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'PokemonMixin$_PokemonDimension'),
                  name: ClassPropertyName(name: r'weight'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'PokemonMixin$_PokemonAttack'),
                  name: ClassPropertyName(name: r'attacks'),
                  isResolveType: false)
            ]),
        FragmentClassDefinition(
            name: FragmentName(name: r'WeightMixin'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r'minimum'),
                  isResolveType: false)
            ]),
        ClassDefinition(
            name: ClassName(name: r'PokemonAttackMixin$_Attack'),
            mixins: [FragmentName(name: r'AttackMixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        FragmentClassDefinition(
            name: FragmentName(name: r'PokemonAttackMixin'),
            properties: [
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: TypeName(name: r'PokemonAttackMixin$_Attack'),
                      isNonNull: false),
                  name: ClassPropertyName(name: r'special'),
                  isResolveType: false)
            ]),
        FragmentClassDefinition(
            name: FragmentName(name: r'AttackMixin'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r'name'),
                  isResolveType: false)
            ])
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

mixin PokemonMixin {
  late String id;
  PokemonMixin$PokemonDimension? weight;
  PokemonMixin$PokemonAttack? attacks;
}
mixin WeightMixin {
  String? minimum;
}
mixin PokemonAttackMixin {
  List<PokemonAttackMixin$Attack?>? special;
}
mixin AttackMixin {
  String? name;
}

@JsonSerializable(explicitToJson: true)
class Query$Query$Pokemon$Pokemon extends JsonSerializable
    with EquatableMixin, PokemonMixin {
  Query$Query$Pokemon$Pokemon();

  factory Query$Query$Pokemon$Pokemon.fromJson(Map<String, dynamic> json) =>
      _$Query$Query$Pokemon$PokemonFromJson(json);

  @override
  List<Object?> get props => [id, weight, attacks];
  @override
  Map<String, dynamic> toJson() => _$Query$Query$Pokemon$PokemonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Query$Query$Pokemon extends JsonSerializable
    with EquatableMixin, PokemonMixin {
  Query$Query$Pokemon();

  factory Query$Query$Pokemon.fromJson(Map<String, dynamic> json) =>
      _$Query$Query$PokemonFromJson(json);

  List<Query$Query$Pokemon$Pokemon?>? evolutions;

  @override
  List<Object?> get props => [id, weight, attacks, evolutions];
  @override
  Map<String, dynamic> toJson() => _$Query$Query$PokemonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Query$Query extends JsonSerializable with EquatableMixin {
  Query$Query();

  factory Query$Query.fromJson(Map<String, dynamic> json) =>
      _$Query$QueryFromJson(json);

  Query$Query$Pokemon? pokemon;

  @override
  List<Object?> get props => [pokemon];
  @override
  Map<String, dynamic> toJson() => _$Query$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PokemonMixin$PokemonDimension extends JsonSerializable
    with EquatableMixin, WeightMixin {
  PokemonMixin$PokemonDimension();

  factory PokemonMixin$PokemonDimension.fromJson(Map<String, dynamic> json) =>
      _$PokemonMixin$PokemonDimensionFromJson(json);

  @override
  List<Object?> get props => [minimum];
  @override
  Map<String, dynamic> toJson() => _$PokemonMixin$PokemonDimensionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PokemonMixin$PokemonAttack extends JsonSerializable
    with EquatableMixin, PokemonAttackMixin {
  PokemonMixin$PokemonAttack();

  factory PokemonMixin$PokemonAttack.fromJson(Map<String, dynamic> json) =>
      _$PokemonMixin$PokemonAttackFromJson(json);

  @override
  List<Object?> get props => [special];
  @override
  Map<String, dynamic> toJson() => _$PokemonMixin$PokemonAttackToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PokemonAttackMixin$Attack extends JsonSerializable
    with EquatableMixin, AttackMixin {
  PokemonAttackMixin$Attack();

  factory PokemonAttackMixin$Attack.fromJson(Map<String, dynamic> json) =>
      _$PokemonAttackMixin$AttackFromJson(json);

  @override
  List<Object?> get props => [name];
  @override
  Map<String, dynamic> toJson() => _$PokemonAttackMixin$AttackToJson(this);
}

final QUERY_QUERY_DOCUMENT_OPERATION_NAME = 'query';
final QUERY_QUERY_DOCUMENT = DocumentNode(definitions: [
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
          on: NamedTypeNode(name: NameNode(value: 'Attack'), isNonNull: false)),
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

class QueryQuery extends GraphQLQuery<Query$Query, JsonSerializable> {
  QueryQuery();

  @override
  final DocumentNode document = QUERY_QUERY_DOCUMENT;

  @override
  final String operationName = QUERY_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  List<Object?> get props => [document, operationName];
  @override
  Query$Query parse(Map<String, dynamic> json) => Query$Query.fromJson(json);
}
''';
