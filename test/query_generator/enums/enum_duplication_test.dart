// @dart = 2.8

import 'package:artemis/generator/data/data.dart';
import 'package:artemis/generator/data/enum_value_definition.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('Enum duplication', () {
    test(
      'Enum duplication should be properly handeled',
      () async => testGenerator(
        query: query,
        namingScheme: 'pathedWithFields',
        schema: r'''
          schema {
            query: Query
          }
          
          type Query {
            q: QueryResponse
            qList: [QueryResponse]
          }
          
          type QueryResponse {
            e: MyEnum
          }
          
          enum MyEnum {
            A
            B
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        sourceAssetsMap: {
          'a|queries/another_query.graphql': anotherQuery,
        },
      ),
    );
  });
}

const query = r'''
  query custom {
    q {
      e
    }
  }
''';

const anotherQuery = r'''
  query customList {
    qList {
      e
    }
  }
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'Custom$_Query'),
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
            name: ClassName(name: r'Custom$_Query$_q'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'MyEnum'),
                  name: ClassPropertyName(name: r'e'),
                  annotations: [
                    r'JsonKey(unknownEnumValue: MyEnum.artemisUnknown)'
                  ],
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Custom$_Query'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'Custom$_Query$_q'),
                  name: ClassPropertyName(name: r'q'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false)
      ],
      generateHelpers: false,
      suffix: r'Query'),
  QueryDefinition(
      name: QueryName(name: r'CustomList$_Query'),
      operationName: r'customList',
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
            name: ClassName(name: r'CustomList$_Query$_qList'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'MyEnum'),
                  name: ClassPropertyName(name: r'e'),
                  annotations: [
                    r'JsonKey(unknownEnumValue: MyEnum.artemisUnknown)'
                  ],
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'CustomList$_Query'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'List<CustomList$Query$QList>'),
                  name: ClassPropertyName(name: r'qList'),
                  isNonNull: false,
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

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$Query$Q extends JsonSerializable with EquatableMixin {
  Custom$Query$Q();

  factory Custom$Query$Q.fromJson(Map<String, dynamic> json) =>
      _$Custom$Query$QFromJson(json);

  @JsonKey(unknownEnumValue: MyEnum.artemisUnknown)
  MyEnum e;

  @override
  List<Object?> get props => [e];
  Map<String, dynamic> toJson() => _$Custom$Query$QToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$Query extends JsonSerializable with EquatableMixin {
  Custom$Query();

  factory Custom$Query.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryFromJson(json);

  Custom$Query$Q q;

  @override
  List<Object?> get props => [q];
  Map<String, dynamic> toJson() => _$Custom$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CustomList$Query$QList extends JsonSerializable with EquatableMixin {
  CustomList$Query$QList();

  factory CustomList$Query$QList.fromJson(Map<String, dynamic> json) =>
      _$CustomList$Query$QListFromJson(json);

  @JsonKey(unknownEnumValue: MyEnum.artemisUnknown)
  MyEnum e;

  @override
  List<Object?> get props => [e];
  Map<String, dynamic> toJson() => _$CustomList$Query$QListToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CustomList$Query extends JsonSerializable with EquatableMixin {
  CustomList$Query();

  factory CustomList$Query.fromJson(Map<String, dynamic> json) =>
      _$CustomList$QueryFromJson(json);

  List<CustomList$Query$QList> qList;

  @override
  List<Object?> get props => [qList];
  Map<String, dynamic> toJson() => _$CustomList$QueryToJson(this);
}

enum MyEnum {
  @JsonValue('A')
  a,
  @JsonValue('B')
  b,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}
''';
