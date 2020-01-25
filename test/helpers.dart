import 'dart:convert';

import 'package:artemis/schema/graphql.dart';
import 'package:logging/logging.dart';

String jsonFromSchema(GraphQLSchema schema) => json.encode({
      'data': {'__schema': schema.toJson()}
    });

void debug(LogRecord log) {
  const IS_DEBUG = false;
  if (IS_DEBUG) print(log);
}
