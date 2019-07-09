<p align="center">
  <img src="https://user-images.githubusercontent.com/735858/58768495-8ecbd600-8572-11e9-9321-4fa5ce4ea007.png" height="200">
  <h1><b>Artemis</b></h1>
</p>

<!-- Badges -->

[![Pub Package](https://img.shields.io/pub/v/artemis.svg)](https://pub.dartlang.org/packages/artemis)

**Build dart types from a GraphQL schema.**

Artemis is a code generator that looks for `*.schema.json` (GraphQL Introspection Query response schema) and builds `.api.dart` files typing that schema. That's similar to what [Apollo](https://github.com/apollographql/apollo-client) does.

---

## **Installation**
Add the following to your `pubspec.yaml` file:
```yaml
dev_dependencies:
  artemis: <1.0.0
  build_runner: ^1.5.0
  json_serializable: ^3.0.0
```

>ℹ️ Note that `build_runner` and `json_serializable` are required!

Then run:
```shell
pub packages get
```
or
```shell
flutter packages get
```

Now `artemis` will generate the API file for you by running:
```shell
pub run build_runner build
```
or
```shell
flutter pub run build_runner build
```

## **Interfaces/Union types resolution**
`__resolveType` are not added automatically to the query.

## **Custom Scalars**
If your schema uses custom scalars, they must be defined on `build.yaml` file on the root the project. If it needs a custom parser (to decode from/to json), the `custom_parser_import` path must be set and the file must implement both `fromGraphQL___ToDart___` and `fromDart___toGraphQL___` constant functions.

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

See [examples](./example) for more information and configuration options.
