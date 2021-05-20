import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/model/members.dart';
import 'package:signtracker/api/model/project_company.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/api/serializers.dart';

part 'check_sign_project.g.dart';

abstract class CheckSignProject
    implements Built<CheckSignProject, CheckSignProjectBuilder> {
  /// Initializes a new instance of the [SignProject] class
  factory CheckSignProject([updates(CheckSignProjectBuilder b)]) =
      _$CheckSignProject;

  CheckSignProject._();

  @nullable
  int get id;

  @BuiltValueField(wireName: "project_id")
  @nullable
  int get projectId;

  @BuiltValueField(wireName: "schedule")
  @nullable
  DateTime get schedule;

  @BuiltValueField(wireName: "status")
  @nullable
  String get status;

  @BuiltValueField(wireName: "project")
  @nullable
  SignProject get project;

  @BuiltValueField(wireName: "created_at")
  @nullable
  DateTime get createdAt;

  @BuiltValueField(wireName: "updated_at")
  @nullable
  DateTime get updatedAt;

  /// serializer
  static Serializer<CheckSignProject> get serializer =>
      _$checkSignProjectSerializer;

  /// get SignProject from Json
  static CheckSignProject fromJson(dynamic json) =>
      standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
