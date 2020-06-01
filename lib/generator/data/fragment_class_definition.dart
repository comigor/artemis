import 'package:artemis/generator/data/class_property.dart';
import 'package:artemis/generator/data/definition.dart';
import 'package:artemis/generator/data_printer.dart';
import 'package:artemis/generator/helpers.dart';
import 'package:meta/meta.dart';
import 'package:recase/recase.dart';

/// Define a Dart class parsed from GraphQL fragment.
class FragmentClassDefinition extends Definition with DataPrinter {
  /// The properties (fields) of the class.
  final Iterable<ClassProperty> properties;

  /// Instantiate a fragment class definition.
  FragmentClassDefinition({
    @required Name name,
    @required this.properties,
  })  : assert(hasValue(name) && hasValue(properties)),
        super(name: name);

  @override
  Map<String, Object> get namedProps => {
        'name': name,
        'properties': properties,
      };
}

/// Fragment name
class FragmentName extends Name with DataPrinter {
  /// Instantiate a fragment name definition.
  FragmentName({String name}) : super(name: name);

  /// Generate class name from hierarchical path
  factory FragmentName.fromPath({List<String> path}) {
    return FragmentName(name: path.join(r'$_'));
  }

  @override
  Map<String, Object> get namedProps => {
        'name': name,
      };

  @override
  String normalize(String name) {
    return '${ReCase(super.normalize(name)).pascalCase}Mixin';
  }
}
