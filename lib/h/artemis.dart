// @dart = 2.12
// ignore_for_file: public_member_api_docs

/// Creating this just so we can separate what's a selection set and what's not.
/// SelectionSet classes shouldn't be used/instantiated directly. Should we start them with underscores?
abstract class SelectionSet {}

mixin ToCanonical<T> {
  T toCanonical();
}

mixin ToConcrete<T> {
  T toConcrete();
}
