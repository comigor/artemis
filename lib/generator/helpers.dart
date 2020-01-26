import 'data.dart';

typedef _IterableFunction<T, U> = U Function(T i);
typedef _MergeableFunction<T> = T Function(T oldT, T newT);

/// Remove duplicated values from an iterable given a predicate without
/// modifying the original iterable.
Iterable<T> removeDuplicatedBy<T, U>(
    Iterable<T> list, _IterableFunction<T, U> fn) {
  final values = <U, bool>{};
  return list.where((i) {
    final value = fn(i);
    return values.update(value, (_) => false, ifAbsent: () => true);
  }).toList();
}

/// Merge multiple values from an iterable given a predicate without modifying
/// the original iterable.
Iterable<T> mergeDuplicatesBy<T, U>(Iterable<T> list,
    _IterableFunction<T, U> fn, _MergeableFunction<T> mergeFn) {
  final values = <U, T>{};
  list.forEach((i) {
    final value = fn(i);
    values.update(value, (oldI) => mergeFn(oldI, i), ifAbsent: () => i);
  });
  return values.values.toList();
}

/// checks if the passed queries contain at least one non nullable field
bool hasNonNullableInput(Iterable<QueryDefinition> queries) {
  for (final query in queries) {
    for (final input in query.inputs) {
      if (input.isNonNull) {
        return true;
      }
    }
  }

  return false;
}

/// Check if [obj] has value (isn't null or empty).
bool hasValue(Object obj) {
  if (obj is Iterable) {
    return obj != null && obj.isNotEmpty;
  }
  return obj != null && obj.toString().isNotEmpty;
}
