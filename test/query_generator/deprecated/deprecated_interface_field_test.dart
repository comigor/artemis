// @dart = 2.8

import 'package:artemis/generator/data/data.dart';
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
      deprecatedField
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
    deprecatedField: String @deprecated(reason: "deprecated interface field")
  }
  
  type User implements Node {
    id: ID!
    username: String!
    deprecatedField: String
  }
  
  type ChatMessage implements Node {
    id: ID!
    message: String!
    user: User!
  }
''';

final LibraryDefinition libraryDefinition = LibraryDefinition(
  basename: r'query.graphql',
  queries: [
    QueryDefinition(
      operationName: r'custom',
      name: QueryName(name: r'Custom$_Query'),
      classes: [
        ClassDefinition(
          name: ClassName(name: r'Custom$_Query$_Node$_User'),
          extension: ClassName(name: r'Custom$_Query$_Node'),
          mixins: [FragmentName(name: r'UserFragMixin')],
          factoryPossibilities: {},
          typeNameField: ClassPropertyName(name: r'__typename'),
          isInput: false,
        ),
        ClassDefinition(
          name: ClassName(name: r'Custom$_Query$_Node$_ChatMessage$_User'),
          extension: ClassName(name: r'Custom$_Query$_Node$_ChatMessage'),
          mixins: [FragmentName(name: r'UserFragMixin')],
          factoryPossibilities: {},
          typeNameField: ClassPropertyName(name: r'__typename'),
          isInput: false,
        ),
        ClassDefinition(
          name: ClassName(name: r'Custom$_Query$_Node$_ChatMessage'),
          properties: [
            ClassProperty(
              type: TypeName(name: r'String'),
              name: ClassPropertyName(name: r'message'),
              isResolveType: false,
            ),
            ClassProperty(
              type: TypeName(name: r'Custom$_Query$_Node$_ChatMessage$_User'),
              name: ClassPropertyName(name: r'user'),
              isResolveType: false,
            )
          ],
          extension: ClassName(name: r'Custom$_Query$_Node'),
          factoryPossibilities: {},
          typeNameField: ClassPropertyName(name: r'__typename'),
          isInput: false,
        ),
        ClassDefinition(
          name: ClassName(name: r'Custom$_Query$_Node'),
          properties: [
            ClassProperty(
              type: TypeName(name: r'String'),
              name: ClassPropertyName(name: r'id'),
              isResolveType: false,
            ),
            ClassProperty(
              type: TypeName(name: r'String'),
              name: ClassPropertyName(name: r'deprecatedField'),
              isResolveType: false,
              annotations: [
                "Deprecated('deprecated interface field')",
              ],
            ),
          ],
          factoryPossibilities: {
            r'User': ClassName(name: r'Custom$_Query$_Node$_User'),
            r'ChatMessage': ClassName(name: r'Custom$_Query$_Node$_ChatMessage')
          },
          typeNameField: ClassPropertyName(name: r'__typename'),
          isInput: false,
        ),
        ClassDefinition(
          name: ClassName(name: r'Custom$_Query'),
          properties: [
            ClassProperty(
              type: TypeName(name: r'Custom$_Query$_Node'),
              name: ClassPropertyName(name: r'nodeById'),
              isResolveType: false,
            ),
          ],
          factoryPossibilities: {},
          typeNameField: ClassPropertyName(name: r'__typename'),
          isInput: false,
        ),
        FragmentClassDefinition(
          name: FragmentName(
            name: r'UserFragMixin',
          ),
          properties: [
            ClassProperty(
              type: TypeName(name: r'String'),
              name: ClassPropertyName(name: r'id'),
              isResolveType: false,
            ),
            ClassProperty(
              type: TypeName(name: r'String'),
              name: ClassPropertyName(name: r'username'),
              isResolveType: false,
            ),
          ],
        )
      ],
      inputs: [
        QueryInput(
          type: TypeName(name: r'String'),
          name: QueryInputName(name: r'id'),
        ),
      ],
      generateHelpers: false,
      suffix: r'Query',
    )
  ],
);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

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
  List<Object?> get props => [id, username];
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
  List<Object?> get props => [id, username];
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
  List<Object?> get props => [message, user];
  Map<String, dynamic> toJson() => _$Custom$Query$Node$ChatMessageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$Query$Node extends JsonSerializable with EquatableMixin {
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

  @Deprecated('deprecated interface field')
  String deprecatedField;

  @override
  List<Object?> get props => [id, deprecatedField];
  Map<String, dynamic> toJson() {
    switch ($$typename) {
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
class Custom$Query extends JsonSerializable with EquatableMixin {
  Custom$Query();

  factory Custom$Query.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryFromJson(json);

  Custom$Query$Node nodeById;

  @override
  List<Object?> get props => [nodeById];
  Map<String, dynamic> toJson() => _$Custom$QueryToJson(this);
}
''';
