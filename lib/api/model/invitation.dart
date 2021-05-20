import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/api/serializers.dart';

part 'invitation.g.dart';

abstract class Invitation implements Built<Invitation, InvitationBuilder> {
  /// Initializes a new instance of the [Invitation] class
  factory Invitation([updates(InvitationBuilder b)]) = _$Invitation;

  Invitation._();

  @nullable
  int get id;

  @BuiltValueField(wireName: "user_id")
  @nullable
  int get userId;

  @BuiltValueField(wireName: "invited_by_id")
  @nullable
  int get invitedById;

  @BuiltValueField(wireName: "project_id")
  @nullable
  int get projectId;

  @nullable
  String get status;

  @nullable
  String get notes;

  @BuiltValueField(wireName: "created_at")
  @nullable
  DateTime get createdAt;

  @BuiltValueField(wireName: "updated_at")
  @nullable
  DateTime get updatedAt;

  @BuiltValueField(wireName: "company_id")
  @nullable
  int get companyId;

  @BuiltValueField(wireName: "company_name")
  @nullable
  String get companyName;

  @BuiltValueField(wireName: "project_status")
  @nullable
  String get projectStatus;

  @BuiltValueField(wireName: "short_summary")
  @nullable
  String get shortSummary;

  @BuiltValueField(wireName: "user_name")
  @nullable
  String get username;

  @BuiltValueField(wireName: "manager_name")
  @nullable
  String get managerName;

  @nullable
  SignProject get project;

  /// serializer
  static Serializer<Invitation> get serializer => _$invitationSerializer;

  /// get Invitation from Json
  static Invitation fromJson(dynamic json) => standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
