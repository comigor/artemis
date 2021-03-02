// @dart = 2.12
// ignore_for_file: public_member_api_docs

//////
////// Canonical classes generation
//////

/// Fragments are generated as mixins, following field nullability.
mixin MehFragFragment {
  late String meh;
}

/// Interfaces need to be interfaces so we can toCanonical them.
class NamedAndValuedEntity {
  String? name;
  int? value;

  void toConcrete$NamedAndValuedEntity({
    void Function(Business business)? onBusiness,
    void Function(Other other)? onOther,
  }) {
    if (this is Business && onBusiness != null) {
      return onBusiness(this as Business);
    }
    if (this is Other && onOther != null) {
      return onOther(this as Other);
    }
    throw Exception();
  }
}

/// Union types are also generated as mixins, but without common fields.
mixin MyUnion1 {
  void toConcrete$MyUnion1({
    void Function(A a)? onA,
    void Function(B b)? onB,
  }) {
    if (this is A && onA != null) {
      return onA(this as A);
    }
    if (this is B && onB != null) {
      return onB(this as B);
    }
    throw Exception();
  }
}

mixin MyUnion2 {
  void toConcrete$MyUnion2({
    void Function(B b)? onB,
    void Function(C c)? onC,
  }) {
    if (this is B && onB != null) {
      return onB(this as B);
    }
    if (this is C && onC != null) {
      return onC(this as C);
    }
    throw Exception();
  }
}

/// Concrete canonical classes also have all fields optional, overriding them
/// if needed (from union and interfaces), and a constructor to assign them.
/// Canonical classes do not implement fragments, as they are bound to the query.
class A with MyUnion1 {
  A({
    this.a,
  });

  String? a;
}

class B with MyUnion1, MyUnion2 {
  B({
    this.b,
  });

  int? b;
}

class C with MyUnion2 {
  C({
    this.c,
  });

  String? c;
}

class Business with NamedAndValuedEntity {
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
}

class Other with NamedAndValuedEntity {
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
  Iterable<MyUnion1>? uni;
}

void main() {
  final q = Query()
    ..all = [
      Business()..employeeCount = 1,
      Business()..employeeCount = 2,
      Other()..field = 'f1',
      Other()..field = 'f2',
    ];

  print(q.all!.toList());
  print(q.all!.whereType<Business>().toList());
  print(q.all!.whereType<Other>().toList());

  print('--------------');

  q.all!.forEach((e) {
    e.toConcrete$NamedAndValuedEntity(
      onBusiness: (business) {
        print(business.employeeCount);
      },
    );
  });
}
