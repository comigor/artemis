import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  test(
    'On union with nested types',
    () async => testGenerator(
      query: query,
      schema: graphQLSchema,
      libraryDefinition: libraryDefinition,
      generatedFile: generatedFile,
    ),
  );
}

final String query = r'''
  query checkoutById($checkoutId: ID!) {
    node(id: $checkoutId) {
        __typename
        ...on Checkout {
            id
            lineItems {
                id
                edges {
                    edges {
                        id
                    }
                }
            }
        }
    }
}
''';

final String graphQLSchema = '''
  schema {
    query: QueryRoot
  }
  
  interface Node {
      id: ID!
  }
  
  type Checkout implements Node {
      id: ID!
      lineItems: CheckoutLineItemConnection!
  }
  
  type CheckoutLineItem implements Node {
      id: ID!
  }
  
  type CheckoutLineItemConnection {
      id: ID!
      edges: [CheckoutLineItemEdge!]!
  }
  
  type CheckoutLineItemEdge {
      id: ID!
      edges: [ImageConnection]
      node: CheckoutLineItem!
  }
  
  type Image {
      id: ID
  }
  
  type ImageConnection {
      id: ID
      edges: [ImageEdge!]!
  }
  
  type ImageEdge {
      id: ID!
      node: Image!
  }
  
  type QueryRoot {
      node(
          id: ID!
      ): Node
  }
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'CheckoutById$_QueryRoot'),
      operationName: r'checkoutById',
      classes: [
        ClassDefinition(
            name: ClassName(
                name:
                    r'CheckoutById$_QueryRoot$_Node$_Checkout$_CheckoutLineItemConnection$_CheckoutLineItemEdge$_ImageConnection'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r'id'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(
                name:
                    r'CheckoutById$_QueryRoot$_Node$_Checkout$_CheckoutLineItemConnection$_CheckoutLineItemEdge'),
            properties: [
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: TypeName(
                          name:
                              r'CheckoutById$_QueryRoot$_Node$_Checkout$_CheckoutLineItemConnection$_CheckoutLineItemEdge$_ImageConnection'),
                      isNonNull: false),
                  name: ClassPropertyName(name: r'edges'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(
                name:
                    r'CheckoutById$_QueryRoot$_Node$_Checkout$_CheckoutLineItemConnection'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'id'),
                  isResolveType: false),
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: TypeName(
                          name:
                              r'CheckoutById$_QueryRoot$_Node$_Checkout$_CheckoutLineItemConnection$_CheckoutLineItemEdge',
                          isNonNull: true),
                      isNonNull: true),
                  name: ClassPropertyName(name: r'edges'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'CheckoutById$_QueryRoot$_Node$_Checkout'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'id'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(
                      name:
                          r'CheckoutById$_QueryRoot$_Node$_Checkout$_CheckoutLineItemConnection',
                      isNonNull: true),
                  name: ClassPropertyName(name: r'lineItems'),
                  isResolveType: false)
            ],
            extension: ClassName(name: r'CheckoutById$_QueryRoot$_Node'),
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'CheckoutById$_QueryRoot$_Node'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'__typename'),
                  annotations: [r'''JsonKey(name: '__typename')'''],
                  isResolveType: true)
            ],
            factoryPossibilities: {
              r'Checkout':
                  ClassName(name: r'CheckoutById$_QueryRoot$_Node$_Checkout')
            },
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'CheckoutById$_QueryRoot'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'CheckoutById$_QueryRoot$_Node'),
                  name: ClassPropertyName(name: r'node'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false)
      ],
      inputs: [
        QueryInput(
            type: DartTypeName(name: r'String', isNonNull: true),
            name: QueryInputName(name: r'checkoutId'))
      ],
      generateHelpers: false,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class CheckoutById$QueryRoot$Node$Checkout$CheckoutLineItemConnection$CheckoutLineItemEdge$ImageConnection
    extends JsonSerializable with EquatableMixin {
  CheckoutById$QueryRoot$Node$Checkout$CheckoutLineItemConnection$CheckoutLineItemEdge$ImageConnection();

  factory CheckoutById$QueryRoot$Node$Checkout$CheckoutLineItemConnection$CheckoutLineItemEdge$ImageConnection.fromJson(
          Map<String, dynamic> json) =>
      _$CheckoutById$QueryRoot$Node$Checkout$CheckoutLineItemConnection$CheckoutLineItemEdge$ImageConnectionFromJson(
          json);

  String? id;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [id, $$typename];
  @override
  Map<String, dynamic> toJson() =>
      _$CheckoutById$QueryRoot$Node$Checkout$CheckoutLineItemConnection$CheckoutLineItemEdge$ImageConnectionToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class CheckoutById$QueryRoot$Node$Checkout$CheckoutLineItemConnection$CheckoutLineItemEdge
    extends JsonSerializable with EquatableMixin {
  CheckoutById$QueryRoot$Node$Checkout$CheckoutLineItemConnection$CheckoutLineItemEdge();

  factory CheckoutById$QueryRoot$Node$Checkout$CheckoutLineItemConnection$CheckoutLineItemEdge.fromJson(
          Map<String, dynamic> json) =>
      _$CheckoutById$QueryRoot$Node$Checkout$CheckoutLineItemConnection$CheckoutLineItemEdgeFromJson(
          json);

  List<CheckoutById$QueryRoot$Node$Checkout$CheckoutLineItemConnection$CheckoutLineItemEdge$ImageConnection?>?
      edges;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [edges, $$typename];
  @override
  Map<String, dynamic> toJson() =>
      _$CheckoutById$QueryRoot$Node$Checkout$CheckoutLineItemConnection$CheckoutLineItemEdgeToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class CheckoutById$QueryRoot$Node$Checkout$CheckoutLineItemConnection
    extends JsonSerializable with EquatableMixin {
  CheckoutById$QueryRoot$Node$Checkout$CheckoutLineItemConnection();

  factory CheckoutById$QueryRoot$Node$Checkout$CheckoutLineItemConnection.fromJson(
          Map<String, dynamic> json) =>
      _$CheckoutById$QueryRoot$Node$Checkout$CheckoutLineItemConnectionFromJson(
          json);

  late String id;

  late List<
          CheckoutById$QueryRoot$Node$Checkout$CheckoutLineItemConnection$CheckoutLineItemEdge>
      edges;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [id, edges, $$typename];
  @override
  Map<String, dynamic> toJson() =>
      _$CheckoutById$QueryRoot$Node$Checkout$CheckoutLineItemConnectionToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class CheckoutById$QueryRoot$Node$Checkout extends CheckoutById$QueryRoot$Node
    with EquatableMixin {
  CheckoutById$QueryRoot$Node$Checkout();

  factory CheckoutById$QueryRoot$Node$Checkout.fromJson(
          Map<String, dynamic> json) =>
      _$CheckoutById$QueryRoot$Node$CheckoutFromJson(json);

  late String id;

  late CheckoutById$QueryRoot$Node$Checkout$CheckoutLineItemConnection
      lineItems;

  @JsonKey(name: '__typename')
  @override
  String? $$typename;

  @override
  List<Object?> get props => [id, lineItems, $$typename];
  @override
  Map<String, dynamic> toJson() =>
      _$CheckoutById$QueryRoot$Node$CheckoutToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CheckoutById$QueryRoot$Node extends JsonSerializable with EquatableMixin {
  CheckoutById$QueryRoot$Node();

  factory CheckoutById$QueryRoot$Node.fromJson(Map<String, dynamic> json) {
    switch (json['__typename'].toString()) {
      case r'Checkout':
        return CheckoutById$QueryRoot$Node$Checkout.fromJson(json);
      default:
    }
    return _$CheckoutById$QueryRoot$NodeFromJson(json);
  }

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [$$typename];
  @override
  Map<String, dynamic> toJson() {
    switch ($$typename) {
      case r'Checkout':
        return (this as CheckoutById$QueryRoot$Node$Checkout).toJson();
      default:
    }
    return _$CheckoutById$QueryRoot$NodeToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class CheckoutById$QueryRoot extends JsonSerializable with EquatableMixin {
  CheckoutById$QueryRoot();

  factory CheckoutById$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$CheckoutById$QueryRootFromJson(json);

  CheckoutById$QueryRoot$Node? node;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [node, $$typename];
  @override
  Map<String, dynamic> toJson() => _$CheckoutById$QueryRootToJson(this);
}
''';
