import 'package:artemis/generator/data.dart';

/// Define an exception thrown when duplicated classes names were generated.
class DuplicatedClassesException implements Exception {
  /// Define an exception thrown when duplicated classes names were generated.
  const DuplicatedClassesException(this.a, this.b);

  /// First duplicated class.
  final Definition a;

  /// Second duplicated class.
  final Definition b;

  @override
  String toString() =>
      '''Two classes were generated with the same name `${a.name}` 
but with different selection set.

Class A
${a.toString()}

Class B
${b.toString()}
''';
}

/// Define an exception thrown when `fragments_glob` used with the fragments inside query files
class FragmentIgnoreException implements Exception {
  /// Define an exception thrown when `fragments_glob` used with the fragments inside query files
  const FragmentIgnoreException();

  @override
  String toString() => '''It seems that you are using `fragments_glob` 
to specify fragments for all queries mapped in `schema_mapping` and using 
fragments inside query files.
If `fragments_glob` assigned, fragments defined in inside query files will be ignored.      
''';
}
