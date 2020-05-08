// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'messages_with_users.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class MessagesWithUsers$SubscriptionRoot$Messages$Profile with EquatableMixin {
  MessagesWithUsers$SubscriptionRoot$Messages$Profile();

  factory MessagesWithUsers$SubscriptionRoot$Messages$Profile.fromJson(
          Map<String, dynamic> json) =>
      _$MessagesWithUsers$SubscriptionRoot$Messages$ProfileFromJson(json);

  int id;

  String name;

  @override
  List<Object> get props => [id, name];
  Map<String, dynamic> toJson() =>
      _$MessagesWithUsers$SubscriptionRoot$Messages$ProfileToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MessagesWithUsers$SubscriptionRoot$Messages with EquatableMixin {
  MessagesWithUsers$SubscriptionRoot$Messages();

  factory MessagesWithUsers$SubscriptionRoot$Messages.fromJson(
          Map<String, dynamic> json) =>
      _$MessagesWithUsers$SubscriptionRoot$MessagesFromJson(json);

  int id;

  String message;

  MessagesWithUsers$SubscriptionRoot$Messages$Profile profile;

  @override
  List<Object> get props => [id, message, profile];
  Map<String, dynamic> toJson() =>
      _$MessagesWithUsers$SubscriptionRoot$MessagesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MessagesWithUsers$SubscriptionRoot with EquatableMixin {
  MessagesWithUsers$SubscriptionRoot();

  factory MessagesWithUsers$SubscriptionRoot.fromJson(
          Map<String, dynamic> json) =>
      _$MessagesWithUsers$SubscriptionRootFromJson(json);

  List<MessagesWithUsers$SubscriptionRoot$Messages> messages;

  @override
  List<Object> get props => [messages];
  Map<String, dynamic> toJson() =>
      _$MessagesWithUsers$SubscriptionRootToJson(this);
}

class MessagesWithUsersSubscription
    extends GraphQLQuery<MessagesWithUsers$SubscriptionRoot, JsonSerializable> {
  MessagesWithUsersSubscription();

  @override
  final DocumentNode document = DocumentNode(definitions: [
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

  @override
  final String operationName = 'messages_with_users';

  @override
  List<Object> get props => [document, operationName];
  @override
  MessagesWithUsers$SubscriptionRoot parse(Map<String, dynamic> json) =>
      MessagesWithUsers$SubscriptionRoot.fromJson(json);
}
