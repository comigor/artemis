typedef U _IterableFunction<T, U>(T i);
typedef T _MergeableFunction<T>(T oldT, T newT);

/// Remove duplicated values from an iterable given a predicate without
/// modifying the original iterable.
Iterable<T> removeDuplicatedBy<T, U>(
    Iterable<T> list, _IterableFunction<T, U> fn) {
  final values = Map<U, bool>();
  return list.where((i) {
    final value = fn(i);
    return values.update(value, (_) => false, ifAbsent: () => true);
  }).toList();
}

/// Merge multiple values from an iterable given a predicate without modifying
/// the original iterable.
Iterable<T> mergeDuplicatesBy<T, U>(Iterable<T> list,
    _IterableFunction<T, U> fn, _MergeableFunction<T> mergeFn) {
  final values = Map<U, T>();
  list.forEach((i) {
    final value = fn(i);
    values.update(value, (oldI) => mergeFn(oldI, i), ifAbsent: () => i);
  });
  return values.values.toList();
}
