import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/serializers.dart';

part 'project_notification.g.dart';

abstract class ProjectNotification implements Built<ProjectNotification, ProjectNotificationBuilder> {
  /// Initializes a new instance of the [SignProject] class
  factory ProjectNotification([updates(ProjectNotificationBuilder b)]) = _$ProjectNotification;

  ProjectNotification._();

  @nullable
  int get id;

  @BuiltValueField(wireName: "project_id")
  @nullable
  int get projectId;

  @nullable
  int get day;

  @nullable
  String get time;

  @BuiltValueField(wireName: "last_notification_send_at")
  @nullable
  String get lastNotificationSendAt;

  /// serializer
  static Serializer<ProjectNotification> get serializer => _$projectNotificationSerializer;

  /// get SignProject from Json
  static ProjectNotification fromJson(dynamic json) =>
      standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}