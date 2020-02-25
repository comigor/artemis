class DuplicatedClassesException implements Exception {
  const DuplicatedClassesException(
    this.allClassesNames,
    this.duplicatedClassName,
  );

  final Iterable<String> allClassesNames;
  final String duplicatedClassName;

  String toString() =>
      '''Two classes were generated with the same name `$duplicatedClassName`!
You may want to:
- Make queries_glob stricter, to gather less .graphql files on a single output
- Use alias on one of the places a field of type `$duplicatedClassName` is requested
- Change naming_scheme to `pathedWithFields` to avoid duplication

Classes: ${allClassesNames.join('\n')}''';
}
