import 'package:artemis/generator/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('Interface with fragment globs', () {
    test(
      'Should handle correctly when interfaces use external fragments',
      () async => testGenerator(
        query: query,
        namingScheme: 'pathedWithFields',
        schema: graphQLSchema,
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        builderOptionsMap: {'fragments_glob': '**.frag'},
        sourceAssetsMap: {
          'a|fragment.frag': fragmentsString,
        },
      ),
    );
  });
}

const fragmentsString = '''
  fragment UserFrag on User {
    id
    username
  }
''';

const query = r'''
  query custom($id: ID!) {
    nodeById(id: $id) {
      id
      __typename,
      ... on User {
        ...UserFrag
      }
      ... on ChatMessage {
        message
        user {
          ...UserFrag
        }
      }
    }
  }
''';

// https://graphql-code-generator.com/#live-demo
final String graphQLSchema = r'''
  scalar String
  scalar ID
  
  schema {
    query: Query
  }
  
  type Query {
    nodeById(id: ID!): Node
    anoterNodeById(id: ID!): Node
  }
  
  interface Node {
    id: ID!
  }
  
  type User implements Node {
    id: ID!
    username: String!
  }
  
  type ChatMessage implements Node {
    id: ID!
    message: String!
    user: User!
  }
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      queryName: r'custom',
      queryType: r'Custom$Query',
      classes: [
        ClassDefinition(
            name: r'Custom$Query$NodeById$User',
            extension: r'Custom$Query$NodeById',
            mixins: [r'UserFragMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'Custom$Query$NodeById$ChatMessage$User',
            extension: r'Custom$Query$NodeById$ChatMessage',
            mixins: [r'UserFragMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'Custom$Query$NodeById$ChatMessage',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r'message',
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: r'Custom$Query$NodeById$ChatMessage$User',
                  name: r'user',
                  isNonNull: true,
                  isResolveType: false)
            ],
            extension: r'Custom$Query$NodeById',
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'Custom$Query$NodeById',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r'id',
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: r'String',
                  name: r'$$typename',
                  annotations: [
                    r'override',
                    r'''JsonKey(name: '__typename')'''
                  ],
                  isNonNull: false,
                  isResolveType: true)
            ],
            factoryPossibilities: {
              r'User': r'Custom$Query$NodeById$User',
              r'ChatMessage': r'Custom$Query$NodeById$ChatMessage'
            },
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'Custom$Query',
            properties: [
              ClassProperty(
                  type: r'Custom$Query$NodeById',
                  name: r'nodeById',
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        FragmentClassDefinition(name: r'UserFragMixin', properties: [
          ClassProperty(
              type: r'String',
              name: r'id',
              isNonNull: true,
              isResolveType: false),
          ClassProperty(
              type: r'String',
              name: r'username',
              isNonNull: true,
              isResolveType: false)
        ])
      ],
      inputs: [QueryInput(type: r'String', name: r'id', isNonNull: true)],
      generateHelpers: false,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

mixin UserFragMixin {
  String id;
  String username;
}

@JsonSerializable(explicitToJson: true)
class Custom$Query$NodeById$User extends Custom$Query$NodeById
    with EquatableMixin, UserFragMixin {
  Custom$Query$NodeById$User();

  factory Custom$Query$NodeById$User.fromJson(Map<String, dynamic> json) =>
      _$Custom$Query$NodeById$UserFromJson(json);

  @override
  List<Object> get props => [id, username];
  Map<String, dynamic> toJson() => _$Custom$Query$NodeById$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$Query$NodeById$ChatMessage$User
    extends Custom$Query$NodeById$ChatMessage
    with EquatableMixin, UserFragMixin {
  Custom$Query$NodeById$ChatMessage$User();

  factory Custom$Query$NodeById$ChatMessage$User.fromJson(
          Map<String, dynamic> json) =>
      _$Custom$Query$NodeById$ChatMessage$UserFromJson(json);

  @override
  List<Object> get props => [id, username];
  Map<String, dynamic> toJson() =>
      _$Custom$Query$NodeById$ChatMessage$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$Query$NodeById$ChatMessage extends Custom$Query$NodeById
    with EquatableMixin {
  Custom$Query$NodeById$ChatMessage();

  factory Custom$Query$NodeById$ChatMessage.fromJson(
          Map<String, dynamic> json) =>
      _$Custom$Query$NodeById$ChatMessageFromJson(json);

  String message;

  Custom$Query$NodeById$ChatMessage$User user;

  @override
  List<Object> get props => [message, user];
  Map<String, dynamic> toJson() =>
      _$Custom$Query$NodeById$ChatMessageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$Query$NodeById with EquatableMixin {
  Custom$Query$NodeById();

  factory Custom$Query$NodeById.fromJson(Map<String, dynamic> json) {
    switch (json['__typename'].toString()) {
      case r'User':
        return Custom$Query$NodeById$User.fromJson(json);
      case r'ChatMessage':
        return Custom$Query$NodeById$ChatMessage.fromJson(json);
      default:
    }
    return _$Custom$Query$NodeByIdFromJson(json);
  }

  String id;

  @override
  @JsonKey(name: '__typename')
  String $$typename;

  @override
  List<Object> get props => [id, $$typename];
  Map<String, dynamic> toJson() {
    switch ($$typename) {
      case r'User':
        return (this as Custom$Query$NodeById$User).toJson();
      case r'ChatMessage':
        return (this as Custom$Query$NodeById$ChatMessage).toJson();
      default:
    }
    return _$Custom$Query$NodeByIdToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class Custom$Query with EquatableMixin {
  Custom$Query();

  factory Custom$Query.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryFromJson(json);

  Custom$Query$NodeById nodeById;

  @override
  List<Object> get props => [nodeById];
  Map<String, dynamic> toJson() => _$Custom$QueryToJson(this);
}
''';
