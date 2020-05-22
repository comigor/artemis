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
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      queryName: r'some_query',
      queryType: r'SomeQuery$SomeObject',
      classes: [
        FragmentClassDefinition(
            name: TempName(name: r'MyFragmentMixin'),
            properties: [
              ClassProperty(
                  type: r'String',
                  name: VariableName(name: r's'),
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: r'int',
                  name: VariableName(name: r'i'),
                  isNonNull: false,
                  isResolveType: false)
            ]),
        ClassDefinition(
            name: TempName(name: r'SomeQuery$SomeObject'),
            mixins: [r'MyFragmentMixin'],
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
part 'query.graphql.g.dart';

mixin MyFragmentMixin {
  String s;
  int i;
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$SomeObject with EquatableMixin, MyFragmentMixin {
  SomeQuery$SomeObject();

  factory SomeQuery$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$SomeObjectFromJson(json);

  @override
  List<Object> get props => [s, i];
  Map<String, dynamic> toJson() => _$SomeQuery$SomeObjectToJson(this);
}
''';
