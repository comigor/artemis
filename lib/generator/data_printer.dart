// @dart = 2.8

import 'package:equatable/equatable.dart';

import 'helpers.dart';

String _formatPrint(Object obj) {
  if (obj is Map) {
    return '{${obj.entries.map((e) => '${_formatPrint(e.key)}: ${_formatPrint(e.value)}').join(', ')}}';
  } else if (obj is Iterable) {
    return '[${obj.map(_formatPrint).join(', ')}]';
  } else if (obj is String) {
    final bt = obj.contains('\'');
    return 'r\'${bt ? '\'\'' : ''}$obj${bt ? '\'\'' : ''}\'';
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
    return '${runtimeType}($params)';
  }
}
