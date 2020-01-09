<p align="center">
  <img src="https://user-images.githubusercontent.com/735858/58768495-8ecbd600-8572-11e9-9321-4fa5ce4ea007.png" height="200">
  <h1><b>Artemis</b></h1>
</p>

**Build dart types from GraphQL schemas and queries**

<!-- Badges -->
[![Pub Package](https://img.shields.io/pub/v/artemis.svg)](https://pub.dev/packages/artemis)
[![GitHub Actions](https://github.com/comigor/artemis/workflows/test/badge.svg)](https://github.com/comigor/artemis/actions)

Artemis is a code generator that looks for `schema.json` (GraphQL Introspection Query response data) and `*.graphql` files and builds `.dart` files typing that query, based on the schema. That's similar to what [Apollo](https://github.com/apollographql/apollo-client) does (Artemis is his sister anyway).

---

## **Installation**
Add the following to your `pubspec.yaml` file to be able to do code generation:
```yaml
dev_dependencies:
  artemis: '>=2.0.0 <3.0.0'
  build_runner: ^1.5.0
  json_serializable: ^3.0.0
```
The generated code uses the following packages in run-time:
```yaml
dependencies:
  artemis: '>=2.0.0 <3.0.0' # only if you're using ArtemisClient!
  json_serializable: ^3.0.0
  equatable: ^0.6.1
  gql: '>=0.7.3 <1.0.0'
```

Then run:
```shell
pub packages get
```
or
```shell
flutter packages get
```

Now Artemis will generate the API files for you by running:
```shell
pub run build_runner build
```
or
```shell
flutter pub run build_runner build
```

## **Configuration**
Artemis offers some configuration options to generate code. All options should be included on `build.yaml` file on the root of the project:
```yaml
targets:
  $default:
    builders:
      artemis:
        options:
          # custom configuration options!
```

| Option | Default value | Description |
| - | - | - |
| `generate_helpers` | `true` | If Artemis should generate query/mutation helper GraphQLQuery subclasses. |
| `custom_parser_import` | `null` | Import path to the file implementing coercer functions for custom scalars. See [Custom scalars](#custom-scalars). |
| `scalar_mapping` | `[]` | Mapping of GraphQL and Dart types. See [Custom scalars](#custom-scalars). |
| `schema_mapping` | `[]` | Mapping of queries and which schemas they will use for code generation. See [Schema mapping](#schema-mapping). |
| `fragments_glob` | `null` | Import path to the file implementing fragments which is mapping to all queries in schema_mapping. If it's assigned, fragments is defined in schemap_mapping will be ignored. |

It's important to remember that, by default, [build](https://github.com/dart-lang/build) will follow [Dart's package layout conventions](https://dart.dev/tools/pub/package-layout), meaning that only some folders will be considered to parse the input files. So, if you want to reference files from a folder other than `lib/`, make sure you've included it on `sources`:
```yaml
targets:
  $default:
    sources:
      - lib/**
      - graphql/**
      - data/**
      - schema.json
```

### **Schema mapping**
By default, Artemis won't generate anything. That's because your queries/mutations should be linked to GraphQL schemas. To configure it, you need to point a `schema_mapping` to the path of those queries and schemas:

```yaml
targets:
  $default:
    builders:
      artemis:
        options:
          schema_mapping:
            - output: lib/graphql_api.dart
              schema: lib/my_graphql_schema.json
              queries_glob: lib/**.graphql
```

Each `SchemaMap` is configured this way:

| Option | Default value | Description |
| - | - | - |
| `output` |  | Relative path to output the generated code. |
| `schema` |  | Relative path to the GraphQL schema. |
| `queries_glob` |  | Glob that selects all query files to be used with this schema. |
| `resolve_type_field` | `__resolveType` | The name of the field used to differentiatiate interfaces and union types (commonly `__resolveType` or `__typename`). Note that `__resolveType` field are not added automatically to the query. If you want interface/union type resolution, you need to manually add it to the query. |
| `add_query_prefix` | `false` | Wheter to add the name of the query as a prefix for each dependent object of this query input or response. |

See [examples](./example) for more information and configuration options.

### **Custom scalars**
If your schema uses custom scalars, they must be defined on `build.yaml`. If it needs a custom parser (to decode from/to json), the `custom_parser_import` path must be set and the file must implement both `fromGraphQL___ToDart___` and `fromDart___toGraphQL___` constant functions.

```yaml
targets:
  $default:
    builders:
      artemis:
        options:
          custom_parser_import: 'package:graphbrainz_example/coercers.dart'
          scalar_mapping:
            - graphql_type: Date
              dart_type: DateTime
```

If your custom scalar needs to import Dart libraries, you can provide it in the config as well:

```yaml
targets:
  $default:
    builders:
      artemis:
        options:
          custom_parser_import: 'package:graphbrainz_example/coercers.dart'
          scalar_mapping:
            - graphql_type: BigDecimal
              dart_type:
                name: Decimal
                imports:
                  - 'package:decimal/decimal.dart'
```

Each `ScalarMap` is configured this way:

| Option | Default value | Description |
| - | - | - |
| `graphql_type` |  | The GraphQL custom scalar name on schema. |
| `dart_type` |  | The Dart type this custom scalar should be converted from/to. |
| `use_custom_parser` | `false` | Wheter `custom_parser_import` should be imported on the beginning of the file. |

See [examples](./example) for more information and configuration options.

## **ArtemisClient**
If you have `generate_helpers`, Artemis will create a subclass of `GraphQLQuery` for you, this class can be used
in conjunction with `ArtemisClient`.

```dart
final client = ArtemisClient('/graphql');
final gitHubReposQuery = MyGitHubReposQuery();
final response = await client.execute(gitHubReposQuery);
```

`ArtemisClient` adds type-awareness around `Link` from [`package:gql/link`](https://pub.dev/packages/gql).
You can create `ArtemisClient` from any `Link` using `ArtemisClient.fromLink`.
 
Check the [examples](./example) to see how to use it in details.
