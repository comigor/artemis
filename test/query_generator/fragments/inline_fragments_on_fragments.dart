import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On inline fragments on fragments', () {
    test(
      'Interface fragments',
      () async => testGenerator(
        query: r'''
          fragment InterfaceFragment2 on InterfaceA { 
            interface {
              s
            }

            ...on ImplementationA {
              b
            }
            ...on ImplementationB {
              i2
            }
          }
          fragment InterfaceFragment on InterfaceA { 
            s
            i
            ...on ImplementationA {
              b
              interface {
                ...InterfaceFragment2
              }
            }
            ...on ImplementationB {
              i2
            }
          }
          fragment UnionFragment on UnionA { 
            ...on ImplementationA {
              b
            }
            ...on ImplementationB {
              s
            }

          }
          query some_query { 
            interface {
              ...InterfaceFragment
            }
            union {
              ...UnionFragment
            }
          }
        ''',
        schema: r'''
          type Query { 
            interface: InterfaceA
            union: UnionA
          } 
          
          interface InterfaceA {
            s: String
            i: Int
            interface: InterfaceA
          }

          union UnionA = ImplementationA | ImplementationB

          type ImplementationA implements InterfaceA {
            s: String
            i: Int
            b: Boolean
            interface: InterfaceA
          }
          type ImplementationB implements InterfaceA {
            s: String
            i: Int
            i2: Int
            interface: InterfaceA
          }

        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
      ),
    );
  });
}

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'SomeQuery$_Query'),
      operationName: r'some_query',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'InterfaceFragment2Mixin$_InterfaceA'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r's'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'InterfaceFragment2Mixin$_ImplementationA'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'bool'),
                  name: ClassPropertyName(name: r'b'),
                  isResolveType: false)
            ],
            mixins: [FragmentName(name: r'InterfaceFragment2Mixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'InterfaceFragment2Mixin$_ImplementationB'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'int'),
                  name: ClassPropertyName(name: r'i2'),
                  isResolveType: false)
            ],
            mixins: [FragmentName(name: r'InterfaceFragment2Mixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        FragmentClassDefinition(
            name: FragmentName(name: r'InterfaceFragment2Mixin'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'InterfaceFragment2Mixin$_InterfaceA'),
                  name: ClassPropertyName(name: r'interface'),
                  annotations: [r'''JsonKey(name: 'interface')'''],
                  isResolveType: false)
            ]),
        ClassDefinition(
            name: ClassName(
                name: r'InterfaceFragmentMixin$_ImplementationA$_InterfaceA'),
            mixins: [FragmentName(name: r'InterfaceFragment2Mixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'InterfaceFragmentMixin$_ImplementationA'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'bool'),
                  name: ClassPropertyName(name: r'b'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(
                      name:
                          r'InterfaceFragmentMixin$_ImplementationA$_InterfaceA'),
                  name: ClassPropertyName(name: r'interface'),
                  annotations: [r'''JsonKey(name: 'interface')'''],
                  isResolveType: false)
            ],
            mixins: [FragmentName(name: r'InterfaceFragmentMixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'InterfaceFragmentMixin$_ImplementationB'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'int'),
                  name: ClassPropertyName(name: r'i2'),
                  isResolveType: false)
            ],
            mixins: [FragmentName(name: r'InterfaceFragmentMixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        FragmentClassDefinition(
            name: FragmentName(name: r'InterfaceFragmentMixin'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r's'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'int'),
                  name: ClassPropertyName(name: r'i'),
                  isResolveType: false)
            ]),
        ClassDefinition(
            name: ClassName(name: r'UnionFragmentMixin$_ImplementationA'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'bool'),
                  name: ClassPropertyName(name: r'b'),
                  isResolveType: false)
            ],
            mixins: [FragmentName(name: r'UnionFragmentMixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'UnionFragmentMixin$_ImplementationB'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r's'),
                  isResolveType: false)
            ],
            mixins: [FragmentName(name: r'UnionFragmentMixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        FragmentClassDefinition(
            name: FragmentName(name: r'UnionFragmentMixin')),
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$_Query$_InterfaceA'),
            mixins: [FragmentName(name: r'InterfaceFragmentMixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$_Query$_UnionA'),
            mixins: [FragmentName(name: r'UnionFragmentMixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$_Query'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'SomeQuery$_Query$_InterfaceA'),
                  name: ClassPropertyName(name: r'interface'),
                  annotations: [r'''JsonKey(name: 'interface')'''],
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'SomeQuery$_Query$_UnionA'),
                  name: ClassPropertyName(name: r'union'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false)
      ],
      generateHelpers: false,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

mixin InterfaceFragment2Mixin {
  @JsonKey(name: 'interface')
  InterfaceFragment2Mixin$InterfaceA? kw$interface;
}
mixin InterfaceFragmentMixin {
  String? s;
  int? i;
}
mixin UnionFragmentMixin {}

@JsonSerializable(explicitToJson: true)
class InterfaceFragment2Mixin$InterfaceA extends JsonSerializable
    with EquatableMixin {
  InterfaceFragment2Mixin$InterfaceA();

  factory InterfaceFragment2Mixin$InterfaceA.fromJson(
          Map<String, dynamic> json) =>
      _$InterfaceFragment2Mixin$InterfaceAFromJson(json);

  String? s;

  @override
  List<Object?> get props => [s];
  Map<String, dynamic> toJson() =>
      _$InterfaceFragment2Mixin$InterfaceAToJson(this);
}

@JsonSerializable(explicitToJson: true)
class InterfaceFragment2Mixin$ImplementationA extends JsonSerializable
    with EquatableMixin, InterfaceFragment2Mixin {
  InterfaceFragment2Mixin$ImplementationA();

  factory InterfaceFragment2Mixin$ImplementationA.fromJson(
          Map<String, dynamic> json) =>
      _$InterfaceFragment2Mixin$ImplementationAFromJson(json);

  bool? b;

  @override
  List<Object?> get props => [kw$interface, b];
  Map<String, dynamic> toJson() =>
      _$InterfaceFragment2Mixin$ImplementationAToJson(this);
}

@JsonSerializable(explicitToJson: true)
class InterfaceFragment2Mixin$ImplementationB extends JsonSerializable
    with EquatableMixin, InterfaceFragment2Mixin {
  InterfaceFragment2Mixin$ImplementationB();

  factory InterfaceFragment2Mixin$ImplementationB.fromJson(
          Map<String, dynamic> json) =>
      _$InterfaceFragment2Mixin$ImplementationBFromJson(json);

  int? i2;

  @override
  List<Object?> get props => [kw$interface, i2];
  Map<String, dynamic> toJson() =>
      _$InterfaceFragment2Mixin$ImplementationBToJson(this);
}

@JsonSerializable(explicitToJson: true)
class InterfaceFragmentMixin$ImplementationA$InterfaceA extends JsonSerializable
    with EquatableMixin, InterfaceFragment2Mixin {
  InterfaceFragmentMixin$ImplementationA$InterfaceA();

  factory InterfaceFragmentMixin$ImplementationA$InterfaceA.fromJson(
          Map<String, dynamic> json) =>
      _$InterfaceFragmentMixin$ImplementationA$InterfaceAFromJson(json);

  @override
  List<Object?> get props => [kw$interface];
  Map<String, dynamic> toJson() =>
      _$InterfaceFragmentMixin$ImplementationA$InterfaceAToJson(this);
}

@JsonSerializable(explicitToJson: true)
class InterfaceFragmentMixin$ImplementationA extends JsonSerializable
    with EquatableMixin, InterfaceFragmentMixin {
  InterfaceFragmentMixin$ImplementationA();

  factory InterfaceFragmentMixin$ImplementationA.fromJson(
          Map<String, dynamic> json) =>
      _$InterfaceFragmentMixin$ImplementationAFromJson(json);

  bool? b;

  @JsonKey(name: 'interface')
  InterfaceFragmentMixin$ImplementationA$InterfaceA? kw$interface;

  @override
  List<Object?> get props => [s, i, b, kw$interface];
  Map<String, dynamic> toJson() =>
      _$InterfaceFragmentMixin$ImplementationAToJson(this);
}

@JsonSerializable(explicitToJson: true)
class InterfaceFragmentMixin$ImplementationB extends JsonSerializable
    with EquatableMixin, InterfaceFragmentMixin {
  InterfaceFragmentMixin$ImplementationB();

  factory InterfaceFragmentMixin$ImplementationB.fromJson(
          Map<String, dynamic> json) =>
      _$InterfaceFragmentMixin$ImplementationBFromJson(json);

  int? i2;

  @override
  List<Object?> get props => [s, i, i2];
  Map<String, dynamic> toJson() =>
      _$InterfaceFragmentMixin$ImplementationBToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UnionFragmentMixin$ImplementationA extends JsonSerializable
    with EquatableMixin, UnionFragmentMixin {
  UnionFragmentMixin$ImplementationA();

  factory UnionFragmentMixin$ImplementationA.fromJson(
          Map<String, dynamic> json) =>
      _$UnionFragmentMixin$ImplementationAFromJson(json);

  bool? b;

  @override
  List<Object?> get props => [b];
  Map<String, dynamic> toJson() =>
      _$UnionFragmentMixin$ImplementationAToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UnionFragmentMixin$ImplementationB extends JsonSerializable
    with EquatableMixin, UnionFragmentMixin {
  UnionFragmentMixin$ImplementationB();

  factory UnionFragmentMixin$ImplementationB.fromJson(
          Map<String, dynamic> json) =>
      _$UnionFragmentMixin$ImplementationBFromJson(json);

  String? s;

  @override
  List<Object?> get props => [s];
  Map<String, dynamic> toJson() =>
      _$UnionFragmentMixin$ImplementationBToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$Query$InterfaceA extends JsonSerializable
    with EquatableMixin, InterfaceFragmentMixin {
  SomeQuery$Query$InterfaceA();

  factory SomeQuery$Query$InterfaceA.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$Query$InterfaceAFromJson(json);

  @override
  List<Object?> get props => [s, i];
  Map<String, dynamic> toJson() => _$SomeQuery$Query$InterfaceAToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$Query$UnionA extends JsonSerializable
    with EquatableMixin, UnionFragmentMixin {
  SomeQuery$Query$UnionA();

  factory SomeQuery$Query$UnionA.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$Query$UnionAFromJson(json);

  @override
  List<Object?> get props => [];
  Map<String, dynamic> toJson() => _$SomeQuery$Query$UnionAToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$Query extends JsonSerializable with EquatableMixin {
  SomeQuery$Query();

  factory SomeQuery$Query.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$QueryFromJson(json);

  @JsonKey(name: 'interface')
  SomeQuery$Query$InterfaceA? kw$interface;

  SomeQuery$Query$UnionA? union;

  @override
  List<Object?> get props => [kw$interface, union];
  Map<String, dynamic> toJson() => _$SomeQuery$QueryToJson(this);
}
''';
