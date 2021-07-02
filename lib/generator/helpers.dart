import 'package:artemis/generator/data/annotation.dart';
import 'package:artemis/generator/ephemeral_data.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:gql/ast.dart';

typedef _IterableFunction<T, U> = U Function(T i);
typedef _MergeableFunction<T> = T Function(T oldT, T newT);

/// a list of dart lang keywords
List<String> dartKeywords = const [
  'abstract',
  'else',
  'import',
  'super',
  'as',
  'enum',
  'in',
  'switch',
  'assert',
  'export',
  'interface',
  'sync',
  'async',
  'extends',
  'is',
  'this',
  'await',
  'extension',
  'library',
  'throw',
  'break',
  'external',
  'mixin',
  'true',
  'case',
  'factory',
  'new',
  'try',
  'catch',
  'false',
  'null',
  'typedef',
  'class',
  'final',
  'on',
  'var',
  'const',
  'finally',
  'operator',
  'void',
  'continue',
  'for',
  'part',
  'while',
  'covariant',
  'Function',
  'rethrow',
  'with',
  'default',
  'get',
  'return',
  'yield',
  'deferred',
  'hide',
  'set',
  'do',
  'if',
  'show',
  'dynamic',
  'implements',
  'static',
];

Iterable<T> _removeDuplicatedBy<T, U>(
    Iterable<T> list, _IterableFunction<T, U> fn) {
  final values = <U, bool>{};
  return list.where((i) {
    final value = fn(i);
    return values.update(value, (_) => false, ifAbsent: () => true);
  }).toList();
}

/// normalizes name
/// _variable => $variable
/// __typename => $$typename
/// new -> kw$new
String normalizeName(String name) {
  final regExp = RegExp(r'^(_+)([\w$]*)$');
  var matches = regExp.allMatches(name);

  if (matches.isNotEmpty) {
    var match = matches.elementAt(0);
    var fieldName = match.group(2)!;

    return fieldName.padLeft(name.length, r'$');
  }

  if (dartKeywords.contains(name.toLowerCase())) {
    return 'kw\$$name';
  }

  return name;
}

Iterable<T> _mergeDuplicatesBy<T, U>(Iterable<T> list,
    _IterableFunction<T, U> fn, _MergeableFunction<T> mergeFn) {
  final values = <U, T>{};
  list.forEach((i) {
    final value = fn(i);
    values.update(value, (oldI) => mergeFn(oldI, i), ifAbsent: () => i);
  });
  return values.values.toList();
}

/// Merge multiple values from an iterable given a predicate without modifying
/// the original iterable.
extension ExtensionsOnIterable<T, U> on Iterable<T> {
  /// Merge multiple values from an iterable given a predicate without modifying
  /// the original iterable.
  Iterable<T> mergeDuplicatesBy(
          _IterableFunction<T, U> fn, _MergeableFunction<T> mergeFn) =>
      _mergeDuplicatesBy(this, fn, mergeFn);

  /// Remove duplicated values from an iterable given a predicate without
  /// modifying the original iterable.
  Iterable<T> removeDuplicatedBy(_IterableFunction<T, U> fn) =>
      _removeDuplicatedBy(this, fn);
}

/// Check if [obj] has value (isn't null or empty).
bool hasValue(Object? obj) {
  if (obj is Iterable) {
    return obj.isNotEmpty;
  }
  return obj != null && obj.toString().isNotEmpty;
}

/// Proceeds deprecated annotation
List<Annotation> proceedDeprecated(
  List<DirectiveNode>? directives,
) {
  final annotations = <Annotation>[];

  final deprecatedDirective = directives?.firstWhereOrNull(
    (directive) => directive.name.value == 'deprecated',
  );

  if (deprecatedDirective != null) {
    final reasonValueNode = deprecatedDirective.arguments
        .firstWhereOrNull((argument) => argument.name.value == 'reason')
        ?.value;

    final reason = reasonValueNode is StringValueNode
        ? reasonValueNode.value
        : 'No longer supported';

    annotations.add(StringAnnotation(name: "Deprecated('$reason')"));
  }

  return annotations;
}

/// Logger function
void logFn(Context context, int align, Object logObject) {
  if (!context.log) return;
  log.fine('${List.filled(align, '|   ').join()}${logObject.toString()}');
}
