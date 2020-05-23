// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_with_users.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessagesWithUsers$SubscriptionRoot$Messages$Profile
    _$MessagesWithUsers$SubscriptionRoot$Messages$ProfileFromJson(
        Map<String, dynamic> json) {
  return MessagesWithUsers$SubscriptionRoot$Messages$Profile()
    ..id = json['id'] as int
    ..name = json['name'] as String;
}

Map<String, dynamic>
    _$MessagesWithUsers$SubscriptionRoot$Messages$ProfileToJson(
            MessagesWithUsers$SubscriptionRoot$Messages$Profile instance) =>
        <String, dynamic>{
          'id': instance.id,
          'name': instance.name,
        };

MessagesWithUsers$SubscriptionRoot$Messages
    _$MessagesWithUsers$SubscriptionRoot$MessagesFromJson(
        Map<String, dynamic> json) {
  return MessagesWithUsers$SubscriptionRoot$Messages()
    ..id = json['id'] as int
    ..message = json['message'] as String
    ..profile = json['profile'] == null
        ? null
        : MessagesWithUsers$SubscriptionRoot$Messages$Profile.fromJson(
            json['profile'] as Map<String, dynamic>);
}

Map<String, dynamic> _$MessagesWithUsers$SubscriptionRoot$MessagesToJson(
        MessagesWithUsers$SubscriptionRoot$Messages instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'profile': instance.profile?.toJson(),
    };

MessagesWithUsers$SubscriptionRoot _$MessagesWithUsers$SubscriptionRootFromJson(
    Map<String, dynamic> json) {
  return MessagesWithUsers$SubscriptionRoot()
    ..messages = (json['messages'] as List)
        ?.map((e) => e == null
            ? null
            : MessagesWithUsers$SubscriptionRoot$Messages.fromJson(
                e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MessagesWithUsers$SubscriptionRootToJson(
        MessagesWithUsers$SubscriptionRoot instance) =>
    <String, dynamic>{
      'messages': instance.messages?.map((e) => e?.toJson())?.toList(),
    };
