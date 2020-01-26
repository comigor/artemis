import 'package:artemis/generator/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On interfaces', () {
    testGenerator(
      description: 'On interfaces',
      query: query,
      libraryDefinition: libraryDefinition,
      generatedFile: generatedFile,
      stringSchema: stringSchema,
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
final graphQLSchema = '''
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

const stringSchema = r'''
{
    "__schema": {
        "queryType": {
            "name": "Query"
        },
        "mutationType": null,
        "subscriptionType": null,
        "types": [
            {
                "kind": "OBJECT",
                "name": "Query",
                "description": null,
                "fields": [
                    {
                        "name": "nodeById",
                        "description": null,
                        "args": [
                            {
                                "name": "id",
                                "description": null,
                                "type": {
                                    "kind": "NON_NULL",
                                    "name": null,
                                    "ofType": {
                                        "kind": "SCALAR",
                                        "name": "ID",
                                        "ofType": null
                                    }
                                },
                                "defaultValue": null
                            }
                        ],
                        "type": {
                            "kind": "INTERFACE",
                            "name": "Node",
                            "ofType": null
                        },
                        "isDeprecated": false,
                        "deprecationReason": null
                    }
                ],
                "inputFields": null,
                "interfaces": [],
                "enumValues": null,
                "possibleTypes": null
            },
            {
                "kind": "INTERFACE",
                "name": "Node",
                "description": null,
                "fields": [
                    {
                        "name": "id",
                        "description": null,
                        "args": [],
                        "type": {
                            "kind": "NON_NULL",
                            "name": null,
                            "ofType": {
                                "kind": "SCALAR",
                                "name": "ID",
                                "ofType": null
                            }
                        },
                        "isDeprecated": false,
                        "deprecationReason": null
                    }
                ],
                "inputFields": null,
                "interfaces": null,
                "enumValues": null,
                "possibleTypes": [
                    {
                        "kind": "OBJECT",
                        "name": "User",
                        "ofType": null
                    },
                    {
                        "kind": "OBJECT",
                        "name": "ChatMessage",
                        "ofType": null
                    }
                ]
            },
            {
                "kind": "OBJECT",
                "name": "User",
                "description": null,
                "fields": [
                    {
                        "name": "id",
                        "description": null,
                        "args": [],
                        "type": {
                            "kind": "NON_NULL",
                            "name": null,
                            "ofType": {
                                "kind": "SCALAR",
                                "name": "ID",
                                "ofType": null
                            }
                        },
                        "isDeprecated": false,
                        "deprecationReason": null
                    },
                    {
                        "name": "username",
                        "description": null,
                        "args": [],
                        "type": {
                            "kind": "NON_NULL",
                            "name": null,
                            "ofType": {
                                "kind": "SCALAR",
                                "name": "String",
                                "ofType": null
                            }
                        },
                        "isDeprecated": false,
                        "deprecationReason": null
                    }
                ],
                "inputFields": null,
                "interfaces": [
                    {
                        "kind": "INTERFACE",
                        "name": "Node",
                        "ofType": null
                    }
                ],
                "enumValues": null,
                "possibleTypes": null
            },
            {
                "kind": "OBJECT",
                "name": "ChatMessage",
                "description": null,
                "fields": [
                    {
                        "name": "id",
                        "description": null,
                        "args": [],
                        "type": {
                            "kind": "NON_NULL",
                            "name": null,
                            "ofType": {
                                "kind": "SCALAR",
                                "name": "ID",
                                "ofType": null
                            }
                        },
                        "isDeprecated": false,
                        "deprecationReason": null
                    },
                    {
                        "name": "message",
                        "description": null,
                        "args": [],
                        "type": {
                            "kind": "NON_NULL",
                            "name": null,
                            "ofType": {
                                "kind": "SCALAR",
                                "name": "String",
                                "ofType": null
                            }
                        },
                        "isDeprecated": false,
                        "deprecationReason": null
                    },
                    {
                        "name": "user",
                        "description": null,
                        "args": [],
                        "type": {
                            "kind": "NON_NULL",
                            "name": null,
                            "ofType": {
                                "kind": "OBJECT",
                                "name": "User",
                                "ofType": null
                            }
                        },
                        "isDeprecated": false,
                        "deprecationReason": null
                    }
                ],
                "inputFields": null,
                "interfaces": [
                    {
                        "kind": "INTERFACE",
                        "name": "Node",
                        "ofType": null
                    }
                ],
                "enumValues": null,
                "possibleTypes": null
            },
            {
                "kind": "SCALAR",
                "name": "String",
                "description": "The `String` scalar type represents textual data, represented as UTF-8 character sequences. The String type is most often used by GraphQL to represent free-form human-readable text.",
                "fields": null,
                "inputFields": null,
                "interfaces": null,
                "enumValues": null,
                "possibleTypes": null
            },
            {
                "kind": "SCALAR",
                "name": "ID",
                "description": "The `ID` scalar type represents a unique identifier, often used to refetch an object or as key for a cache. The ID type appears in a JSON response as a String; however, it is not intended to be human-readable. When expected as an input type, any string (such as `\"4\"`) or integer (such as `4`) input value will be accepted as an ID.",
                "fields": null,
                "inputFields": null,
                "interfaces": null,
                "enumValues": null,
                "possibleTypes": null
            }
        ],
        "directives": []
    }
}
''';

final libraryDefinition = LibraryDefinition(basename: r'query', queries: [
  QueryDefinition(
      queryName: r'custom',
      queryType: r'Custom$Query',
      classes: [
        ClassDefinition(
            name: r'Custom$Query$Node$User',
            extension: r'Custom$Query$Node',
            mixins: [r'UserFragMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename'),
        ClassDefinition(
            name: r'Custom$Query$Node$ChatMessage$User',
            mixins: [r'UserFragMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename'),
        ClassDefinition(
            name: r'Custom$Query$Node$ChatMessage',
            properties: [
              ClassProperty(
                  type: r'String', name: r'message', isOverride: false),
              ClassProperty(
                  type: r'Custom$Query$Node$ChatMessage$User',
                  name: r'user',
                  isOverride: false)
            ],
            extension: r'Custom$Query$Node',
            factoryPossibilities: {},
            typeNameField: r'__typename'),
        ClassDefinition(
            name: r'Custom$Query$Node',
            properties: [
              ClassProperty(type: r'String', name: r'id', isOverride: false),
              ClassProperty(
                  type: r'String',
                  name: r'typeName',
                  isOverride: true,
                  annotation: r'''JsonKey(name: '__typename')''')
            ],
            factoryPossibilities: {
              r'User': r'Custom$Query$Node$User',
              r'ChatMessage': r'Custom$Query$Node$ChatMessage'
            },
            typeNameField: r'__typename'),
        ClassDefinition(
            name: r'Custom$Query',
            properties: [
              ClassProperty(
                  type: r'Custom$Query$Node',
                  name: r'nodeById',
                  isOverride: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename'),
        FragmentClassDefinition(name: r'UserFragMixin', properties: [
          ClassProperty(type: r'String', name: r'id', isOverride: false),
          ClassProperty(type: r'String', name: r'username', isOverride: false)
        ])
      ],
      inputs: [QueryInput(type: r'String', name: r'id')],
      generateHelpers: false)
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.g.dart';

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
class Custom$Query$Node$ChatMessage$User with EquatableMixin, UserFragMixin {
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
