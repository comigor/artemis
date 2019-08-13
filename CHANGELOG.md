# CHANGELOG

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

Artemis won't generate a full schema typing anymore. Instead, it will use the schema to generate typings from a specific query or mutation. It will also create helper functions to execute those queries. See [README](./README.md) for more info.

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
