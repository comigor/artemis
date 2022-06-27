import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On fragments', () {
    test(
      'Fragments will have their own classes',
      () async => testGenerator(
        query: r'''
          fragment myFragment on SomeObject { 
            s, i 
          }
          
          query some_query { 
            ...myFragment 
          }
        ''',
        schema: r'''
         schema {
            query: SomeObject
          }

          type SomeObject {
            s: String
            i: Int
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
      name: QueryName(name: r'SomeQuery$_SomeObject'),
      operationName: r'some_query',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$_SomeObject'),
            mixins: [FragmentName(name: r'MyFragmentMixin')],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        FragmentClassDefinition(
            name: FragmentName(name: r'MyFragmentMixin'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r's'),
                  isResolveType: false),
              ClassProperty(
                  type: DartTypeName(name: r'int'),
                  name: ClassPropertyName(name: r'i'),
                  isResolveType: false)
            ])
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

mixin MyFragmentMixin {
  String? s;
  int? i;
  @JsonKey(name: '__typename')
  String? $$typename;
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$SomeObject extends JsonSerializable
    with EquatableMixin, MyFragmentMixin {
  SomeQuery$SomeObject();

  factory SomeQuery$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$SomeObjectFromJson(json);

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [s, i, $$typename];
  @override
  Map<String, dynamic> toJson() => _$SomeQuery$SomeObjectToJson(this);
}
''';
