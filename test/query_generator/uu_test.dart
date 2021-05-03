import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../helpers.dart';

void main() {
  group('On union types', () {
    test(
      'On union types',
      () async => testGenerator(
        query: query,
        schema: graphQLSchema,
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
      ),
    );
  });
}

final String query = r'''
  subscription DashboardSessionListSubscription {
    sessionEvents {
        __typename
        ... on SessionEntityMutated {
            entityId
            mutationEventType
            mutationEvent {
                __typename
                ... on SessionCreated {
                    entity {
						id
                    }
                }
            }
        }
    }
}
''';

final String graphQLSchema = '''
  schema {
    query: Query
    subscription: Subscription
  }
  
  type Subscription {
    sessionEvents(byType: [SessionEventType!], id: ID): SessionEvent!
  }
  
  enum SessionEventType {
    CREATED
    DELETED
    MADE_PRIVATE
    MADE_PUBLIC
    MEMBERS_ADDED
    MEMBERS_REMOVED
    UPDATED
}

enum MutationEventType {
    CREATED
    DELETED
    UPDATED
}

type SessionEntityMutated implements SubscriptionPayload {
    "Code for the subscription"
    code: String!
    entityId: ID!
    mutationEvent: SessionMutationEvent!
    mutationEventType: MutationEventType!
    "The Actor that triggered this event"
    triggeredBy: Actor!
}

interface SubscriptionPayload {
    "Code for the subscription"
    code: String!
    entityId: ID!
    "The Actor that triggered this event"
    triggeredBy: Actor!
}

type SessionCreated implements SessionMutationEventPayload {
    entity: String
}

type SessionDeleted implements SessionMutationEventPayload {
    entity: String
}

type SessionUpdated implements SessionMutationEventPayload {
    entity: String
}

union SessionEvent = MembershipMutated | SessionEntityMutated

union SessionMutationEvent = SessionCreated | SessionDeleted | SessionUpdated
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'DashboardSessionListSubscription$_Subscription'),
      operationName: r'DashboardSessionListSubscription',
      classes: [
        EnumDefinition(name: EnumName(name: r'MutationEventType'), values: [
          EnumValueDefinition(name: EnumValueName(name: r'CREATED')),
          EnumValueDefinition(name: EnumValueName(name: r'DELETED')),
          EnumValueDefinition(name: EnumValueName(name: r'UPDATED')),
          EnumValueDefinition(name: EnumValueName(name: r'ARTEMIS_UNKNOWN'))
        ]),
        ClassDefinition(
            name: ClassName(
                name:
                    r'DashboardSessionListSubscription$_Subscription$_SessionEvent$_SessionEntityMutated$_SessionMutationEvent$_SessionCreated'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'entity'),
                  isResolveType: false)
            ],
            extension: ClassName(
                name:
                    r'DashboardSessionListSubscription$_Subscription$_SessionEvent$_SessionEntityMutated$_SessionMutationEvent'),
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(
                name:
                    r'DashboardSessionListSubscription$_Subscription$_SessionEvent$_SessionEntityMutated$_SessionMutationEvent'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'__typename'),
                  annotations: [r'''JsonKey(name: '__typename')'''],
                  isResolveType: true)
            ],
            extension: ClassName(
                name:
                    r'DashboardSessionListSubscription$_Subscription$_SessionEvent$_SessionEntityMutated'),
            factoryPossibilities: {
              r'SessionCreated': ClassName(
                  name:
                      r'DashboardSessionListSubscription$_Subscription$_SessionEvent$_SessionEntityMutated$_SessionMutationEvent$_SessionCreated')
            },
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(
                name:
                    r'DashboardSessionListSubscription$_Subscription$_SessionEvent$_SessionEntityMutated'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r'entityId'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'MutationEventType', isNonNull: true),
                  name: ClassPropertyName(name: r'mutationEventType'),
                  annotations: [
                    r'JsonKey(unknownEnumValue: MutationEventType.artemisUnknown)'
                  ],
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(
                      name:
                          r'DashboardSessionListSubscription$_Subscription$_SessionEvent$_SessionEntityMutated$_SessionMutationEvent',
                      isNonNull: true),
                  name: ClassPropertyName(name: r'mutationEvent'),
                  isResolveType: false)
            ],
            extension: ClassName(
                name:
                    r'DashboardSessionListSubscription$_Subscription$_SessionEvent'),
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(
                name:
                    r'DashboardSessionListSubscription$_Subscription$_SessionEvent'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'__typename'),
                  annotations: [r'''JsonKey(name: '__typename')'''],
                  isResolveType: true)
            ],
            factoryPossibilities: {
              r'SessionEntityMutated': ClassName(
                  name:
                      r'DashboardSessionListSubscription$_Subscription$_SessionEvent$_SessionEntityMutated')
            },
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(
                name: r'DashboardSessionListSubscription$_Subscription'),
            properties: [
              ClassProperty(
                  type: TypeName(
                      name:
                          r'DashboardSessionListSubscription$_Subscription$_SessionEvent',
                      isNonNull: true),
                  name: ClassPropertyName(name: r'sessionEvents'),
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
class DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutated$SessionMutationEvent$SessionCreated
    extends DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutated$SessionMutationEvent
    with EquatableMixin {
  DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutated$SessionMutationEvent$SessionCreated();

  factory DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutated$SessionMutationEvent$SessionCreated.fromJson(
          Map<String, dynamic> json) =>
      _$DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutated$SessionMutationEvent$SessionCreatedFromJson(
          json);

  String? entity;

  @override
  List<Object?> get props => [entity];
  Map<String, dynamic> toJson() =>
      _$DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutated$SessionMutationEvent$SessionCreatedToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutated$SessionMutationEvent
    extends DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutated
    with EquatableMixin {
  DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutated$SessionMutationEvent();

  factory DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutated$SessionMutationEvent.fromJson(
      Map<String, dynamic> json) {
    switch (json['__typename'].toString()) {
      case r'SessionCreated':
        return DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutated$SessionMutationEvent$SessionCreated
            .fromJson(json);
      default:
    }
    return _$DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutated$SessionMutationEventFromJson(
        json);
  }

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [$$typename];
  Map<String, dynamic> toJson() {
    switch ($$typename) {
      case r'SessionCreated':
        return (this
                as DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutated$SessionMutationEvent$SessionCreated)
            .toJson();
      default:
    }
    return _$DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutated$SessionMutationEventToJson(
        this);
  }
}

@JsonSerializable(explicitToJson: true)
class DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutated
    extends DashboardSessionListSubscription$Subscription$SessionEvent
    with EquatableMixin {
  DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutated();

  factory DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutated.fromJson(
          Map<String, dynamic> json) =>
      _$DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutatedFromJson(
          json);

  late String entityId;

  @JsonKey(unknownEnumValue: MutationEventType.artemisUnknown)
  late MutationEventType mutationEventType;

  late DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutated$SessionMutationEvent
      mutationEvent;

  @override
  List<Object?> get props => [entityId, mutationEventType, mutationEvent];
  Map<String, dynamic> toJson() =>
      _$DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutatedToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class DashboardSessionListSubscription$Subscription$SessionEvent
    extends JsonSerializable with EquatableMixin {
  DashboardSessionListSubscription$Subscription$SessionEvent();

  factory DashboardSessionListSubscription$Subscription$SessionEvent.fromJson(
      Map<String, dynamic> json) {
    switch (json['__typename'].toString()) {
      case r'SessionEntityMutated':
        return DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutated
            .fromJson(json);
      default:
    }
    return _$DashboardSessionListSubscription$Subscription$SessionEventFromJson(
        json);
  }

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [$$typename];
  Map<String, dynamic> toJson() {
    switch ($$typename) {
      case r'SessionEntityMutated':
        return (this
                as DashboardSessionListSubscription$Subscription$SessionEvent$SessionEntityMutated)
            .toJson();
      default:
    }
    return _$DashboardSessionListSubscription$Subscription$SessionEventToJson(
        this);
  }
}

@JsonSerializable(explicitToJson: true)
class DashboardSessionListSubscription$Subscription extends JsonSerializable
    with EquatableMixin {
  DashboardSessionListSubscription$Subscription();

  factory DashboardSessionListSubscription$Subscription.fromJson(
          Map<String, dynamic> json) =>
      _$DashboardSessionListSubscription$SubscriptionFromJson(json);

  late DashboardSessionListSubscription$Subscription$SessionEvent sessionEvents;

  @override
  List<Object?> get props => [sessionEvents];
  Map<String, dynamic> toJson() =>
      _$DashboardSessionListSubscription$SubscriptionToJson(this);
}

enum MutationEventType {
  @JsonValue('CREATED')
  created,
  @JsonValue('DELETED')
  deleted,
  @JsonValue('UPDATED')
  updated,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}
''';
