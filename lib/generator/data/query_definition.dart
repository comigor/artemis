import 'package:artemis/generator/data/class_definition.dart';
import 'package:artemis/generator/data/definition.dart';
import 'package:artemis/generator/data/query_input.dart';
import 'package:artemis/generator/data_printer.dart';
import 'package:artemis/generator/helpers.dart';
import 'package:gql/ast.dart';
import 'package:recase/recase.dart';

/// Define a GraphQL query and its dependencies.
class QueryDefinition extends Definition with DataPrinter {
  /// graphql operation name for helper classes
  final String operationName;

  /// The AST representation of GraphQL document.
  final DocumentNode document;

  /// A list of classes related to this query.
  final Iterable<Definition> classes;

  /// A list of inputs related to this query.
  final Iterable<QueryInput> inputs;

  /// If instances of [GraphQLQuery] should be generated.
  final bool generateHelpers;

  /// The suffix of generated [GraphQLQuery] classes.
  final String suffix;

  /// Instantiate a query definition.
  QueryDefinition({
    required Name name,
    required this.operationName,
    this.document = const DocumentNode(),
    this.classes = const [],
    this.inputs = const [],
    this.generateHelpers = false,
    this.suffix = 'Query',
  })  : assert(hasValue(name) && hasValue(operationName)),
        super(name: name);

  /// class name for helper classes
  String? get className => ClassName(name: operationName).namePrintable;

  @override
  Map<String, Object?> get namedProps => {
        'name': name,
        'operationName': operationName,
        'classes': classes,
        'inputs': inputs,
        'generateHelpers': generateHelpers,
        'suffix': suffix,
      };
}

/// Query name
class QueryName extends Name with DataPrinter {
  /// Instantiate a query name definition.
  QueryName({String? name}) : super(name: name);

  /// Generate class name from hierarchical path
  factory QueryName.fromPath({required List<Name?> path}) {
    return QueryName(name: path.map((e) => e!.namePrintable).join(r'$_'));
  }

  @override
  Map<String, Object?> get namedProps => {
        'name': name,
      };

  @override
  String normalize(String? name) {
    return ReCase(super.normalize(name)!).pascalCase;
  }
}
