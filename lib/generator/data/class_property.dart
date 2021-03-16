// @dart = 2.8

import 'package:artemis/generator/data/definition.dart';
import 'package:artemis/generator/data_printer.dart';
import 'package:artemis/generator/helpers.dart';
import 'package:meta/meta.dart';
import 'package:recase/recase.dart';

/// Define a property (field) from a class.
class ClassProperty extends Definition with DataPrinter {
  @override
  final ClassPropertyName name;

  /// The property type.
  final TypeName type;

  /// Some other custom annotation.
  final List<String> annotations;

  /// Whether this parameter is required
  @Deprecated('Use [type.isNonNull] instead')
  final bool isNonNull;

  /// Whether this parameter corresponds to the __resolveType (or equivalent)
  final bool isResolveType;

  /// Instantiate a property (field) from a class.
  ClassProperty({
    @required this.type,
    this.annotations = const [],
    this.isNonNull = false,
    this.isResolveType = false,
    @required this.name,
  })  : assert(hasValue(type) && hasValue(name)),
        super(name: name);

  /// If property is an override from super class.
  bool get isOverride => annotations.contains('override');

  /// Creates a copy of [ClassProperty] without modifying the original.
  ClassProperty copyWith({
    TypeName type,
    ClassPropertyName name,
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
    final normalized = super.normalize(name);
    final suffix = RegExp(r'.*(_+)$').firstMatch(normalized)?.group(1) ?? '';
    return ReCase(super.normalize(name)).camelCase + suffix;
  }

  @override
  Map<String, Object> get namedProps => {
        'name': name,
      };
}

const _camelCaseTypes = {'bool', 'double', 'int'};

/// Type name
class TypeName extends Name with DataPrinter {
  /// Instantiate a type name definition.
  TypeName({
    String name,
    this.isNonNull = false,
  }) : super(name: name);

  /// If this type is non-null
  final bool isNonNull;

  @override
  Map<String, Object> get namedProps => {
        'name': name,
        if (isNonNull) 'isNonNull': true,
      };

  @override
  List get props => [name, isNonNull];

  @override
  String normalize(String name) {
    final normalized = super.normalize(name);
    if (_camelCaseTypes.contains(normalized)) return normalized;

    return '${ReCase(normalized).pascalCase}${isNonNull ? '' : '?'}';
  }
}

/// Type name
class ListOfTypeName extends TypeName with DataPrinter {
  /// Instantiate a type name definition.
  ListOfTypeName({
    this.typeName,
    this.listIsNonNull = true,
  }) : super(name: typeName.name, isNonNull: typeName.isNonNull);

  /// Internal type name
  final TypeName typeName;

  /// If this list type is non-null
  final bool listIsNonNull;

  @override
  Map<String, Object> get namedProps => {
        'typeName': typeName,
        'listIsNonNull': listIsNonNull,
      };

  @override
  String normalize(String name) =>
      'List<${typeName.namePrintable}>${listIsNonNull ? '' : '?'}';
}
