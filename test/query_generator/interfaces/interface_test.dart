import 'package:artemis/generator/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On interfaces', () {
    test(
      'On interfaces',
      () async => testGenerator(
        query: query,
        schema: graphQLSchema,
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
      ),
    );
  });
}

const query = r'''
  query custom($id: ID!) {
    nodeById(id: $id) {
      id
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
  
  fragment UserFrag on User {
    id
    username
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
            name: ClassName(name: r'Custom$Query$Node$User'),
            extension: ClassName(name: r'Custom$Query$Node'),
            mixins: [r'UserFragMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Custom$Query$Node$ChatMessage$User'),
            extension: ClassName(name: r'Custom$Query$Node$ChatMessage'),
            mixins: [r'UserFragMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Custom$Query$Node$ChatMessage'),
            properties: [
              ClassProperty(
                  type: r'String',
                  name: VariableName(name: r'message'),
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: r'Custom$Query$Node$ChatMessage$User',
                  name: VariableName(name: r'user'),
                  isNonNull: true,
                  isResolveType: false)
            ],
            extension: ClassName(name: r'Custom$Query$Node'),
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Custom$Query$Node'),
            properties: [
              ClassProperty(
                  type: r'String',
                  name: VariableName(name: r'id'),
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: r'String',
                  name: VariableName(name: r'typeName'),
                  annotations: [
                    r'override',
                    r'''JsonKey(name: '__typename')'''
                  ],
                  isNonNull: false,
                  isResolveType: true)
            ],
            factoryPossibilities: {
              r'User': r'Custom$Query$Node$User',
              r'ChatMessage': r'Custom$Query$Node$ChatMessage'
            },
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Custom$Query'),
            properties: [
              ClassProperty(
                  type: r'Custom$Query$Node',
                  name: VariableName(name: r'nodeById'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        FragmentClassDefinition(
            name: ClassName(name: r'UserFragMixin'),
            properties: [
              ClassProperty(
                  type: r'String',
                  name: VariableName(name: r'id'),
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: r'String',
                  name: VariableName(name: r'username'),
                  isNonNull: true,
                  isResolveType: false)
            ])
      ],
      inputs: [
        QueryInput(
            type: r'String', name: VariableName(name: r'id'), isNonNull: true)
      ],
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
class Custom$Query$Node$User extends Custom$Query$Node
    with EquatableMixin, UserFragMixin {
  Custom$Query$Node$User();

  factory Custom$Query$Node$User.fromJson(Map<String, dynamic> json) =>
      _$Custom$Query$Node$UserFromJson(json);

  @override
  List<Object> get props => [id, username];
  Map<String, dynamic> toJson() => _$Custom$Query$Node$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$Query$Node$ChatMessage$User extends Custom$Query$Node$ChatMessage
    with EquatableMixin, UserFragMixin {
  Custom$Query$Node$ChatMessage$User();

  factory Custom$Query$Node$ChatMessage$User.fromJson(
          Map<String, dynamic> json) =>
      _$Custom$Query$Node$ChatMessage$UserFromJson(json);

  @override
  List<Object> get props => [id, username];
  Map<String, dynamic> toJson() =>
      _$Custom$Query$Node$ChatMessage$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$Query$Node$ChatMessage extends Custom$Query$Node
    with EquatableMixin {
  Custom$Query$Node$ChatMessage();

  factory Custom$Query$Node$ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$Custom$Query$Node$ChatMessageFromJson(json);

  String message;

  Custom$Query$Node$ChatMessage$User user;

  @override
  List<Object> get props => [message, user];
  Map<String, dynamic> toJson() => _$Custom$Query$Node$ChatMessageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$Query$Node with EquatableMixin {
  Custom$Query$Node();

  factory Custom$Query$Node.fromJson(Map<String, dynamic> json) {
    switch (json['__typename'].toString()) {
      case r'User':
        return Custom$Query$Node$User.fromJson(json);
      case r'ChatMessage':
        return Custom$Query$Node$ChatMessage.fromJson(json);
      default:
    }
    return _$Custom$Query$NodeFromJson(json);
  }

  String id;

  @override
  @JsonKey(name: '__typename')
  String typeName;

  @override
  List<Object> get props => [id, typeName];
  Map<String, dynamic> toJson() {
    switch (typeName) {
      case r'User':
        return (this as Custom$Query$Node$User).toJson();
      case r'ChatMessage':
        return (this as Custom$Query$Node$ChatMessage).toJson();
      default:
    }
    return _$Custom$Query$NodeToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class Custom$Query with EquatableMixin {
  Custom$Query();

  factory Custom$Query.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryFromJson(json);

  Custom$Query$Node nodeById;

  @override
  List<Object> get props => [nodeById];
  Map<String, dynamic> toJson() => _$Custom$QueryToJson(this);
}
''';
