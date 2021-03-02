// @dart = 2.12
// ignore_for_file: public_member_api_docs

import 'canonical.dart' as $canonical;
import 'artemis.dart';

/// Fragments selection sets will spread into other selection sets.
class Query with $canonical.MehFragFragment, ToCanonical<$canonical.Query> {
  Query({
    this.blah,
    required this.bleh,
    this.mahAlias1,
    this.mahAlias2,
    required this.meh,
    required this.all,
    required this.alias,
    required this.uni,
  });

  // Follows GraphQL nullability
  Query$Blah? blah;
  Query$Bleh bleh;
  String? mahAlias1;
  String? mahAlias2;

  /// meh inherited via fragment
  @override
  String meh;

  Iterable<Query$All> all;
  Iterable<Query$Alias> alias;
  Iterable<Query$Uni> uni;

  /// Default generated [toCanonical] method won't consider aliases
  /// because we don't know how to choose between [mahAlias1]/[mahAlias2].
  /// TODO: fix this?
  @override
  $canonical.Query get toCanonical => $canonical.Query(
        blah: blah?.toCanonical,
        bleh: bleh.toCanonical,
        // mah: mahAlias1 ?? mahAlias2, // Maybe this? I don't like this solution.
        meh: meh,
        all: all
            .map((e) => e.toCanonical)
            .whereType<$canonical.NamedAndValuedEntity>(),
        // alias: // Doesn't exist, and it doesn't make sense to override [all]
        uni: uni.map((e) => e.toCanonical).whereType<$canonical.MyUnion1>(),
      );
}

class Query$Blah with ToCanonical<$canonical.Business> {
  Query$Blah({
    this.employeeCount,
    this.value,
  });

  int? employeeCount;
  int? value;

  @override
  $canonical.Business get toCanonical => $canonical.Business(
        employeeCount: employeeCount,
        value: value,
      );
}

class Query$Bleh with ToCanonical<$canonical.Business> {
  Query$Bleh({
    required this.address,
    required this.name,
  });

  String address;
  String name;

  @override
  $canonical.Business get toCanonical => $canonical.Business(
        address: address,
        name: name,
      );
}

///
mixin Query$All {
  late String name;
  int? value;

  /// We can't implement ToCanonical mixin or else we can't override it on
  /// concrete type.
  $canonical.NamedAndValuedEntity? get toCanonical {
    if (this is Query$All$Business) {
      return (this as Query$All$Business).toCanonical;
    }
    if (this is Query$All$Other) {
      return (this as Query$All$Other).toCanonical;
    }
  }

  void toConcrete({
    void Function(Query$All$Business business)? onBusiness,
    void Function(Query$All$Other other)? onOther,
  }) {
    if (this is Query$All$Business && onBusiness != null) {
      return onBusiness(this as Query$All$Business);
    }
    if (this is Query$All$Other && onOther != null) {
      return onOther(this as Query$All$Other);
    }
    throw Exception();
  }
}

class Query$All$Business with Query$All, ToCanonical<$canonical.Business> {
  Query$All$Business({
    required this.name,
    this.value,
    required this.address,
  });

  @override
  String name;
  @override
  int? value;
  String address;

  @override
  $canonical.Business get toCanonical => $canonical.Business(
        name: name,
        value: value,
        address: address,
      );
}

class Query$All$Other with Query$All, ToCanonical<$canonical.Other> {
  Query$All$Other({
    required this.name,
    this.value,
    this.field,
  });

  @override
  String name;
  @override
  int? value;
  String? field;

  @override
  $canonical.Other get toCanonical => $canonical.Other(
        name: name,
        value: value,
        field: field,
      );
}

///
mixin Query$Alias {
  int? value;

  $canonical.NamedAndValuedEntity? get toCanonical {
    if (this is Query$Alias$Business) {
      return (this as Query$Alias$Business).toCanonical;
    }
    if (this is Query$Alias$Other) {
      return (this as Query$Alias$Other).toCanonical;
    }
  }

  void toConcrete({
    void Function(Query$Alias$Business business)? onBusiness,
    void Function(Query$Alias$Other other)? onOther,
  }) {
    if (this is Query$Alias$Business && onBusiness != null) {
      return onBusiness(this as Query$Alias$Business);
    }
    if (this is Query$Alias$Other && onOther != null) {
      return onOther(this as Query$Alias$Other);
    }
    throw Exception();
  }
}

class Query$Alias$Business with Query$Alias, ToCanonical<$canonical.Business> {
  Query$Alias$Business({
    this.value,
  });

  @override
  int? value;

  @override
  $canonical.Business get toCanonical => $canonical.Business(
        value: value,
      );
}

class Query$Alias$Other with Query$Alias, ToCanonical<$canonical.Other> {
  Query$Alias$Other({
    this.value,
  });

  @override
  int? value;

  @override
  $canonical.Other get toCanonical => $canonical.Other(
        value: value,
      );
}

///
mixin Query$Uni {
  $canonical.MyUnion1? get toCanonical {
    if (this is Query$Uni$A) {
      return (this as Query$Uni$A).toCanonical;
    }
    if (this is Query$Uni$B) {
      return (this as Query$Uni$B).toCanonical;
    }
  }

  void toConcrete({
    void Function(Query$Uni$A a)? onA,
    void Function(Query$Uni$B b)? onB,
  }) {
    if (this is Query$Uni$A && onA != null) {
      return onA(this as Query$Uni$A);
    }
    if (this is Query$Uni$B && onB != null) {
      return onB(this as Query$Uni$B);
    }
    throw Exception();
  }
}

class Query$Uni$A with Query$Uni, ToCanonical<$canonical.A> {
  Query$Uni$A({
    required this.a,
  });

  String a;

  @override
  $canonical.A get toCanonical => $canonical.A(
        a: a,
      );
}

class Query$Uni$B with Query$Uni, ToCanonical<$canonical.B> {
  Query$Uni$B({
    required this.b,
  });

  int b;

  @override
  $canonical.B get toCanonical => $canonical.B(
        b: b,
      );
}
