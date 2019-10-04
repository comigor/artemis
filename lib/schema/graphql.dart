import 'package:json_annotation/json_annotation.dart';

// I can't use the default json_serializable flow because the artemis generator
// would crash when importing graphql.dart file.
part 'graphql.g2.dart';

// https://github.com/graphql/graphql-js/blob/master/src/utilities/introspectionQuery.js
// https://github.com/graphql/graphql-js/blob/master/src/type/introspection.js
// https://gist.github.com/Igor1201/8bf5b3ca05d853fe93e685c53f2f726d

/// Represents a GraphQL schema.
@JsonSerializable()
class GraphQLSchema {
  /// A list of GraphQL types in this schema.
  final List<GraphQLType> types;

  /// The GraphQL query type in this schema.
  final GraphQLType queryType;

  /// The GraphQL mutation type in this schema.
  final GraphQLType mutationType;

  /// The GraphQL subscription type in this schema.
  final GraphQLType subscriptionType;

  /// A list of GraphQL directives in this schema.
  final List<GraphQLDirective> directives;

  /// Instantiates a GraphQL schema.
  GraphQLSchema({
    List<GraphQLType> types,
    this.queryType,
    this.mutationType,
    this.subscriptionType,
    List<GraphQLDirective> directives,
  })  : types = types ?? <GraphQLType>[],
        directives = directives ?? <GraphQLDirective>[];

  /// Build a GraphQL schema from a JSON map.
  factory GraphQLSchema.fromJson(Map<String, dynamic> json) {
    // Support finding '__schema' nested under 'data' or not.
    // Graphql codegen generates the __schema field at the top level.
    assert(
        json != null &&
            ((json['data'] != null && json['data']['__schema'] != null) ||
                json['__schema'] != null),
        'JSON schema file must be the output of an Introspection Query.');

    if (json['__schema'] != null) {
      return _$GraphQLSchemaFromJson(json['__schema'] as Map<String, dynamic>);
    }

    return _$GraphQLSchemaFromJson(
        json['data']['__schema'] as Map<String, dynamic>);
  }

  /// Convert this GraphQL schema instance to JSON.
  Map<String, dynamic> toJson() => _$GraphQLSchemaToJson(this);
}

/// Represents a GraphQL directive.
@JsonSerializable()
class GraphQLDirective {
  /// The directive name.
  final String name;

  /// The directive description.
  final String description;

  /// A list of locations of this directive.
  List<GraphQLDirectiveLocation> locations;

  /// A list of arguments of this directive.
  List<GraphQLInputValue> args;

  /// Instantiates a GraphQL directive.
  GraphQLDirective({
    this.name,
    this.description,
    List<GraphQLDirectiveLocation> locations,
    List<GraphQLInputValue> args,
  })  : args = args ?? <GraphQLInputValue>[],
        locations = locations ?? <GraphQLDirectiveLocation>[];

  /// Build a GraphQL directive from a JSON map.
  factory GraphQLDirective.fromJson(Map<String, dynamic> json) =>
      _$GraphQLDirectiveFromJson(json);

  /// Convert this GraphQL directive instance to JSON.
  Map<String, dynamic> toJson() => _$GraphQLDirectiveToJson(this);
}

/// An enum of GraphQL directive locations.
enum GraphQLDirectiveLocation {
  /// QUERY
  QUERY,

  /// MUTATION
  MUTATION,

  /// SUBSCRIPTION
  SUBSCRIPTION,

  /// FIELD
  FIELD,

  /// FRAGMENT_DEFINITION
  FRAGMENT_DEFINITION,

  /// FRAGMENT_SPREAD
  FRAGMENT_SPREAD,

  /// INLINE_FRAGMENT
  INLINE_FRAGMENT,

  /// VARIABLE_DEFINITION
  VARIABLE_DEFINITION,

  /// SCHEMA
  SCHEMA,

  /// SCALAR
  SCALAR,

  /// OBJECT
  OBJECT,

  /// FIELD_DEFINITION
  FIELD_DEFINITION,

  /// ARGUMENT_DEFINITION
  ARGUMENT_DEFINITION,

  /// INTERFACE
  INTERFACE,

  /// UNION
  UNION,

  /// ENUM
  ENUM,

  /// ENUM_VALUE
  ENUM_VALUE,

  /// INPUT_OBJECT
  INPUT_OBJECT,

  /// INPUT_FIELD_DEFINITION
  INPUT_FIELD_DEFINITION,
}

/// Represents a GraphQL type.
@JsonSerializable()
class GraphQLType {
  /// Type kind.
  final GraphQLTypeKind kind;

  /// Type name.
  final String name;

  /// Type description.
  final String description;

  /// Type fields.
  final List<GraphQLField> fields;

  /// Type interfaces.
  final List<GraphQLType> interfaces;

  /// Possible super type.
  final List<GraphQLType> possibleTypes;

  /// Possible enum values.
  final List<GraphQLEnumValue> enumValues;

  /// Input fields.
  final List<GraphQLInputValue> inputFields;

  /// Chain of types this follows.
  final GraphQLType ofType;

  /// Instantiates a GraphQL type.
  GraphQLType({
    this.kind,
    this.name,
    this.description,
    List<GraphQLField> fields,
    List<GraphQLType> interfaces,
    List<GraphQLType> possibleTypes,
    List<GraphQLEnumValue> enumValues,
    List<GraphQLInputValue> inputFields,
    this.ofType,
  })  : fields = fields ?? <GraphQLField>[],
        inputFields = inputFields ?? <GraphQLInputValue>[],
        interfaces = interfaces ?? <GraphQLType>[],
        enumValues = enumValues ?? <GraphQLEnumValue>[],
        possibleTypes = possibleTypes ?? <GraphQLType>[];

  /// Build a GraphQL type from a JSON map.
  factory GraphQLType.fromJson(Map<String, dynamic> json) =>
      _$GraphQLTypeFromJson(json);

  /// Convert this GraphQL type instance to JSON.
  Map<String, dynamic> toJson() => _$GraphQLTypeToJson(this);
}

/// Defines kinds of GraphQL types.
enum GraphQLTypeKind {
  /// Ths most basic (leaf) type on GraphQL.
  SCALAR,

  /// Objects are a collection of other objects to fetch data from server.
  OBJECT,

  /// An Interface is an abstract type that includes a certain set of fields
  /// that a type must include to implement the interface.
  INTERFACE,

  /// Union types are very similar to interfaces, but they don't get to
  /// specify any common fields between the types
  UNION,

  /// Enum is a special kind of scalar that is restricted to a particular set
  /// of allowed values.
  ENUM,

  /// Complex objects to be sent to server.
  INPUT_OBJECT,

  /// List type modifier.
  LIST,

  /// Non-null type modifier.
  NON_NULL,
}

/// Represents a GraphQL field.
@JsonSerializable()
class GraphQLField {
  /// Field name.
  final String name;

  /// Field description.
  final String description;

  /// Field arguments.
  final List<GraphQLInputValue> args;

  /// Field type.
  final GraphQLType type;

  /// If field is deprecated.
  final bool isDeprecated;

  /// Why this field is deprecated.
  final String deprecatedReason;

  /// Instantiates a GraphQL field.
  GraphQLField({
    this.name,
    this.description,
    List<GraphQLInputValue> args,
    this.type,
    this.isDeprecated,
    this.deprecatedReason,
  }) : args = args ?? <GraphQLInputValue>[];

  /// Build a GraphQL field from a JSON map.
  factory GraphQLField.fromJson(Map<String, dynamic> json) =>
      _$GraphQLFieldFromJson(json);

  /// Convert this GraphQL field instance to JSON.
  Map<String, dynamic> toJson() => _$GraphQLFieldToJson(this);
}

/// Represents a GraphQL input value.
@JsonSerializable()
class GraphQLInputValue {
  /// Input value name.
  final String name;

  /// Input value description.
  final String description;

  /// Input value type.
  final GraphQLType type;

  /// Default value for this input type.
  final String defaultValue;

  /// Instantiates a GraphQL input value.
  GraphQLInputValue({
    this.name,
    this.description,
    this.type,
    this.defaultValue,
  });

  /// Build a GraphQL input value from a JSON map.
  factory GraphQLInputValue.fromJson(Map<String, dynamic> json) =>
      _$GraphQLInputValueFromJson(json);

  /// Convert this GraphQL input value instance to JSON.
  Map<String, dynamic> toJson() => _$GraphQLInputValueToJson(this);
}

/// Represents a GraphQL enum.
@JsonSerializable()
class GraphQLEnumValue {
  /// Enum name.
  final String name;

  /// Enum description.
  final String description;

  /// If this enum is deprecated.
  final bool isDeprecated;

  /// Why this enum is deprecated.
  final String deprecatedReason;

  /// Instantiates a GraphQL enum value.
  GraphQLEnumValue({
    this.name,
    this.description,
    this.isDeprecated,
    this.deprecatedReason,
  });

  /// Build a GraphQL enum value from a JSON map.
  factory GraphQLEnumValue.fromJson(Map<String, dynamic> json) =>
      _$GraphQLEnumValueFromJson(json);

  /// Convert this GraphQL enum value instance to JSON.
  Map<String, dynamic> toJson() => _$GraphQLEnumValueToJson(this);
}
