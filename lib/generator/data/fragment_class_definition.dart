import 'package:artemis/generator/data/class_property.dart';
import 'package:artemis/generator/data/definition.dart';
import 'package:artemis/generator/data_printer.dart';
import 'package:artemis/generator/helpers.dart';
import 'package:meta/meta.dart';
import 'package:recase/recase.dart';

/// Define a Dart class parsed from GraphQL fragment.
class FragmentClassDefinition extends Definition with DataPrinter {
  @override
  final FragmentName name;

  /// The properties (fields) of the class.
  final Iterable<ClassProperty> properties;

  /// Instantiate a fragment class definition.
  FragmentClassDefinition({
    @required this.name,
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
  factory FragmentName.fromPath({List<Name> path}) {
    return FragmentName(name: path.map((e) => e.namePrintable).join(r'$_'));
  }

  @override
  Map<String, Object> get namedProps => {
        'name': name,
      };

  @override
  String normalize(String name) {
    final normalizedName = ReCase(super.normalize(name)).pascalCase;
    if (normalizedName.endsWith('Mixin')) {
      return name;
    }
    return '${normalizedName}Mixin';
  }
}
