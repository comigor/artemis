// @dart = 2.8

import 'package:artemis/generator/data/class_property.dart';
import 'package:artemis/generator/data/definition.dart';
import 'package:artemis/generator/data_printer.dart';
import 'package:artemis/generator/helpers.dart';
import 'package:meta/meta.dart';

/// Define a query/mutation input parameter.
class QueryInput extends Definition with DataPrinter {
  @override
  final QueryInputName name;

  /// The input type.
  final TypeName type;

  /// Some other custom annotation.
  final List<String> annotations;

  /// Instantiate an input parameter.
  QueryInput({
    @required this.type,
    this.annotations = const [],
    this.name,
  })  : assert(hasValue(type) && hasValue(name)),
        super(name: name);

  @override
  Map<String, Object> get namedProps => {
        'type': type,
        'name': name,
        'annotations': annotations,
      };
}

///
class QueryInputName extends Name {
  ///
  QueryInputName({String name}) : super(name: name);

  @override
  Map<String, Object> get namedProps => {
        'name': name,
      };
}
