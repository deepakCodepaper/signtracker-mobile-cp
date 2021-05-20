import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/model/sign.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/api/model/user.dart';
import 'package:signtracker/api/serializers.dart';

import 'details.dart';

part 'project_logs.g.dart';

abstract class ProjectLogs implements Built<ProjectLogs, ProjectLogsBuilder> {
  /// Initializes a new instance of the [ProjectLogs] class
  factory ProjectLogs([updates(ProjectLogsBuilder b)]) = _$ProjectLogs;

  ProjectLogs._();

  @nullable
  int get id;

  @nullable
  String get message;

  @BuiltValueField(wireName: "project_id")
  @nullable
  int get projectId;

  @BuiltValueField(wireName: "created_at")
  @nullable
  DateTime get createdAt;

  @BuiltValueField(wireName: "updated_at")
  @nullable
  DateTime get updatedAt;

  @BuiltValueField(wireName: "updated_by")
  @nullable
  User get updatedBy;

  @BuiltValueField(wireName: "details")
  @nullable
  Details get details;

  /// serializer
  static Serializer<ProjectLogs> get serializer => _$projectLogsSerializer;

  /// get Sign from Json
  static ProjectLogs fromJson(dynamic json) =>
      standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
