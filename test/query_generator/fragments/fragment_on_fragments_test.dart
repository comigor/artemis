import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On fragment spreads on other fragments', () {
    test(
      'Properties will be merged',
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
            number: String
            evolution: Pokemon
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        builderOptionsMap: {'fragments_glob': '**.frag'},
        sourceAssetsMap: {'a|fragment.frag': fragmentsString},
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
  {
      pokemon(name: "Pikachu") {
        ...Pokemon
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
            name: ClassName(name: r'Query$_Query$_Pokemon'),
            mixins: [
              FragmentName(name: r'PokemonMixin'),
              FragmentName(name: r'PokemonPartsMixin')
            ],
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
            name: ClassName(name: r'PokemonMixin$_Pokemon'),
            mixins: [FragmentName(name: r'PokemonNameMixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        FragmentClassDefinition(
            name: FragmentName(name: r'PokemonMixin'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'id'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'PokemonMixin$_Pokemon'),
                  name: ClassPropertyName(name: r'evolution'),
                  isResolveType: false)
            ]),
        FragmentClassDefinition(
            name: FragmentName(name: r'PokemonNameMixin'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'name'),
                  isResolveType: false)
            ]),
        FragmentClassDefinition(
            name: FragmentName(name: r'PokemonPartsMixin'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'number'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'name'),
                  isResolveType: false)
            ])
      ],
      generateHelpers: false,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

mixin PokemonMixin {
  late String id;
  PokemonMixin$Pokemon? evolution;
}
mixin PokemonNameMixin {
  String? name;
}
mixin PokemonPartsMixin {
  String? number;
  String? name;
}

@JsonSerializable(explicitToJson: true)
class Query$Query$Pokemon extends JsonSerializable
    with EquatableMixin, PokemonMixin, PokemonPartsMixin {
  Query$Query$Pokemon();

  factory Query$Query$Pokemon.fromJson(Map<String, dynamic> json) =>
      _$Query$Query$PokemonFromJson(json);

  @override
  List<Object?> get props => [id, evolution, number, name];
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
  Map<String, dynamic> toJson() => _$Query$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PokemonMixin$Pokemon extends JsonSerializable
    with EquatableMixin, PokemonNameMixin {
  PokemonMixin$Pokemon();

  factory PokemonMixin$Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonMixin$PokemonFromJson(json);

  @override
  List<Object?> get props => [name];
  Map<String, dynamic> toJson() => _$PokemonMixin$PokemonToJson(this);
}
''';
