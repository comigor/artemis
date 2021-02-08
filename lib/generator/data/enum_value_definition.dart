import 'package:artemis/generator/data/definition.dart';
import 'package:artemis/generator/data_printer.dart';
import 'package:meta/meta.dart';
import 'package:recase/recase.dart';

/// Enum value
class EnumValueDefinition extends Definition with DataPrinter {
  @override
  final EnumValueName name;

  /// Some other custom annotation.
  final List<String> annotations;

  /// Instantiate an enum value
  EnumValueDefinition({
    required this.name,
    this.annotations = const [],
  });

  @override
  Map<String, Object> get namedProps => {
        'name': name,
        'annotations': annotations,
      };
}

/// Enum value name
class EnumValueName extends Name with DataPrinter {
  /// Instantiate a enum value name definition.
  EnumValueName({required String name}) : super(name: name);

  @override
  Map<String, Object?> get namedProps => {
        'name': name,
      };

  @override
  String normalize(String? name) {
    return ReCase(super.normalize(name)!).camelCase;
  }
}
