import 'package:artemis/generator/data/data.dart';
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
      name: QueryName(name: r'Custom$_Query'),
      operationName: r'custom',
      classes: [
        FragmentClassDefinition(name: FragmentName(name:'ArtemisTyped'), properties: [
          ClassProperty(
            type: TypeName(name: 'String'),
            name: ClassPropertyName(name: '__typename'),
            annotations: ['override', 'JsonKey(name: \'__typename\')'],
            isResolveType: true,
          )
        ]),
        ClassDefinition(
            name: ClassName(name: r'Custom$_Query$_nodeById$_user'),
            extension: ClassName(name: r'Custom$_Query$_nodeById'),
            mixins: [FragmentName(name: r'UserFragMixin')],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name:
                ClassName(name: r'Custom$_Query$_nodeById$_chatMessage$_user'),
            extension: ClassName(name: r'Custom$_Query$_nodeById$_chatMessage'),
            mixins: [FragmentName(name: r'UserFragMixin')],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Custom$_Query$_nodeById$_chatMessage'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'message'),
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type:
                      TypeName(name: r'Custom$Query$NodeById$ChatMessage$User'),
                  name: ClassPropertyName(name: r'user'),
                  isNonNull: true,
                  isResolveType: false)
            ],
            extension: ClassName(name: r'Custom$_Query$_nodeById'),
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Custom$_Query$_nodeById'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'id'),
                  isNonNull: true,
                  isResolveType: false)
            ],
            mixins: [FragmentName(name: 'ArtemisTyped')],
            factoryPossibilities: {
              r'User': ClassName(name: r'Custom$_Query$_nodeById$_User'),
              r'ChatMessage':
                  ClassName(name: r'Custom$_Query$_nodeById$_ChatMessage')
            },
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Custom$_Query'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'Custom$Query$NodeById'),
                  name: ClassPropertyName(name: r'nodeById'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        FragmentClassDefinition(
            name: FragmentName(name: r'UserFragMixin'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'id'),
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'username'),
                  isNonNull: true,
                  isResolveType: false)
            ])
      ],
      inputs: [
        QueryInput(
            type: TypeName(name: r'String'),
            name: QueryInputName(name: r'id'),
            isNonNull: true)
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

mixin ArtemisTypedMixin {
  @override
  @JsonKey(name: '__typename')
  String $$typename;
}
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
class Custom$Query$NodeById with EquatableMixin, ArtemisTypedMixin {
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
  List<Object> get props => [$$typename, id];
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
