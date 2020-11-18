import 'dart:async';

import 'package:artemis/artemis.dart';
import 'package:gql_link/gql_link.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';

import 'graphql/messages_with_users.graphql.dart';

Future<void> main() async {
  final config = SocketClientConfig(autoReconnect: true);
  final client = ArtemisClient.fromLink(
    Link.from([
      WSLink('ws://localhost:8080/v1/graphql', config: config),
    ]),
  );

  final messagesWithUsers = MessagesWithUsersSubscription();

  client.stream(messagesWithUsers).listen((response) {
    print(response.data.messages.last.message);
  });
}
