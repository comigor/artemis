import 'package:artemis/generator/data/data.dart';
import 'package:artemis/generator/data/enum_value_definition.dart';
import 'package:test/test.dart';

import '../helpers.dart';

void main() {
  group('On subscription', () {
    test(
      'Should process subscription',
      () async => testGenerator(
        query: query,
        schema: r'''
          schema {
            query: Query
            subscription: Subscription
          }
          
          type Call {
            callID: CallID!
            localAddress: String!
            remoteAddress: String!
            callState: CallState!
          }
          
          enum CallState {
            Offered
            Ringing
            Connecting
            Connected
            Initiated
            Ringback
            Disconnected
          }
          
          type User {
            firstName: String!
            lastName: String!
            middleName: String
            userType: UserType!
          }
          
          type CallID {
            id: Int!
          }
          
          enum UserType {
            UserManager
            UserTechLead
            UserDev
            UserQA
          }
          
          type Query {
            user(userID: String!, midName: String): User!
            allCalls: [Call!]!
          }
          
          type Subscription {
            newUser: User!
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
      ),
    );
  });
}

const query = r'''
  subscription NewUserSub {
    newUser {
      firstName
      lastName
      userType
    }
  }
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'NewUserSub$_Subscription'),
      operationName: r'NewUserSub',
      classes: [
        EnumDefinition(name: EnumName(name: r'UserType'), values: [
          EnumValueDefinition(name: EnumValueName(name: r'UserManager')),
          EnumValueDefinition(name: EnumValueName(name: r'UserTechLead')),
          EnumValueDefinition(name: EnumValueName(name: r'UserDev')),
          EnumValueDefinition(name: EnumValueName(name: r'UserQA')),
          EnumValueDefinition(name: EnumValueName(name: r'ARTEMIS_UNKNOWN'))
        ]),
        ClassDefinition(
            name: ClassName(name: r'NewUserSub$_Subscription$_User'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'firstName'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'lastName'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'UserType', isNonNull: true),
                  name: ClassPropertyName(name: r'userType'),
                  annotations: [
                    r'JsonKey(unknownEnumValue: UserType.artemisUnknown)'
                  ],
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'NewUserSub$_Subscription'),
            properties: [
              ClassProperty(
                  type: TypeName(
                      name: r'NewUserSub$_Subscription$_User', isNonNull: true),
                  name: ClassPropertyName(name: r'newUser'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false)
      ],
      generateHelpers: false,
      suffix: r'Subscription')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class NewUserSub$Subscription$User extends JsonSerializable
    with EquatableMixin {
  NewUserSub$Subscription$User();

  factory NewUserSub$Subscription$User.fromJson(Map<String, dynamic> json) =>
      _$NewUserSub$Subscription$UserFromJson(json);

  late String firstName;

  late String lastName;

  @JsonKey(unknownEnumValue: UserType.artemisUnknown)
  late UserType userType;

  @override
  List<Object?> get props => [firstName, lastName, userType];
  Map<String, dynamic> toJson() => _$NewUserSub$Subscription$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NewUserSub$Subscription extends JsonSerializable with EquatableMixin {
  NewUserSub$Subscription();

  factory NewUserSub$Subscription.fromJson(Map<String, dynamic> json) =>
      _$NewUserSub$SubscriptionFromJson(json);

  late NewUserSub$Subscription$User newUser;

  @override
  List<Object?> get props => [newUser];
  Map<String, dynamic> toJson() => _$NewUserSub$SubscriptionToJson(this);
}

enum UserType {
  @JsonValue('UserManager')
  userManager,
  @JsonValue('UserTechLead')
  userTechLead,
  @JsonValue('UserDev')
  userDev,
  @JsonValue('UserQA')
  userQA,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}
''';
