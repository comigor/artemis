typedef U _IterableFunction<T, U>(T i);

Iterable<T> removeDuplicatedBy<T, U>(
    Iterable<T> list, _IterableFunction<T, U> fn) {
  final values = Map<U, bool>();
  return list.where((i) {
    final value = fn(i);
    return values.update(value, (_) => false, ifAbsent: () => true);
  });
}
