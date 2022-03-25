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

/// Define an exception thrown when Artemis does not find asset files
class MissingFilesException implements Exception {
  /// glob pattern which was used
  final String globPattern;

  /// Define an exception thrown when Artemis does not find asset files
  MissingFilesException(this.globPattern);

  @override
  String toString() {
    return 'Missing files for $globPattern';
  }
}

/// Define an exception thrown when Artemis does not find required config params
class MissingBuildConfigurationException implements Exception {
  /// missing config option name
  final String name;

  /// Define an exception thrown when Artemis does not find required config params
  MissingBuildConfigurationException(this.name);

  @override
  String toString() =>
      'Missing `$name` configuration option. Cehck `build.yaml` configuration';
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

/// Thrown when Artemis can't find the default (or configured) root object type
/// on schema.
class MissingRootTypeException implements Exception {
  /// Thrown when Artemis can't find the default (or configured) root object
  /// type on schema.
  const MissingRootTypeException(this.rootTypeName);

  /// The missing root type name.
  final String rootTypeName;

  @override
  String toString() => '''Can't find the "$rootTypeName" root type.
Make sure your schema file contains it.
''';
}

/// Thrown when Artemis can't find the requested fragment on schema.
class MissingFragmentException implements Exception {
  /// Thrown when Artemis can't find the requested fragment on schema.
  const MissingFragmentException(this.fragmentName, this.className);

  /// The missing fragment name.
  final String fragmentName;

  /// The class name in which the fragment is used.
  final String className;

  @override
  String toString() => '''Can't find the "$fragmentName" in "$className".
Make sure files inside `fragments_glob` or the query file contains it.
''';
}
