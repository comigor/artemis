import 'package:artemis/generator/data.dart';
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
      queryName: r'query',
      queryType: r'Query$Query',
      classes: [
        ClassDefinition(
            name: r'Query$Query$Pokemon',
            mixins: [r'PokemonMixin', r'PokemonPartsMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'Query$Query',
            properties: [
              ClassProperty(
                  type: r'Query$Query$Pokemon',
                  name: r'pokemon',
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'PokemonMixin$Pokemon',
            mixins: [r'PokemonNameMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        FragmentClassDefinition(name: r'PokemonMixin', properties: [
          ClassProperty(
              type: r'String',
              name: r'id',
              isNonNull: true,
              isResolveType: false),
          ClassProperty(
              type: r'PokemonMixin$Pokemon',
              name: r'evolution',
              isNonNull: false,
              isResolveType: false)
        ]),
        FragmentClassDefinition(name: r'PokemonNameMixin', properties: [
          ClassProperty(
              type: r'String',
              name: r'name',
              isNonNull: false,
              isResolveType: false)
        ]),
        FragmentClassDefinition(name: r'PokemonPartsMixin', properties: [
          ClassProperty(
              type: r'String',
              name: r'number',
              isNonNull: false,
              isResolveType: false),
          ClassProperty(
              type: r'String',
              name: r'name',
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
  PokemonMixin$Pokemon evolution;
}
mixin PokemonNameMixin {
  String name;
}
mixin PokemonPartsMixin {
  String number;
  String name;
}

@JsonSerializable(explicitToJson: true)
class Query$Query$Pokemon with EquatableMixin, PokemonMixin, PokemonPartsMixin {
  Query$Query$Pokemon();

  factory Query$Query$Pokemon.fromJson(Map<String, dynamic> json) =>
      _$Query$Query$PokemonFromJson(json);

  @override
  List<Object> get props => [id, evolution, number, name];
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
class PokemonMixin$Pokemon with EquatableMixin, PokemonNameMixin {
  PokemonMixin$Pokemon();

  factory PokemonMixin$Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonMixin$PokemonFromJson(json);

  @override
  List<Object> get props => [name];
  Map<String, dynamic> toJson() => _$PokemonMixin$PokemonToJson(this);
}
''';
