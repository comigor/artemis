import 'package:equatable/equatable.dart';

import 'helpers.dart';

String _formatPrint(Object obj) {
  if (obj is List) {
    return '[${obj.map(_formatPrint).join(', ')}]';
  } else if (obj is String) {
    return 'r\'$obj\'';
  }
  final str = obj.toString();
  if (str.startsWith('Instance of')) {
    return null;
  }
  return str;
}

mixin DataPrinter on Equatable {
  Map<String, Object> get namedProps;

  @override
  List get props => namedProps.values.toList();

  @override
  String toString() {
    final params = namedProps.entries
        .map((e) =>
            hasValue(e.value) ? '${e.key}:${_formatPrint(e.value)}' : null)
        .where((o) => o != null)
        .join(', ');
    return '${this.runtimeType}($params)';
  }
}
