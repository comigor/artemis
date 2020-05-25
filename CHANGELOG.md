# CHANGELOG

## 6.2.0-beta.1
**MAJOR BREAKING CHANGE**

We've found a regression on `6.1.0-beta.1`, which sends Enums as camelCase to
the server, when they should be sent as SCREAMING_SNAKE_CASE.

- Reverts `6.1.0-beta.1`.

## 6.1.1-beta.2
- Improve actions and check pipeline output.

## 6.1.1-beta.1
- Short-circuit input object generation on recursive detection

## 6.1.0-beta.1
**MAJOR BREAKING CHANGE**

- Convert enum casing to camel case.

## 6.0.11-beta.1
- Convert `ClassProperty` annotation item to `List<String>`.

## 6.0.10-beta.1
- Duplication bug fix

## 6.0.9-beta.1
- Added the exception for the case when `fragment_glob` leads to query files fragments ignore.

## 6.0.8-beta.1
- Adapt Artemis to subscriptions and create an example

## 6.0.7-beta.1
- Fix for the interfaces which uses fragments from fragments_glob

## 6.0.6-beta.1
- Hide build logs under `--verbose` flag

## 6.0.5-beta.1
- Include coercers annotations on custom scalars on input objects.

## 6.0.4-beta.1
- Properly consider "sub-fragments" on class generation.

## 6.0.3-beta.1
- Fix generation of custom scalars and its functions.

## 6.0.2-beta.1
- Fix invalid reference to class on Query generations.

## 6.0.1-beta.1
- End forwarder file with a newline.

## 6.0.0-beta.1
**MAJOR BREAKING CHANGE**

- Generate canonical objects (enums and input objects) with their original
names on GraphQL. Fragments are also generated with their own names (plus the `Mixin` prefix, for now).
- Make it possible to select a naming scheme to be used for generate the class
names. `pathedWithTypes` is the default for retrocompatibility, where the names
of previous types are used as prefix of the next class. This can generate
duplication on certain schemas. With `pathedWithFields`, the names of previous
fields are used as prefix of the next class and with `simple`, only the actual
GraphQL class nameis considered. See discussion on [#90][pr-90] and [#96][pr-96]
for more information.

## 5.1.0
- Add `.graphql.` to outputted files path, in a non-breaking change way: a
"forwarder" file will be generated to make it retro-compatible when a
configurated output doesn't end with `.graphql.dart`.

## 5.0.4
- Update CI to include beta branch.

## 5.0.3
- Update examples to match latest changes.

## 5.0.2
- Use default names for query/mutation root when SDL does not declare `schema`.

## 5.0.1
- Fix generation of recursive input objects introduced by 5.0.0.

## 5.0.0
**MAJOR BREAKING CHANGE**

In this version we moved from `json` to `graphql` (SDL) schema parsing.
This allowed us to get rid off ±1200 lines of code which makes the  
project support much easier. The test files with schema definitions
became more clear and human readable.

If you already have your schema in SDL format, just point to it in `build.yaml`.
If not, use this [snippet][introspection-to-sdl-snippet]
(from [this Apollo article][apollo-3-ways-schema]) or online helpers like
[this one][introspection-to-sdl-online] to convert from one to another.

## 4.0.2
- Only add unknownEnumValue on non-list enums
- Consider all classes to include reference to meta package

## 4.0.1
- Look at mutation root when generating a mutation

## 4.0.0
**MAJOR BREAKING CHANGE**

This version completely refactors how Artemis generate code (by finally
using the implementation of visitor pattern provided by `gql`). On top of that,
I've decided to do other major breaking changes to make code cleaner and more
maintainable. Listed:
- `add_query_prefix` doesn't exist anymore (it's now the default to generate
  classes with its "path" from the query), e.g., this query's `city` field will
  be typed as `CityName$QueryRoot$User$Address$City`:
  ```graphql
  query city_name {
    user {
      address {
        city {
          name
        }
      }
    }
  }
  ```
  This change was also done to tip users to NOT use those generated queries
  directly on their code, to avoid coupling them to your business logic.
- `custom_parser_import` was moved to inside a ScalarMap, and
  `use_custom_parser` was removed.
- `resolve_type_field` option was renamed to `type_name_field`, as `__typename`
  is the correct field name (by GraphQL spec).
- Classes generated for mutation will have a `Mutation` suffix, as queries
  already have `Query` suffix.
- Change pre-generation data classes constructors to named parameters, so if
  you're using `GraphQLQueryBuilder.onBuild`, it will break.

And also:
- Add more logs and errors while generating code, to help debugging.
- Add more/refactor tests.
- Add a GitHub example.

TODO:
- [ ] re-add more logs
- [ ] clean options (?)
- [ ] prefix every class with `$` (?)
- [ ] refactor class naming variables
- [ ] review readme and changelog

## 3.2.1
- Fix unknown enum: add prefix

## 3.2.0
- Make enums loose. When unknown values are provided into an enum, it will fall back to a custom `ARTEMIS_UNKNOWN` value
avoiding breaking/crashing the client.

## 3.1.0
- Allow to dispose `ArtemisClient` underlining http client when possible

## 3.0.0
- BREAKING: Marks non nullable input field as `@required` [#68][pr-68]

## 2.2.2
- Make lists as input objects work again

## 2.2.1
- Display error on types not found on schema

## 2.2.0+1
- Add "Articles and videos" category on README

## 2.2.0
- Share fragments between queries and schemas (see `fragments_glob`) [#65][pr-65]

## 2.1.4
- Add missing prefix to generated enums

## 2.1.3
- Bump equatable/gql suite, refine GitHub actions

## 2.1.2
- Bump json_serializable/json_annotation

## 2.1.1
- Properly consider Union types on generation

## 2.1.0+1
- Fix GitHub actions deploy pipeline
- Make sure artemis depends on json_annotation

## 2.1.0
- Generate fragments as mixins

## 2.0.7+1
- README updates

## 2.0.7
- Add missing prefix to interfaces

## 2.0.6
- Perserve the query name casing

## 2.0.5
- Bump `gql` package

## 2.0.4
- Bump `gql` package

## 2.0.3
- Generate every field of input objects

## 2.0.2
- Support `__schema` key under the data field or on root of `schema.json`.

## 2.0.1
- Loosen up dependencies to make it work again with Flutter `beta` channel

## 2.0.0
- BREAKING: move `GraphQLError` to `package:gql`. If you don't use it, or just
  reference it indirectly, it will not be breaking, but a major will be bumped
  anyway, just for sure.
- Upgrade `package:gql` to version `0.7.4`
- Build GQL AST into generated Dart code instead of the raw string
- Use `Link` from `package:gql/link` as the execution interface of `ArtemisClient`
- Use `package:gql_dedupe_link` and `package:gql_http_link` as the default links

## 1.0.4
- Add a test to guarantee query inputs can be lists

## 1.0.3
- Disable implicit casts
- Avoid double-parsing the source string

## 1.0.2
- Differentiate lists from named types when looping through variables
- Consider nullable operation name when defining query name

## 1.0.1
- Upgrade `gql` to version `0.2.0` to get rid of direct dependency on `source_span`
  and for better parsing errors.
- Filter for `SchemaMap` with `output` when generating code

## 1.0.0
- Breaking: Add required `output` option to `SchemaMap`
- Make Artemis a `$lib$` synthetic generator
- Add `add_query_prefix` option to `SchemaMap`

## 0.7.0
- Make generated classes a mixin of `Equatable`, meaning they can be easily comparable with `==`

## 0.6.1
- Include pubspec.lock files of examples

## 0.6.0
- Replace `graphql_parser` with `gql` package

## 0.5.1
- Add most documentation
- Increase pana grade (health and maintenance)
- Fix some stuff related to importing http on client

## 0.5.0
- Start using `code_builder` to better generate Dart code

## 0.4.0
- Allow scalar mappings to include imports for types

## 0.3.2
- Decode HTTP response as UTF-8 on execute helper.

## 0.3.1
- Export common used files on default package route (`package:artemis/artemis.dart`)
- Use single schemaMap globbing stream to make sure only one schema will be found
- Add missing changelog
- Test new github actions

## 0.3.0 BREAKING
- Add new generators to GraphQLQuery and QueryArguments
- Fix toJson() on JsonSerializable classes (for nested entities)
- [BREAKING] Remove the `execute*` functions generations, to use instead the generic `ArtemisClient` class
that should receive a GraphQLQuery generated subclass.

## 0.2.1
Set HTTP headers only when using default HTTP client.

## 0.2.0 BREAKING
Completely overhaul how this works.

Artemis won't generate a full schema typing anymore. Instead, it will use the schema to generate typings from a specific query or mutation. It will also create helper functions to execute those queries. See [README][readme] for more info.

This is totally a breaking change but as this library is still on alpha, I should keep it under 1.0.

## 0.1.3
- Make objects that implement interfaces override resolveType

## 0.1.2
- Improve package score

## 0.1.1
- Enable tests on pipeline

## 0.1.0
- "Fix" json_serializable dependency
- Add tests
- Generate union types as inheritance
- Generate interface types as implementation
- Make generated code choose inheritance

## 0.0.1
- First release
- No tests
- No documentation
- Parse complex GraphQL schemas (incorrectly, now I know)
- Parse all GraphQL types types (union, interface, enum, input object, object, scalar, list, non null)
- Consider custom scalars
- Not even compile from scratch
- Lot of bugs

[readme]: ./README.md
[pr-65]: https://github.com/comigor/artemis/pull/65
[pr-68]: https://github.com/comigor/artemis/pull/68
[apollo-3-ways-schema]: https://blog.apollographql.com/three-ways-to-represent-your-graphql-schema-a41f4175100d#:~:text=Introspection%20query%20result%20to%20SDL
[introspection-to-sdl-snippet]: https://gist.github.com/stubailo/041999ba5b8b15cede60b93ff9a38f53
[introspection-to-sdl-online]: https://codesandbox.io/s/graphql-introspection-sdl-svlx2
[pr-90]: https://github.com/comigor/artemis/pull/90
[pr-96]: https://github.com/comigor/artemis/pull/96