import 'package:artemis/generator/data/data.dart';
import 'package:artemis/generator/data/enum_value_definition.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On enum list', () {
    test(
      'Enums as lists are generated correctly',
      () async => testGenerator(
        query: query,
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        schema: r'''
          schema {
            query: QueryRoot
          }
          
          type QueryRoot {
            q: QueryResponse
          }
          
          type QueryResponse {
            le: [MyEnum]
          }
          
          enum MyEnum {
            A
            B
          }''',
      ),
    );
  });
}

const query = r'''
query custom {
  q {
    le
  }
}
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'Custom$_QueryRoot'),
      operationName: r'custom',
      classes: [
        EnumDefinition(name: EnumName(name: r'MyEnum'), values: [
          EnumValueDefinition(
            name: EnumValueName(name: r'A'),
          ),
          EnumValueDefinition(
            name: EnumValueName(name: r'B'),
          ),
          EnumValueDefinition(
              name: EnumValueName(
            name: r'ARTEMIS_UNKNOWN',
          ))
        ]),
        ClassDefinition(
            name: ClassName(name: r'Custom$_QueryRoot$_QueryResponse'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'List<MyEnum>'),
                  name: ClassPropertyName(name: r'le'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Custom$_QueryRoot'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'Custom$_QueryRoot$_QueryResponse'),
                  name: ClassPropertyName(name: r'q'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false)
      ],
      generateHelpers: false,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot$QueryResponse with EquatableMixin {
  Custom$QueryRoot$QueryResponse();

  factory Custom$QueryRoot$QueryResponse.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRoot$QueryResponseFromJson(json);

  List<MyEnum> le;

  @override
  List<Object> get props => [le];
  Map<String, dynamic> toJson() => _$Custom$QueryRoot$QueryResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot with EquatableMixin {
  Custom$QueryRoot();

  factory Custom$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRootFromJson(json);

  Custom$QueryRoot$QueryResponse q;

  @override
  List<Object> get props => [q];
  Map<String, dynamic> toJson() => _$Custom$QueryRootToJson(this);
}

enum MyEnum {
  @JsonValue("A")
  a,
  @JsonValue("B")
  b,
  @JsonValue("ARTEMIS_UNKNOWN")
  artemisUnknown,
}
''';
