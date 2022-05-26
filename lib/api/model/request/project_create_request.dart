import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/serializers.dart';

import '../sign_project.dart';

part 'project_create_request.g.dart';

abstract class ProjectCreateRequest
    implements Built<ProjectCreateRequest, ProjectCreateRequestBuilder> {
  /// Initializes a new instance of the [ProjectCreateRequest] class
  factory ProjectCreateRequest([updates(ProjectCreateRequestBuilder b)]) =
      _$ProjectCreateRequest;

  ProjectCreateRequest._();

  ProjectCreateRequest copy(SignProject project) {
    return _$ProjectCreateRequest._(
        identifier: project.identifier,
        type: project.type,
        highway: project.highway,
        commissionedBy: project.commissionedBy,
        description: project.description,
        intersection: project.intersection,
        speed: project.speed,
        distance: project.distance,
        templateId: project.templateId,
        startDate: project.startDate,
        endDate: project.endDate,
        notifyFrequency: project.notifyFrequency,
        inactiveNotifyFrequency: project.inactiveNotifyFrequency);
  }

  ProjectCreateRequest copyWithImage(SignProject project) {
    return _$ProjectCreateRequest._(
        parent: project.parent,
        identifier: project.identifier,
        commissionedBy: project.commissionedBy,
        description: project.description,
        plan: project.plan,
        type: project.type,
        highway: project.highway,
        intersection: project.intersection,
        speed: project.speed,
        distance: project.distance,
        templateId: project.templateId,
        startDate: project.startDate,
        endDate: project.endDate,
        notifyFrequency: project.notifyFrequency,
        inactiveNotifyFrequency: project.inactiveNotifyFrequency);
  }

  ProjectCreateRequest copySubProject(SignProject project) {
    return _$ProjectCreateRequest._(
      parent: project.parent,
      identifier: project.identifier,
      commissionedBy: project.commissionedBy,
      description: project.description,
      type: project.type,
      highway: project.highway,
      intersection: project.intersection,
      speed: project.speed,
      distance: project.distance,
      templateId: project.templateId,
    );
  }

  @nullable
  int get parent;

  @nullable
  String get identifier;

  @BuiltValueField(wireName: "template_id")
  @nullable
  int get templateId;

  @BuiltValueField(wireName: "commissioned_by")
  @nullable
  String get commissionedBy;

  @nullable
  String get description;

  @nullable
  String get plan;

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

  @BuiltValueField(wireName: "start_date")
  @nullable
  String get startDate;

  @BuiltValueField(wireName: "end_date")
  @nullable
  String get endDate;

  @BuiltValueField(wireName: "notify_frequency")
  @nullable
  int get notifyFrequency;

  @BuiltValueField(wireName: "inactive_notify_frequency")
  @nullable
  int get inactiveNotifyFrequency;

  /// serializer
  static Serializer<ProjectCreateRequest> get serializer =>
      _$projectCreateRequestSerializer;

  /// get Sign from Json
  static ProjectCreateRequest fromJson(dynamic json) =>
      standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
