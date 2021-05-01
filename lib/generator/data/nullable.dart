/// Allows to reset values back to null in `copyWith` pattern
class Nullable<T> {
  final T _value;

  /// Sets desired value
  Nullable(this._value);

  /// Gets the real value
  T get value {
    return _value;
  }
}
