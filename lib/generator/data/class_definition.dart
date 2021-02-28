import 'package:artemis/generator/data/class_property.dart';
import 'package:artemis/generator/data/definition.dart';
import 'package:artemis/generator/data/fragment_class_definition.dart';
import 'package:artemis/generator/data_printer.dart';
import 'package:artemis/generator/helpers.dart';
import 'package:recase/recase.dart';

/// Define a Dart class parsed from GraphQL type.
class ClassDefinition extends Definition with DataPrinter {
  /// The properties (fields) of the class.
  final Iterable<ClassProperty> properties;

  /// The type this class extends from, or [null].
  final Name? extension;

  /// The types this class implements.
  final Iterable<String> implementations;

  /// The types this class mixins.
  final Iterable<FragmentName> mixins;

  /// The types possibilities (GraphQL type -> class name) the class
  /// implements, if it's part of an union type or interface.
  final Map<String, Name> factoryPossibilities;

  /// The field name used to resolve this class type.
  final TypeName typeNameField;

  /// Whether this is an input object or not.
  final bool isInput;

  /// Instantiate a class definition.
  ClassDefinition({
    required Name name,
    this.properties = const [],
    this.extension,
    this.implementations = const [],
    this.mixins = const [],
    this.factoryPossibilities = const {},
    TypeName? typeNameField,
    this.isInput = false,
  })  : assert(hasValue(name)),
        typeNameField = typeNameField ?? TypeName(name: '__typename'),
        super(name: name);

  @override
  Map<String, Object?> get namedProps => {
        'name': name,
        'properties': properties,
        'extension': extension,
        'implementations': implementations,
        'mixins': mixins,
        'factoryPossibilities': factoryPossibilities,
        'typeNameField': typeNameField,
        'isInput': isInput,
      };
}

/// Class name.
class ClassName extends Name with DataPrinter {
  /// Instantiate a class name definition.
  ClassName({String? name}) : super(name: name);

  /// Generate class name from hierarchical path
  factory ClassName.fromPath({required List<Name?> path}) {
    return ClassName(name: path.map((e) => e!.namePrintable).join(r'$_'));
  }

  @override
  Map<String, Object?> get namedProps => {
        'name': name,
      };

  @override
  String normalize(String? name) {
    return ReCase(super.normalize(name)!).pascalCase;
  }
}
