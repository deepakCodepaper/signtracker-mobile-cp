import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/model/project_notification.dart';
import 'package:signtracker/api/serializers.dart';

part 'project_notification_request.g.dart';

abstract class ProjectNotificationRequest implements Built<ProjectNotificationRequest, ProjectNotificationRequestBuilder> {
  /// Initializes a new instance of the [SignRequest] class
  factory ProjectNotificationRequest(
      [updates(ProjectNotificationRequestBuilder b)]) = _$ProjectNotificationRequest;

  ProjectNotificationRequest._();

  ProjectNotificationRequest copy(ProjectNotification projectNotification) {
    return _$ProjectNotificationRequest._(
      projectId: projectNotification.id,
      day: projectNotification.day,
      time: projectNotification.time,
    );
  }

  @BuiltValueField(wireName: "_method")
  @nullable
  String get method;

  @BuiltValueField(wireName: "project_id")
  @nullable
  int get projectId;

  @nullable
  int get day;

  @nullable
  String get time;

  /// serializer
  static Serializer<ProjectNotificationRequest> get serializer => _$projectNotificationRequestSerializer;

  /// get Sign from Json
  static ProjectNotificationRequest fromJson(dynamic json) =>
      standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);

}