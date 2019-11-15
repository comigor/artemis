// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:graphbrainz_example/coercers.dart';
part 'ed_sheeran.query.g.dart';

@JsonSerializable(explicitToJson: true)
class EdSheeran with EquatableMixin {
  EdSheeran();

  factory EdSheeran.fromJson(Map<String, dynamic> json) =>
      _$EdSheeranFromJson(json);

  Node node;

  @override
  List<Object> get props => [node];
  Map<String, dynamic> toJson() => _$EdSheeranToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Node with EquatableMixin {
  Node();

  factory Node.fromJson(Map<String, dynamic> json) {
    switch (json['__typename'].toString()) {
      case 'Artist':
        return Artist.fromJson(json);
      default:
    }
    return _$NodeFromJson(json);
  }

  String id;

  @JsonKey(name: '__typename')
  String resolveType;

  @override
  List<Object> get props => [id, resolveType];
  Map<String, dynamic> toJson() {
    switch (resolveType) {
      case 'Artist':
        return (this as Artist).toJson();
      default:
    }
    return _$NodeToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class Artist with EquatableMixin implements Node, Entity {
  Artist();

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);

  String mbid;

  String name;

  LifeSpan lifeSpan;

  SpotifyArtist spotify;

  @override
  @JsonKey(name: '__typename')
  String resolveType;

  @override
  String id;

  @override
  List<Object> get props => [mbid, name, lifeSpan, spotify, resolveType, id];
  Map<String, dynamic> toJson() => _$ArtistToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LifeSpan with EquatableMixin {
  LifeSpan();

  factory LifeSpan.fromJson(Map<String, dynamic> json) =>
      _$LifeSpanFromJson(json);

  @JsonKey(
      fromJson: fromGraphQLDateToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDate)
  DateTime begin;

  @override
  List<Object> get props => [begin];
  Map<String, dynamic> toJson() => _$LifeSpanToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SpotifyArtist with EquatableMixin {
  SpotifyArtist();

  factory SpotifyArtist.fromJson(Map<String, dynamic> json) =>
      _$SpotifyArtistFromJson(json);

  String href;

  @override
  List<Object> get props => [href];
  Map<String, dynamic> toJson() => _$SpotifyArtistToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Entity with EquatableMixin {
  Entity();

  factory Entity.fromJson(Map<String, dynamic> json) => _$EntityFromJson(json);

  String mbid;

  @JsonKey(name: '__typename')
  String resolveType;

  @override
  List<Object> get props => [mbid, resolveType];
  Map<String, dynamic> toJson() => _$EntityToJson(this);
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
