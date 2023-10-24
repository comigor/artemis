// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'messages_with_users.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class MessagesWithUsers$SubscriptionRoot$Messages$Profile
    extends JsonSerializable with EquatableMixin {
  MessagesWithUsers$SubscriptionRoot$Messages$Profile();

  factory MessagesWithUsers$SubscriptionRoot$Messages$Profile.fromJson(
          Map<String, dynamic> json) =>
      _$MessagesWithUsers$SubscriptionRoot$Messages$ProfileFromJson(json);

  late int id;

  late String name;

  @override
  List<Object?> get props => [id, name];

  @override
  Map<String, dynamic> toJson() =>
      _$MessagesWithUsers$SubscriptionRoot$Messages$ProfileToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MessagesWithUsers$SubscriptionRoot$Messages extends JsonSerializable
    with EquatableMixin {
  MessagesWithUsers$SubscriptionRoot$Messages();

  factory MessagesWithUsers$SubscriptionRoot$Messages.fromJson(
          Map<String, dynamic> json) =>
      _$MessagesWithUsers$SubscriptionRoot$MessagesFromJson(json);

  late int id;

  late String message;

  late MessagesWithUsers$SubscriptionRoot$Messages$Profile profile;

  @override
  List<Object?> get props => [id, message, profile];

  @override
  Map<String, dynamic> toJson() =>
      _$MessagesWithUsers$SubscriptionRoot$MessagesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MessagesWithUsers$SubscriptionRoot extends JsonSerializable
    with EquatableMixin {
  MessagesWithUsers$SubscriptionRoot();

  factory MessagesWithUsers$SubscriptionRoot.fromJson(
          Map<String, dynamic> json) =>
      _$MessagesWithUsers$SubscriptionRootFromJson(json);

  late List<MessagesWithUsers$SubscriptionRoot$Messages> messages;

  @override
  List<Object?> get props => [messages];

  @override
  Map<String, dynamic> toJson() =>
      _$MessagesWithUsers$SubscriptionRootToJson(this);
}

final MESSAGES_WITH_USERS_SUBSCRIPTION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.subscription,
      name: NameNode(value: 'messages_with_users'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'messages'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'message'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'profile'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ]))
      ]))
]);

class MessagesWithUsersSubscription
    extends GraphQLQuery<MessagesWithUsers$SubscriptionRoot, JsonSerializable> {
  MessagesWithUsersSubscription();

  @override
  final DocumentNode document = MESSAGES_WITH_USERS_SUBSCRIPTION_DOCUMENT;

  @override
  final String operationName = 'messages_with_users';

  @override
  List<Object?> get props => [document, operationName];

  @override
  MessagesWithUsers$SubscriptionRoot parse(Map<String, dynamic> json) =>
      MessagesWithUsers$SubscriptionRoot.fromJson(json);
}
