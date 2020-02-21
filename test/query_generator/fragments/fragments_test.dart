import 'package:artemis/generator/data.dart';
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
    LibraryDefinition(basename: r'query', queries: [
  QueryDefinition(
      queryName: r'some_query',
      queryType: r'SomeQuery$SomeObject',
      classes: [
        FragmentClassDefinition(
            name: r'SomeQuery$MyFragmentMixin',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r's',
                  isOverride: false,
                  isNonNull: false),
              ClassProperty(
                  type: r'int', name: r'i', isOverride: false, isNonNull: false)
            ]),
        ClassDefinition(
            name: r'SomeQuery$SomeObject',
            mixins: [r'SomeQuery$MyFragmentMixin'],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false)
      ],
      generateHelpers: false,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.g.dart';

mixin SomeQuery$MyFragmentMixin {
  String s;
  int i;
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$SomeObject with EquatableMixin, SomeQuery$MyFragmentMixin {
  SomeQuery$SomeObject();

  factory SomeQuery$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$SomeObjectFromJson(json);

  @override
  List<Object> get props => [s, i];
  Map<String, dynamic> toJson() => _$SomeQuery$SomeObjectToJson(this);
}
''';
