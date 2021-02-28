// @dart = 2.12
// ignore_for_file: public_member_api_docs

import '../canonical.dart' as $canonical;
import 'package:artemis/h/artemis.dart';

class Blah with ToCanonical<$canonical.Business> {
  Blah({
    this.employeeCount,
    this.value,
  });

  int? employeeCount;
  int? value;

  @override
  $canonical.Business toCanonical() => $canonical.Business(
        employeeCount: employeeCount,
        value: value,
      );
}

class Bleh with ToCanonical<$canonical.Business> {
  Bleh({
    required this.address,
    required this.name,
  });

  String address;
  String name;

  @override
  $canonical.Business toCanonical() => $canonical.Business(
        address: address,
        name: name,
      );
}

/// Fragments selection sets will spread into other selection sets.
class Query with $canonical.MehFragment, ToCanonical<$canonical.Query> {
  Query({
    this.blah,
    required this.bleh,
    required this.meh,
    required this.all,
    required this.alias,
    required this.uniAlias,
  });

  // Follows GraphQL nullability
  Blah? blah;
  Bleh bleh;
  Iterable<All> all;
  Iterable<Alias> alias;
  Iterable<$canonical.MyUnion> uniAlias;

  /// Inherited via fragments
  @override
  String meh;

  /// Default generated [toCanonical] method won't (at first) consider
  /// aliases.
  @override
  $canonical.Query toCanonical() => $canonical.Query(
        blah: blah?.toCanonical(),
        bleh: bleh.toCanonical(),
        meh: meh,
        all: all.map((e) => e.toCanonical()),
      );
}

/// As it has fragment spreads on concrete types, this class becomes
/// abstract and we use the parent field name (or alias) as class name.
class All<T extends $canonical.NamedAndValuedEntity> with ToCanonical<T> {
  late String name;
  int? value;

  void visitor({
    required void Function(Business) onBusiness,
    required void Function(Other) onOther,
  }) {
    switch (runtimeType) {
      case Business:
        return onBusiness(this as Business);
      case Other:
        return onOther(this as Other);
      default:
        throw Exception();
    }
  }

  @override
  T toCanonical() {
    throw UnimplementedError();
  }
}

/// Without any spread, we just have the abstraction.
class Alias {
  int? value;
}

class Business with ToCanonical<$canonical.Business>, All<$canonical.Business> {
  Business({
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
  $canonical.Business toCanonical() => $canonical.Business(
        name: name,
        value: value,
        address: address,
      );
}

class Other
    with ToCanonical<$canonical.Other>
    implements All<$canonical.Other> {
  Other({
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
  $canonical.Other toCanonical() => $canonical.Other(
        name: name,
        value: value,
        field: field,
      );
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

class _A_SelectionSet_Query$Uni implements SelectionSet {
  _A_SelectionSet_Query$Uni({required this.a});

  String a;
}

class _B_SelectionSet_Query$Uni implements SelectionSet {
  _B_SelectionSet_Query$Uni({required this.b});

  String b;
}
