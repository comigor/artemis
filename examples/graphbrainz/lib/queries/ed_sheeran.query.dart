// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:graphbrainz_example/coercers.dart';
part 'ed_sheeran.query.g.dart';

@JsonSerializable(explicitToJson: true)
class EdSheeran$Query$Node$Artist$LifeSpan with EquatableMixin {
  EdSheeran$Query$Node$Artist$LifeSpan();

  factory EdSheeran$Query$Node$Artist$LifeSpan.fromJson(
          Map<String, dynamic> json) =>
      _$EdSheeran$Query$Node$Artist$LifeSpanFromJson(json);

  DateTime begin;

  @override
  List<Object> get props => [begin];
  Map<String, dynamic> toJson() =>
      _$EdSheeran$Query$Node$Artist$LifeSpanToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EdSheeran$Query$Node$Artist$SpotifyArtist with EquatableMixin {
  EdSheeran$Query$Node$Artist$SpotifyArtist();

  factory EdSheeran$Query$Node$Artist$SpotifyArtist.fromJson(
          Map<String, dynamic> json) =>
      _$EdSheeran$Query$Node$Artist$SpotifyArtistFromJson(json);

  String href;

  @override
  List<Object> get props => [href];
  Map<String, dynamic> toJson() =>
      _$EdSheeran$Query$Node$Artist$SpotifyArtistToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EdSheeran$Query$Node$Artist extends EdSheeran$Query$Node
    with EquatableMixin {
  EdSheeran$Query$Node$Artist();

  factory EdSheeran$Query$Node$Artist.fromJson(Map<String, dynamic> json) =>
      _$EdSheeran$Query$Node$ArtistFromJson(json);

  String mbid;

  String name;

  EdSheeran$Query$Node$Artist$LifeSpan lifeSpan;

  EdSheeran$Query$Node$Artist$SpotifyArtist spotify;

  @override
  List<Object> get props => [mbid, name, lifeSpan, spotify];
  Map<String, dynamic> toJson() => _$EdSheeran$Query$Node$ArtistToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EdSheeran$Query$Node with EquatableMixin {
  EdSheeran$Query$Node();

  factory EdSheeran$Query$Node.fromJson(Map<String, dynamic> json) {
    switch (json['__typename'].toString()) {
      case r'Artist':
        return EdSheeran$Query$Node$Artist.fromJson(json);
      default:
    }
    return _$EdSheeran$Query$NodeFromJson(json);
  }

  String id;

  @override
  @JsonKey(name: '__typename')
  String typeName;

  @override
  List<Object> get props => [id, typeName];
  Map<String, dynamic> toJson() {
    switch (typeName) {
      case r'Artist':
        return (this as EdSheeran$Query$Node$Artist).toJson();
      default:
    }
    return _$EdSheeran$Query$NodeToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class EdSheeran$Query with EquatableMixin {
  EdSheeran$Query();

  factory EdSheeran$Query.fromJson(Map<String, dynamic> json) =>
      _$EdSheeran$QueryFromJson(json);

  EdSheeran$Query$Node node;

  @override
  List<Object> get props => [node];
  Map<String, dynamic> toJson() => _$EdSheeran$QueryToJson(this);
}

class EdSheeranQuery extends GraphQLQuery<EdSheeran$Query, JsonSerializable> {
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
  EdSheeran$Query parse(Map<String, dynamic> json) =>
      EdSheeran$Query.fromJson(json);
}
