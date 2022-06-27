import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('Recursive input objects', () {
    test(
      r'''Artemis won't StackOverflow on recursive input objects''',
      () async => testGenerator(
        query: query,
        schema: r'''
          type Mutation {
            mut(input: Input!): String
          }

          input Input {
            and: Input
            or: Input
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
      ),
    );
  });
}

const query = r'''
mutation custom($input: Input!) {
  mut(input: $input)
}
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'Custom$_Mutation'),
      operationName: r'custom',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'Custom$_Mutation'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r'mut'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Input'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'Input'),
                  name: ClassPropertyName(name: r'and'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'Input'),
                  name: ClassPropertyName(name: r'or'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: true)
      ],
      inputs: [
        QueryInput(
            type: TypeName(name: r'Input', isNonNull: true),
            name: QueryInputName(name: r'input'))
      ],
      generateHelpers: false,
      suffix: r'Mutation')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$Mutation extends JsonSerializable with EquatableMixin {
  Custom$Mutation();

  factory Custom$Mutation.fromJson(Map<String, dynamic> json) =>
      _$Custom$MutationFromJson(json);

  String? mut;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [mut, $$typename];
  @override
  Map<String, dynamic> toJson() => _$Custom$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Input extends JsonSerializable with EquatableMixin {
  Input({this.and, this.or});

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);

  Input? and;

  Input? or;

  @override
  List<Object?> get props => [and, or];
  @override
  Map<String, dynamic> toJson() => _$InputToJson(this);
}
''';
