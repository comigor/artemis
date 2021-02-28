// @dart = 2.12
// ignore_for_file: public_member_api_docs
// ignore_for_file: unnecessary_cast
//// ignore_for_file: unused_element

// Generic by selection set, with interfaces, fragments, unions and interface/union type matching.

/// Creating this just so we can separate what's a selection set and what's not.
/// SelectionSet classes shouldn't be used/instantiated directly. Should we start them with underscores?
abstract class SelectionSet {}

//////////////////////////////// "Canonical" classes
/// Fragments are generated as mixins "on" their canonical class (and so must override the fields).
mixin MehFragment on Query {
  @override
  String? meh;
}

/// Interfaces are generated just like fragments, but don't have "on" specification.
mixin NamedAndValuedEntity {
  String? name;
  int? value;
}

/// Canonical classes implement interfaces, but not fragments, as the latter are bound to the query.
/// Objects are all generic to a selection set, and must have all possible fields they contain as nullable.
class Business<T extends SelectionSet> with NamedAndValuedEntity {
  Business(this.$);

  /// The actual selection. Always use this unless you're dealing with generics
  /// or don't mind about nullability. Could this also help to migrate without breaking changes?
  T $;

  /// Always nullable (because as this is a canonical class, and we
  /// can't know for sure if those fields will be selected by the queries)
  int? employeeCount;
  String? address;
}

class Other<T extends SelectionSet> with NamedAndValuedEntity {
  Other(this.$);

  T $;

  String? field;
}

class Query<T extends SelectionSet> {
  Query(this.$);

  T $;

  Business<_Business_SelectionSet_Query$Blah>? blah;
  Business<_Business_SelectionSet_Query$Bleh>? bleh;
  String? mah;
  String? meh;
  Iterable<NamedAndValuedEntity>? all;
  Iterable<MyUnion>? uni;
}

/// Union types are also generated as a simple mixin, without any field (as
/// Dart doesn't have union/sealed classes).
mixin MyUnion {
  void visit({
    Function(A) a,
    Function(B) b,
  }) {}
}

class A<T extends SelectionSet> with MyUnion {
  A(this.$);

  T $;

  String? a;
}

class B<T extends SelectionSet> with MyUnion {
  B(this.$);

  T $;

  int? b;
}

//////////////////////////////// SelectionSets
/// Fragments have their selection sets defined as mixins, so won't need a constructor
/// and can be used in conjunction of other selection sets.
mixin _MehFragment_SelectionSet_Query implements SelectionSet {
  late String meh;
}

/// Regular selection sets follow GraphQL nullability and won't have the field
/// if the query doesn't select it.
class _Business_SelectionSet_Query$Blah implements SelectionSet {
  _Business_SelectionSet_Query$Blah({this.employeeCount, this.value});

  // Follows GraphQL nullability
  int? employeeCount;
  int? value;
}

class _Business_SelectionSet_Query$Bleh implements SelectionSet {
  _Business_SelectionSet_Query$Bleh(
      {required this.address, required this.name});

  // Follows GraphQL nullability
  String address;
  String name;
}

/// Fragments selection sets will spread into other selection sets.
class _Query_SelectionSet_Query
    with _MehFragment_SelectionSet_Query
    implements SelectionSet {
  _Query_SelectionSet_Query({
    this.blah,
    required this.bleh,
    required this.meh,
    required this.all,
    required this.uni,
  });

  // Follows GraphQL nullability
  Business<_Business_SelectionSet_Query$Blah>? blah;
  Business<_Business_SelectionSet_Query$Bleh> bleh;
  Iterable<_NamedAndValuedEntity_SelectionSet_Query$All> all;
  Iterable<MyUnion> uni;

  Iterable<_Business_SelectionSet_Query$All> get all$Business =>
      all.whereType<_Business_SelectionSet_Query$All>();
  Iterable<_Other_SelectionSet_Query$All> get all$Other =>
      all.whereType<_Other_SelectionSet_Query$All>();
  Iterable<_A_SelectionSet_Query$Uni> get uni$A =>
      uni.whereType<_A_SelectionSet_Query$Uni>();
  Iterable<_B_SelectionSet_Query$Uni> get uni$B =>
      uni.whereType<_B_SelectionSet_Query$Uni>();

  /// Inherited via fragments
  @override
  String meh;
}

/// Interface selection sets are also defined as mixins.
mixin _NamedAndValuedEntity_SelectionSet_Query$All implements SelectionSet {
  late String name;
  int? value;
}

class _Business_SelectionSet_Query$All
    with _NamedAndValuedEntity_SelectionSet_Query$All
    implements SelectionSet {
  _Business_SelectionSet_Query$All({required this.address});

  String address;
}

class _Other_SelectionSet_Query$All
    with _NamedAndValuedEntity_SelectionSet_Query$All
    implements SelectionSet {
  _Other_SelectionSet_Query$All({this.field});

  String? field;
}

class _A_SelectionSet_Query$Uni with MyUnion implements SelectionSet {
  _A_SelectionSet_Query$Uni({required this.a});

  String a;
}

class _B_SelectionSet_Query$Uni with MyUnion implements SelectionSet {
  _B_SelectionSet_Query$Uni({required this.b});

  String b;
}

//////////////////////////////// Query
/// so we can test types below
Query<_Query_SelectionSet_Query> run() {
  throw Exception('Not implemented');
}

void main() {
  final q = run();

  q.$.bleh.$.address;
  q.$.bleh.name;
  q.$.meh;
  q is MehFragment;

  q.$.all$Business.forEach((entity) {
    entity.address;
  });

  q.$.uni$B.forEach((entity) {
    entity.b;
  });
}

// fragment Meh on Query {
//   meh
// }
//
// type Query {
//   blah: Business
//   bleh: Business!
//   mah: String
//   meh: String!
//   all: [NamedAndValuedEntity!]!
//   uni: [MyUnion!]!
// }
//
// interface NamedAndValuedEntity {
//   name: String!
//   value: Int
// }
//
// type Business implements NamedAndValuedEntity {
//   name: String!
//   value: Int
//   employeeCount: Int
//   address: String!
// }
//
// type Other implements NamedAndValuedEntity {
//   name: String!
//   value: Int
//   field: String
// }
//
// type A {
//   a: String!
// }
// type B {
//   b: Int!
// }
// union MyUnion = A | B
//
// query {
//   blah { # Business
//     employeeCount
//     value
//   }
//   bleh { # Business
//     address
//     name
//   }
//   ...meh
//   all {
//     name
//     value
//     ... on Business {
//       address
//     }
//     ... on Other {
//       field
//     }
//   }
//   uni {
//     ... on A { a }
//     ... on B { b }
//   }
// }
