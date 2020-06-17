import 'package:artemis/generator/data_printer.dart';
import 'package:artemis/generator/helpers.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Abstract definition of an entity.
abstract class Definition extends Equatable with DataPrinter {
  /// The definition name.
  final Name name;

  /// Instantiate a definition.
  Definition({@required this.name});
}

/// Abstract name of an entity.
abstract class Name extends Equatable with DataPrinter {
  /// Raw name string
  final String name;

  /// Instantiate a name.
  Name({this.name}) : assert(hasValue(name));

  /// Name suitable for code printing
  String get namePrintable => normalize(name);

  /// type name safe to use for dart
  String get dartTypeSafe => namePrintable.replaceAll(RegExp(r'[<>]'), '');

  /// Name normalization function
  String normalize(String name) => normalizeName(name);
}
