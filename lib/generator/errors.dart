/// Define an exception thrown when duplicated classes names were generated.
class DuplicatedClassesException implements Exception {
  /// Define an exception thrown when duplicated classes names were generated.
  const DuplicatedClassesException(
    this.allClassesNames,
    this.duplicatedClassName,
  );

  /// The list of all generated classes names.
  final Iterable<String> allClassesNames;

  /// The name of the first class with duplicated name.
  final String duplicatedClassName;

  @override
  String toString() =>
      '''Two classes were generated with the same name `$duplicatedClassName`!
You may want to:
- Make queries_glob stricter, to gather less .graphql files on a single output
- Use alias on one of the places a field of type `$duplicatedClassName` is requested
- Change naming_scheme to `pathedWithFields` to avoid duplication

Classes: ${allClassesNames.join('\n')}''';
}
