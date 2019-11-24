// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:graphbrainz_example/coercers.dart';
part 'queries.g.dart';

mixin AllAlbumsMixin {
  ArtistSummaryAlbums albums;
}

@JsonSerializable(explicitToJson: true)
class ArtistSummary with EquatableMixin {
  ArtistSummary();

  factory ArtistSummary.fromJson(Map<String, dynamic> json) =>
      _$ArtistSummaryFromJson(json);

  ArtistSummaryLookupQuery lookup;

  @override
  List<Object> get props => [lookup];
  Map<String, dynamic> toJson() => _$ArtistSummaryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ArtistSummaryLookupQuery with EquatableMixin {
  ArtistSummaryLookupQuery();

  factory ArtistSummaryLookupQuery.fromJson(Map<String, dynamic> json) =>
      _$ArtistSummaryLookupQueryFromJson(json);

  ArtistSummaryArtist artist;

  @override
  List<Object> get props => [artist];
  Map<String, dynamic> toJson() => _$ArtistSummaryLookupQueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ArtistSummaryArtist
    with EquatableMixin, AllAlbumsMixin
    implements ArtistSummaryNode, ArtistSummaryEntity {
  ArtistSummaryArtist();

  factory ArtistSummaryArtist.fromJson(Map<String, dynamic> json) =>
      _$ArtistSummaryArtistFromJson(json);

  @override
  String mbid;

  String name;

  ArtistSummaryLifeSpan lifeSpan;

  ArtistSummarySpotifyArtist spotify;

  @override
  @JsonKey(name: '__typename')
  String resolveType;

  @override
  List<Object> get props =>
      [albums, mbid, name, lifeSpan, spotify, resolveType];
  Map<String, dynamic> toJson() => _$ArtistSummaryArtistToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ArtistSummaryAlbums with EquatableMixin {
  ArtistSummaryAlbums();

  factory ArtistSummaryAlbums.fromJson(Map<String, dynamic> json) =>
      _$ArtistSummaryAlbumsFromJson(json);

  List<ArtistSummaryRelease> nodes;

  @override
  List<Object> get props => [nodes];
  Map<String, dynamic> toJson() => _$ArtistSummaryAlbumsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ArtistSummaryRelease
    with EquatableMixin
    implements ArtistSummaryNode, ArtistSummaryEntity {
  ArtistSummaryRelease();

  factory ArtistSummaryRelease.fromJson(Map<String, dynamic> json) =>
      _$ArtistSummaryReleaseFromJson(json);

  @override
  String mbid;

  String title;

  @JsonKey(
      fromJson: fromGraphQLDateToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDate)
  DateTime date;

  ArtistSummaryReleaseStatus status;

  @override
  @JsonKey(name: '__typename')
  String resolveType;

  @override
  List<Object> get props => [mbid, title, date, status, resolveType];
  Map<String, dynamic> toJson() => _$ArtistSummaryReleaseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ArtistSummaryNode with EquatableMixin {
  ArtistSummaryNode();

  factory ArtistSummaryNode.fromJson(Map<String, dynamic> json) =>
      _$ArtistSummaryNodeFromJson(json);

  @JsonKey(name: '__typename')
  String resolveType;

  @override
  List<Object> get props => [resolveType];
  Map<String, dynamic> toJson() => _$ArtistSummaryNodeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ArtistSummaryEntity with EquatableMixin {
  ArtistSummaryEntity();

  factory ArtistSummaryEntity.fromJson(Map<String, dynamic> json) =>
      _$ArtistSummaryEntityFromJson(json);

  String mbid;

  @JsonKey(name: '__typename')
  String resolveType;

  @override
  List<Object> get props => [mbid, resolveType];
  Map<String, dynamic> toJson() => _$ArtistSummaryEntityToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ArtistSummaryLifeSpan with EquatableMixin {
  ArtistSummaryLifeSpan();

  factory ArtistSummaryLifeSpan.fromJson(Map<String, dynamic> json) =>
      _$ArtistSummaryLifeSpanFromJson(json);

  @JsonKey(
      fromJson: fromGraphQLDateToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDate)
  DateTime begin;

  @override
  List<Object> get props => [begin];
  Map<String, dynamic> toJson() => _$ArtistSummaryLifeSpanToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ArtistSummarySpotifyArtist with EquatableMixin {
  ArtistSummarySpotifyArtist();

  factory ArtistSummarySpotifyArtist.fromJson(Map<String, dynamic> json) =>
      _$ArtistSummarySpotifyArtistFromJson(json);

  String href;

  @override
  List<Object> get props => [href];
  Map<String, dynamic> toJson() => _$ArtistSummarySpotifyArtistToJson(this);
}

enum ArtistSummaryReleaseStatus {
  OFFICIAL,
  PROMOTION,
  BOOTLEG,
  PSEUDORELEASE,
}

@JsonSerializable(explicitToJson: true)
class ArtistSummaryArguments extends JsonSerializable with EquatableMixin {
  ArtistSummaryArguments({this.mbid});

  factory ArtistSummaryArguments.fromJson(Map<String, dynamic> json) =>
      _$ArtistSummaryArgumentsFromJson(json);

  final String mbid;

  @override
  List<Object> get props => [mbid];
  Map<String, dynamic> toJson() => _$ArtistSummaryArgumentsToJson(this);
}

class ArtistSummaryQuery
    extends GraphQLQuery<ArtistSummary, ArtistSummaryArguments> {
  ArtistSummaryQuery({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'artist_summary'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'mbid')),
              type:
                  NamedTypeNode(name: NameNode(value: 'MBID'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'lookup'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'artist'),
                    alias: null,
                    arguments: [
                      ArgumentNode(
                          name: NameNode(value: 'mbid'),
                          value: VariableNode(name: NameNode(value: 'mbid')))
                    ],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                          name: NameNode(value: 'mbid'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null),
                      FieldNode(
                          name: NameNode(value: 'name'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null),
                      FieldNode(
                          name: NameNode(value: 'lifeSpan'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: SelectionSetNode(selections: [
                            FieldNode(
                                name: NameNode(value: 'begin'),
                                alias: null,
                                arguments: [],
                                directives: [],
                                selectionSet: null)
                          ])),
                      FieldNode(
                          name: NameNode(value: 'spotify'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: SelectionSetNode(selections: [
                            FieldNode(
                                name: NameNode(value: 'href'),
                                alias: null,
                                arguments: [],
                                directives: [],
                                selectionSet: null)
                          ])),
                      FragmentSpreadNode(
                          name: NameNode(value: 'all_albums'), directives: [])
                    ]))
              ]))
        ])),
    FragmentDefinitionNode(
        name: NameNode(value: 'all_albums'),
        typeCondition: TypeConditionNode(
            on: NamedTypeNode(
                name: NameNode(value: 'Artist'), isNonNull: false)),
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'releases'),
              alias: NameNode(value: 'albums'),
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'type'),
                    value: ListValueNode(values: [
                      EnumValueNode(name: NameNode(value: 'ALBUM'))
                    ]))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'nodes'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                          name: NameNode(value: 'mbid'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null),
                      FieldNode(
                          name: NameNode(value: 'title'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null),
                      FieldNode(
                          name: NameNode(value: 'date'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null),
                      FieldNode(
                          name: NameNode(value: 'status'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null)
                    ]))
              ]))
        ]))
  ]);

  @override
  final String operationName = 'artist_summary';

  @override
  final ArtistSummaryArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  ArtistSummary parse(Map<String, dynamic> json) =>
      ArtistSummary.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class EdSheeran with EquatableMixin {
  EdSheeran();

  factory EdSheeran.fromJson(Map<String, dynamic> json) =>
      _$EdSheeranFromJson(json);

  EdSheeranNode node;

  @override
  List<Object> get props => [node];
  Map<String, dynamic> toJson() => _$EdSheeranToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EdSheeranNode with EquatableMixin {
  EdSheeranNode();

  factory EdSheeranNode.fromJson(Map<String, dynamic> json) {
    switch (json['__typename'].toString()) {
      case 'EdSheeranArtist':
        return EdSheeranArtist.fromJson(json);
      default:
    }
    return _$EdSheeranNodeFromJson(json);
  }

  String id;

  @JsonKey(name: '__typename')
  String resolveType;

  @override
  List<Object> get props => [id, resolveType];
  Map<String, dynamic> toJson() {
    switch (resolveType) {
      case 'EdSheeranArtist':
        return (this as EdSheeranArtist).toJson();
      default:
    }
    return _$EdSheeranNodeToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class EdSheeranArtist
    with EquatableMixin
    implements EdSheeranNode, EdSheeranEntity {
  EdSheeranArtist();

  factory EdSheeranArtist.fromJson(Map<String, dynamic> json) =>
      _$EdSheeranArtistFromJson(json);

  String mbid;

  String name;

  EdSheeranLifeSpan lifeSpan;

  EdSheeranSpotifyArtist spotify;

  @override
  @JsonKey(name: '__typename')
  String resolveType;

  @override
  String id;

  @override
  List<Object> get props => [mbid, name, lifeSpan, spotify, resolveType, id];
  Map<String, dynamic> toJson() => _$EdSheeranArtistToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EdSheeranLifeSpan with EquatableMixin {
  EdSheeranLifeSpan();

  factory EdSheeranLifeSpan.fromJson(Map<String, dynamic> json) =>
      _$EdSheeranLifeSpanFromJson(json);

  @JsonKey(
      fromJson: fromGraphQLDateToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDate)
  DateTime begin;

  @override
  List<Object> get props => [begin];
  Map<String, dynamic> toJson() => _$EdSheeranLifeSpanToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EdSheeranSpotifyArtist with EquatableMixin {
  EdSheeranSpotifyArtist();

  factory EdSheeranSpotifyArtist.fromJson(Map<String, dynamic> json) =>
      _$EdSheeranSpotifyArtistFromJson(json);

  String href;

  @override
  List<Object> get props => [href];
  Map<String, dynamic> toJson() => _$EdSheeranSpotifyArtistToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EdSheeranEntity with EquatableMixin {
  EdSheeranEntity();

  factory EdSheeranEntity.fromJson(Map<String, dynamic> json) =>
      _$EdSheeranEntityFromJson(json);

  String mbid;

  @JsonKey(name: '__typename')
  String resolveType;

  @override
  List<Object> get props => [mbid, resolveType];
  Map<String, dynamic> toJson() => _$EdSheeranEntityToJson(this);
}

class EdSheeranQuery extends GraphQLQuery<EdSheeran, JsonSerializable> {
  EdSheeranQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'ed_sheeran'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'node'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'id'),
                    value: StringValueNode(
                        value:
                            'QXJ0aXN0OmI4YTdjNTFmLTM2MmMtNGRjYi1hMjU5LWJjNmUwMDk1ZjBhNg==',
                        isBlock: false))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: '__typename'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                InlineFragmentNode(
                    typeCondition: TypeConditionNode(
                        on: NamedTypeNode(
                            name: NameNode(value: 'Artist'), isNonNull: false)),
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                          name: NameNode(value: 'mbid'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null),
                      FieldNode(
                          name: NameNode(value: 'name'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null),
                      FieldNode(
                          name: NameNode(value: 'lifeSpan'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: SelectionSetNode(selections: [
                            FieldNode(
                                name: NameNode(value: 'begin'),
                                alias: null,
                                arguments: [],
                                directives: [],
                                selectionSet: null)
                          ])),
                      FieldNode(
                          name: NameNode(value: 'spotify'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: SelectionSetNode(selections: [
                            FieldNode(
                                name: NameNode(value: 'href'),
                                alias: null,
                                arguments: [],
                                directives: [],
                                selectionSet: null)
                          ]))
                    ]))
              ]))
        ]))
  ]);

  @override
  final String operationName = 'ed_sheeran';

  @override
  List<Object> get props => [document, operationName];
  @override
  EdSheeran parse(Map<String, dynamic> json) => EdSheeran.fromJson(json);
}
