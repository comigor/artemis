import 'package:artemis/generator/data_printer.dart';
import 'package:artemis/generator/data/definition.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class Annotation extends Equatable with DataPrinter {
  String toAnnotation();
}

class JsonKeyItem extends Equatable with DataPrinter {
  final String? defaultValue;

  final String? disallowNullValue;

  final String? fromJson;

  final String? ignore;

  final String? includeIfNull;

  final String? name;

  final String? required;

  final String? toJson;

  final String? unknownEnumValue;

  const JsonKeyItem({
    this.defaultValue,
    this.disallowNullValue,
    this.fromJson,
    this.ignore,
    this.includeIfNull,
    this.name,
    this.required,
    this.toJson,
    this.unknownEnumValue,
  });

  @override
  Map<String, Object?> get namedProps {
    return {
      'defaultValue': defaultValue,
      'disallowNullValue': disallowNullValue,
      'fromJson': fromJson,
      'ignore': ignore,
      'includeIfNull': includeIfNull,
      'name': name,
      'required': required,
      'toJson': toJson,
      'unknownEnumValue': unknownEnumValue,
    };
  }

  JsonKeyItem copyWith({
    String? defaultValue,
    String? disallowNullValue,
    String? fromJson,
    String? ignore,
    String? includeIfNull,
    String? name,
    String? required,
    String? toJson,
    String? unknownEnumValue,
  }) {
    return JsonKeyItem(
      defaultValue: defaultValue ?? this.defaultValue,
      disallowNullValue: disallowNullValue ?? this.disallowNullValue,
      fromJson: fromJson ?? this.fromJson,
      ignore: ignore ?? this.ignore,
      includeIfNull: includeIfNull ?? this.includeIfNull,
      name: name ?? this.name,
      required: required ?? this.required,
      toJson: toJson ?? this.toJson,
      unknownEnumValue: unknownEnumValue ?? this.unknownEnumValue,
    );
  }
}

class StringAnnotation extends Annotation {
  final String name;

  StringAnnotation({required this.name});

  @override
  String toAnnotation() => name;

  @override
  Map<String, Object?> get namedProps => {
        'name': name,
      };
}

class OverrideAnnotation extends StringAnnotation {
  OverrideAnnotation() : super(name: 'override');
}

class JsonKeyAnnotation extends Annotation {
  final JsonKeyItem jsonKey;

  JsonKeyAnnotation({required this.jsonKey});

  factory JsonKeyAnnotation.fromMap(Map<String, dynamic> jsonKeyAnnotation) {
    return JsonKeyAnnotation(
      jsonKey: JsonKeyItem(
        defaultValue: jsonKeyAnnotation['defaultValue'] as String?,
        disallowNullValue: jsonKeyAnnotation['disallowNullValue'] as String?,
        fromJson: jsonKeyAnnotation['fromJson'] as String?,
        ignore: jsonKeyAnnotation['ignore'] as String?,
        includeIfNull: jsonKeyAnnotation['includeIfNull'] as String?,
        name: jsonKeyAnnotation['name'] as String?,
        required: jsonKeyAnnotation['required'] as String?,
        toJson: jsonKeyAnnotation['toJson'] as String?,
        unknownEnumValue: jsonKeyAnnotation['unknownEnumValue'] as String?,
      ),
    );
  }

  @override
  String toAnnotation() {
    final jsonKeyAnnotation = <String, dynamic>{
      'disallowNullValue': jsonKey.disallowNullValue,
      'fromJson': jsonKey.fromJson,
      'ignore': jsonKey.ignore,
      'includeIfNull': jsonKey.includeIfNull,
      'name': jsonKey.name,
      'required': jsonKey.required,
      'toJson': jsonKey.toJson,
      'unknownEnumValue': jsonKey.unknownEnumValue
    };

    final key = jsonKeyAnnotation.entries
        .map<String?>((e) {
          if (e.value != null) {
            switch (e.key) {
              case 'name':
                return '${e.key}: \'${e.value}\'';
              default:
                return '${e.key}: ${e.value}';
            }
          }

          return null;
        })
        .whereType<String>()
        .join(', ');

    return 'JsonKey($key)';
  }

  @override
  Map<String, Object?> get namedProps {
    return {
      'jsonKey': jsonKey,
    };
  }
}
