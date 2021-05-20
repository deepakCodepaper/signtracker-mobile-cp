import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/model/project_company.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/api/serializers.dart';

part 'update_project_request.g.dart';

abstract class UpdateProjectRequest
    implements Built<UpdateProjectRequest, UpdateProjectRequestBuilder> {
  /// Initializes a new instance of the [UpdateProjectRequest] class
  factory UpdateProjectRequest([updates(UpdateProjectRequestBuilder b)]) =
      _$UpdateProjectRequest;

  UpdateProjectRequest._();

  UpdateProjectRequest createUpdateProjectRequest(SignProject project) {
    return _$UpdateProjectRequest._(
      method: 'PUT',
      id: project.id,
      companyId: project.companyId,
      parent: project.parent,
      identifier: project.identifier,
      type: project.type,
      highway: project.highway,
      intersection: project.intersection,
      speed: project.speed,
      distance: project.distance,
      createdAt: project.createdAt,
      updatedAt: project.updatedAt,
      status: project.status,
      notifyFrequency: project.notifyFrequency,
      inactiveNotifyFrequency: project.inactiveNotifyFrequency,
      signPlacement: project.signPlacement,
      startDate: project.startDate,
      endDate: project.endDate,
      closedAt: project.closedAt,
      workArea: project.workArea,
      designation: project.designation,
      shortSummary: project.shortSummary,
      location: project.location,
      projectCompany: project.projectCompany,
      isSubProject: project.isSubProject,
      userIds: project.userIds,
      startedBy: project.startedBy,
      onTime: project.onTime,
      closedEndDiff: project.closedEndDiff,
      closedEndDiffHours: project.closedEndDiffHours,
    );
  }

  @nullable
  @BuiltValueField(wireName: "_method")
  String get method;

  @nullable
  int get id;

  @BuiltValueField(wireName: "company_id")
  @nullable
  int get companyId;

  @nullable
  int get parent;

  @nullable
  String get identifier;

  @nullable
  String get type;

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

  @BuiltValueField(wireName: "project_company")
  @nullable
  ProjectCompany get projectCompany;

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

  /// serializer
  static Serializer<UpdateProjectRequest> get serializer =>
      _$updateProjectRequestSerializer;

  /// get SignProject from Json
  static UpdateProjectRequest fromJson(dynamic json) =>
      standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
