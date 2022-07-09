import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/model/members.dart';
import 'package:signtracker/api/model/project_company.dart';
import 'package:signtracker/api/model/project_notification.dart';
import 'package:signtracker/api/model/template.dart';
import 'package:signtracker/api/serializers.dart';

part 'sign_project.g.dart';

abstract class SignProject implements Built<SignProject, SignProjectBuilder> {
  /// Initializes a new instance of the [SignProject] class
  factory SignProject([updates(SignProjectBuilder b)]) = _$SignProject;

  SignProject._();

  @nullable
  int get id;

  @BuiltValueField(wireName: "company_id")
  @nullable
  int get companyId;

  @BuiltValueField(wireName: "template_id")
  @nullable
  int get templateId;

  @nullable
  int get parent;

  @BuiltValueField(wireName: "contract_number")
  @nullable
  String get contractNumber;

  @BuiltValueField(wireName: "commissioned_by")
  @nullable
  String get commissionedBy;

  @nullable
  String get description;

  @nullable
  String get identifier;

  @nullable
  String get type;

  @nullable
  String get plan;

  @nullable
  String get highway;

  @nullable
  String get intersection;

  @nullable
  double get speed;

  @nullable
  double get distance;

  @BuiltValueField(wireName: "created_at")
  @nullable
  DateTime get createdAt;

  @BuiltValueField(wireName: "updated_at")
  @nullable
  DateTime get updatedAt;

  @nullable
  String get status;

  @BuiltValueField(wireName: "notify_frequency")
  @nullable
  int get notifyFrequency;

  @BuiltValueField(wireName: "inactive_notify_frequency")
  @nullable
  int get inactiveNotifyFrequency;

  @BuiltValueField(wireName: "start_date")
  @nullable
  String get startDate;

  @BuiltValueField(wireName: "end_date")
  @nullable
  String get endDate;

  @BuiltValueField(wireName: "closed_at")
  @nullable
  DateTime get closedAt;

  @BuiltValueField(wireName: "sign_placement")
  @nullable
  String get signPlacement;

  @nullable
  String get location;

  @nullable
  String get designation;

  @BuiltValueField(wireName: "work_area")
  @nullable
  String get workArea;

  @BuiltValueField(wireName: "short_summary")
  @nullable
  String get shortSummary;

  @BuiltValueField(wireName: "template_image_url")
  @nullable
  String get templateImageUrl;

  @BuiltValueField(wireName: "project_company")
  @nullable
  ProjectCompany get projectCompany;

  @BuiltValueField(wireName: "template")
  @nullable
  Template get template;

  @BuiltValueField(wireName: "is_sub_project")
  @nullable
  bool get isSubProject;

  @BuiltValueField(wireName: "user_ids")
  @nullable
  BuiltList<int> get userIds;

  @BuiltValueField(wireName: "started_by")
  @nullable
  int get startedBy;

  @BuiltValueField(wireName: "on_time")
  @nullable
  bool get onTime;

  @BuiltValueField(wireName: "closed_end_diff")
  @nullable
  int get closedEndDiff;

  @BuiltValueField(wireName: "closed_end_diff_hours")
  @nullable
  int get closedEndDiffHours;

  @BuiltValueField(wireName: "_method")
  @nullable
  String get method;

  @BuiltValueField(wireName: "project_notifications")
  @nullable
  BuiltList<ProjectNotification> get projectNotifications;

  @BuiltValueField(wireName: "sub_projects")
  @nullable
  BuiltList<SignProject> get subProjects;

  @nullable
  BuiltList<Members> get members;

  /// serializer
  static Serializer<SignProject> get serializer => _$signProjectSerializer;

  /// get SignProject from Json
  static SignProject fromJson(dynamic json) =>
      standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
