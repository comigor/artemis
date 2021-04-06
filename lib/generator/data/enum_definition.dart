import 'package:artemis/generator/data/definition.dart';
import 'package:artemis/generator/data/enum_value_definition.dart';
import 'package:artemis/generator/data_printer.dart';
import 'package:artemis/generator/helpers.dart';
import 'package:recase/recase.dart';

/// Define a Dart enum parsed from GraphQL schema.
class EnumDefinition extends Definition with DataPrinter {
  @override
  final EnumName name;

  /// The possible values of this enum.
  final Iterable<EnumValueDefinition> values;

  /// Instantiate an enum definition.
  EnumDefinition({
    required this.name,
    required this.values,
  })   : assert(hasValue(name) && hasValue(values)),
        super(name: name);

  @override
  Map<String, Object?> get namedProps => {
        'name': name,
        'values': values,
      };
}

/// Enum name
class EnumName extends Name with DataPrinter {
  /// Instantiate a enum name definition.
  EnumName({required String name}) : super(name: name);

  @override
  String normalize(String? name) {
    return ReCase(super.normalize(name)!).pascalCase;
  }

  @override
  Map<String, Object?> get namedProps => {
        'name': name,
      };
}
