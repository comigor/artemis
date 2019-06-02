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
```
then run:
```shell
pub packages get
```
or
```shell
flutter packages get
```
