import 'package:artemis/generator/data/definition.dart';
import 'package:artemis/generator/data_printer.dart';
import 'package:artemis/generator/helpers.dart';
import 'package:meta/meta.dart';

/// Define a property (field) from a class.
class ClassProperty extends Definition with DataPrinter {
  /// The property type.
  final TypeName type;

  /// Some other custom annotation.
  final List<String> annotations;

  /// Whether this parameter is required
  final bool isNonNull;

  /// Whether this parameter corresponds to the __resolveType (or equivalent)
  final bool isResolveType;

  /// Instantiate a property (field) from a class.
  ClassProperty({
    @required this.type,
    this.annotations = const [],
    this.isNonNull = false,
    this.isResolveType = false,
    @required Name name,
  })  : assert(hasValue(type) && hasValue(name)),
        super(name: name);

  /// If property is an override from super class.
  bool get isOverride => annotations.contains('override');

  /// Creates a copy of [ClassProperty] without modifying the original.
  ClassProperty copyWith({
    TypeName type,
    Name name,
    List<String> annotations,
    bool isNonNull,
    bool isResolveType,
  }) =>
      ClassProperty(
        type: type ?? this.type,
        name: name ?? this.name,
        annotations: annotations ?? this.annotations,
        isNonNull: isNonNull ?? this.isNonNull,
        isResolveType: isResolveType ?? this.isResolveType,
      );

  @override
  Map<String, Object> get namedProps => {
        'type': type,
        'name': name,
        'annotations': annotations,
        'isNonNull': isNonNull,
        'isResolveType': isResolveType,
      };
}

/// Class property name
class ClassPropertyName extends Name with DataPrinter {
  /// Instantiate a class property name definition.
  ClassPropertyName({String name}) : super(name: name);

  @override
  String normalize(String name) {
    return normalizeName(name);
  }

  @override
  Map<String, Object> get namedProps => {
        'name': name,
      };
}

/// Type name
class TypeName extends Name with DataPrinter {
  /// Instantiate a type name definition.
  TypeName({String name}) : super(name: name);

  @override
  Map<String, Object> get namedProps => {
        'name': name,
      };
}
