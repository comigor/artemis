import 'package:artemis/generator/data/data.dart';

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

/// Define an exception thrown when `fragments_glob` used with the fragments
/// inside query files
class FragmentIgnoreException implements Exception {
  /// Define an exception thrown when `fragments_glob` used with the fragments
  /// inside query files
  const FragmentIgnoreException();

  @override
  String toString() => '''It seems that you are using `fragments_glob` 
to specify fragments for all queries mapped in `schema_mapping` and using 
fragments inside query files.
If `fragments_glob` assigned, fragments defined in inside query files will be ignored.      
''';
}

/// Define an exception thrown when `queries_glob` configuration contains the
/// `schema` (Artemis would try to generate the schema as a query).
class QueryGlobsSchemaException implements Exception {
  /// Define an exception thrown when `queries_glob` configuration contains the
  /// `schema` (Artemis would try to generate the schema as a query).
  const QueryGlobsSchemaException();

  @override
  String toString() =>
      '''One of your `queries_glob` configuration contains the path to the `schema` file!
Change `schema` file location and try again.
''';
}

/// Define an exception thrown when `queries_glob` configuration contains `output`.
class QueryGlobsOutputException implements Exception {
  /// Define an exception thrown when `queries_glob` configuration contains `output`.
  const QueryGlobsOutputException();

  @override
  String toString() =>
      '''One of your `queries_glob` configuration contains the path to the `output` file!
Change `schema` or `output` location and try again.
''';
}

/// Define an exception thrown when Artemis find a scalar on schema but it's
/// not configured on `build.yaml`.
class MissingScalarConfigurationException implements Exception {
  /// Define an exception thrown when Artemis find a scalar on schema but it's
  /// not configured on `build.yaml`.
  const MissingScalarConfigurationException(this.scalarName);

  /// The misconfigured scalar name.
  final String scalarName;

  @override
  String toString() =>
      '''Your `schema` file contains "$scalarName" scalar, but this scalar is not
configured on `build.yaml`!
Please configure it, following the README on `scalar_mapping`.
''';
}
