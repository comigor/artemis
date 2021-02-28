// @dart = 2.12
// ignore_for_file: public_member_api_docs

mixin Business$EmployeeCount {
  int? employeeCount;
}

mixin Business$Address {
  late String address;
}

mixin NamedAndValuedEntity {
  late String name;
  int? value;
}

class Business
    with Business$EmployeeCount, Business$Address, NamedAndValuedEntity {
  @override
  int? employeeCount;

  @override
  late String address;

  @override
  late String name;

  @override
  int? value;
}

class Query$Blah with Business$EmployeeCount, NamedAndValuedEntity {
  @override
  int? employeeCount;

  @override
  late String name;

  @override
  int? value;
}

void main() {
  Business b;
  Query$Blah q;
  q.
  // b.
}

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

// query {
//   blah { # Business
//     employeeCount
//     value
//   }
