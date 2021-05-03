// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';

part 'query.graphql.g.dart';

mixin UserFragMixin {
  late String id;
  late String username;
}
mixin NodeFragMixin {
  late String id;
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

  late String message;

  late Custom$Query$Node$ChatMessage$User user;

  @override
  List<Object?> get props => [message, user];

  Map<String, dynamic> toJson() => _$Custom$Query$Node$ChatMessageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$Query$Node extends JsonSerializable with EquatableMixin {
  Custom$Query$Node();

  factory Custom$Query$Node.fromJson(Map<String, dynamic> json) {
    switch (json['__typename'].toString()) {
      case r'Node':
        return Custom$Query$Node$Node.fromJson(json);
      case r'User':
        return Custom$Query$Node$User.fromJson(json);
      case r'ChatMessage':
        return Custom$Query$Node$ChatMessage.fromJson(json);
      default:
    }
    return _$Custom$Query$NodeFromJson(json);
  }

  @override
  List<Object?> get props => [];

  Map<String, dynamic> toJson() {
    switch ($$typename) {
      case r'Node':
        return (this as Custom$Query$Node$Node).toJson();
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

  Custom$Query$Node? nodeById;

  @override
  List<Object?> get props => [nodeById];

  Map<String, dynamic> toJson() => _$Custom$QueryToJson(this);
}
