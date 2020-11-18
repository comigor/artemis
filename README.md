<p align="center">
  <img src="https://user-images.githubusercontent.com/735858/58768495-8ecbd600-8572-11e9-9321-4fa5ce4ea007.png" height="200">
  <h1><b>Artemis</b></h1>
</p>

**Build dart types from GraphQL schemas and queries**

<!-- Badges -->
[![View at pub.dev][pub-badge]][pub-link]
[![Test][actions-badge]][actions-link]
[![PRs Welcome][prs-badge]][prs-link]
[![Star on GitHub][github-star-badge]][github-star-link]
[![Fork on GitHub][github-forks-badge]][github-forks-link]
[![Discord][discord-badge]][discord-link]

[pub-badge]: https://img.shields.io/pub/v/artemis?style=for-the-badge
[pub-link]: https://pub.dev/packages/artemis

[actions-badge]: https://img.shields.io/github/workflow/status/comigor/artemis/test?style=for-the-badge
[actions-link]: https://github.com/comigor/artemis/actions

[prs-badge]: https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=for-the-badge
[prs-link]: https://github.com/comigor/artemis/issues

[github-star-badge]: https://img.shields.io/github/stars/comigor/artemis.svg?style=for-the-badge&logo=github&logoColor=ffffff
[github-star-link]: https://github.com/comigor/artemis/stargazers

[github-forks-badge]: https://img.shields.io/github/forks/comigor/artemis.svg?style=for-the-badge&logo=github&logoColor=ffffff
[github-forks-link]: https://github.com/comigor/artemis/network/members

[discord-badge]: https://img.shields.io/discord/559455668810153989.svg?style=for-the-badge&logo=discord&logoColor=ffffff
[discord-link]: https://discord.gg/2Y4wdE4

Check the [**beta**](https://github.com/comigor/artemis/tree/beta) branch for the bleeding edge (and breaking) stuff.

Artemis is a code generator that looks for `schema.graphql` (GraphQL SDL - Schema Definition Language) and `*.graphql` files and builds `.graphql.dart` files typing that query, based on the schema. That's similar to what [Apollo](https://github.com/apollographql/apollo-client) does (Artemis is his sister anyway).

---

## **Installation**
Add the following to your `pubspec.yaml` file to be able to do code generation:
```yaml
dev_dependencies:
  artemis: '>=6.0.0 <7.0.0'
  build_runner: ^1.10.4
  json_serializable: ^3.5.0
```
The generated code uses the following packages in run-time:
```yaml
dependencies:
  artemis: '>=6.0.0 <7.0.0' # only if you're using ArtemisClient!
  json_annotation: ^3.1.0
  equatable: ^1.2.5
  meta: '>=1.0.0 <2.0.0' # only if you have non nullable fields
  gql: '>=0.12.3 <1.0.0'
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
| `scalar_mapping` | `[]` | Mapping of GraphQL and Dart types. See [Custom scalars](#custom-scalars). |
| `schema_mapping` | `[]` | Mapping of queries and which schemas they will use for code generation. See [Schema mapping](#schema-mapping). |
| `fragments_glob` | `null` | Import path to the file implementing fragments for all queries mapped in schema_mapping. If it's assigned, fragments defined in schema_mapping will be ignored. |
| `ignore_for_file` | `[]`  | The linter rules to ignore for artemis generated files. |

It's important to remember that, by default, [build](https://github.com/dart-lang/build) will follow [Dart's package layout conventions](https://dart.dev/tools/pub/package-layout), meaning that only some folders will be considered to parse the input files. So, if you want to reference files from a folder other than `lib/`, make sure you've included it on `sources`:
```yaml
targets:
  $default:
    sources:
      - lib/**
      - graphql/**
      - data/**
      - schema.graphql
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
              schema: lib/my_graphql_schema.graphql
              queries_glob: lib/**.graphql
```

Each `SchemaMap` is configured this way:

| Option | Default value | Description |
| - | - | - |
| `output` |  | Relative path to output the generated code. It should end with `.graphql.dart` or else the generator will need to generate one more file. |
| `schema` |  | Relative path to the GraphQL schema. |
| `queries_glob` |  | Glob that selects all query files to be used with this schema. |
| `naming_scheme` | `pathedWithTypes` | The naming scheme to be used on generated classes names. `pathedWithTypes` is the default for retrocompatibility, where the names of previous types are used as prefix of the next class. This can generate duplication on certain schemas. With `pathedWithFields`, the names of previous fields are used as prefix of the next class and with `simple`, only the actual GraphQL class nameis considered. | 
| `type_name_field` | `__typename` | The name of the field used to differentiatiate interfaces and union types (commonly `__typename` or `__resolveType`). Note that `__typename` field are not added automatically to the query. If you want interface/union type resolution, you need to manually add it there. |

See [examples](./example) for more information and configuration options.

### **Custom scalars**
If your schema uses custom scalars, they must be defined on `build.yaml`. If it needs a custom parser (to decode from/to json), the `custom_parser_import` path must be set and the file must implement both `fromGraphQL___ToDart___` and `fromDart___toGraphQL___` constant functions.

```yaml
targets:
  $default:
    builders:
      artemis:
        options:
          scalar_mapping:
            - custom_parser_import: 'package:graphbrainz_example/coercers.dart'
              graphql_type: Date
              dart_type: DateTime
```

If your custom scalar needs to import Dart libraries, you can provide it in the config as well:

```yaml
targets:
  $default:
    builders:
      artemis:
        options:
          scalar_mapping:
            - custom_parser_import: 'package:graphbrainz_example/coercers.dart'
              graphql_type: BigDecimal
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
| `custom_parser_import` | `null` | Import path to the file implementing coercer functions for custom scalars. See [Custom scalars](#custom-scalars). |

See [examples](./example) for more information and configuration options.

## **Articles and videos**

1. [Ultimate toolchain to work with GraphQL in Flutter](https://medium.com/@v.ditsyak/ultimate-toolchain-to-work-with-graphql-in-flutter-13aef79c6484)
2. [Awesome GraphQL](https://github.com/chentsulin/awesome-graphql)

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
