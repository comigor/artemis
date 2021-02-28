// @dart = 2.12
// ignore_for_file: public_member_api_docs
import 'artemis.dart';

//////////////////////////////// "Canonical" classes
/// Fragments are generated as mixins, following nullability.
mixin MehFragment {
  late String meh;
}

/// Interfaces are generated as abstract classes without constructor.
abstract class NamedAndValuedEntity<T> implements ToConcrete<T> {
  String? name;
  int? value;
};

/// Union types are also generated as mixins.
mixin MyUnion<T> implements ToConcrete<T>;
mixin MyUnion2<T> implements ToConcrete<T>;

class A with MyUnion<A> {
  A({
    this.a,
  });

  String? a;

  @override
  A toConcrete() => this;
}

class B with MyUnion<B>, MyUnion2<B> {
  B({
    this.b,
  });

  int? b;

  @override
  B toConcrete() => this;
}

class C with MyUnion2<C> {
  C({
    this.c,
  });

  String? c;

  @override
  C toConcrete() => this;
}

/// Canonical classes implement interfaces, but not fragments, as the latter are bound to the query.
/// Objects are all generic to a selection set, and must have all possible fields they contain as nullable.
class Business implements NamedAndValuedEntity<Business> {
  Business({
    this.employeeCount,
    this.address,
    this.name,
    this.value,
  });

  int? employeeCount;
  String? address;

  @override
  String? name;

  @override
  int? value;

  @override
  Business toConcrete() => this;
}

class Other implements NamedAndValuedEntity<Other> {
  Other({
    this.field,
    this.name,
    this.value,
  });

  String? field;

  @override
  String? name;

  @override
  int? value;

  @override
  Other toConcrete() => this;
}

class Query {
  Query({
    this.blah,
    this.bleh,
    this.mah,
    this.meh,
    this.all,
    this.uni,
  });

  Business? blah;
  Business? bleh;
  String? mah;
  String? meh;
  Iterable<NamedAndValuedEntity>? all;
  Iterable<MyUnion>? uni;
}

void main() {
  Query q;
  q.uni.first.toConcrete();
  // a.toConcrete();
  // b.toConcrete();
}
