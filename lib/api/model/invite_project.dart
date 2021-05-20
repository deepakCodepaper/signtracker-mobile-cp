import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/serializers.dart';

part 'invite_project.g.dart';

abstract class InviteProject
    implements Built<InviteProject, InviteProjectBuilder> {
  /// Initializes a new instance of the [ProjectCompany] class
  factory InviteProject([updates(InviteProjectBuilder b)]) = _$InviteProject;

  InviteProject._();

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

  @BuiltValueField(wireName: "shorts_summary")
  @nullable
  String get shortSummary;

  @BuiltValueField(wireName: "user_name")
  @nullable
  String get userName;

  @BuiltValueField(wireName: "manager_name")
  @nullable
  String get managerName;

  /// serializer
  static Serializer<InviteProject> get serializer => _$inviteProjectSerializer;

  /// get ProjectCompany from Json
  static InviteProject fromJson(dynamic json) =>
      standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
