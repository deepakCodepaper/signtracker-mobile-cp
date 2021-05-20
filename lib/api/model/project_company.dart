import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/serializers.dart';

part 'project_company.g.dart';

abstract class ProjectCompany implements Built<ProjectCompany, ProjectCompanyBuilder> {
  /// Initializes a new instance of the [ProjectCompany] class
  factory ProjectCompany([updates(ProjectCompanyBuilder b)]) = _$ProjectCompany;

  ProjectCompany._();

  @nullable
  int get id;

  @BuiltValueField(wireName: "manager_id")
  @nullable
  int get managerId;

  @nullable
  String get logo;

  @nullable
  String get name;

  @nullable
  String get email;

  @BuiltValueField(wireName: "sub_start")
  @nullable
  DateTime get subStart;

  @BuiltValueField(wireName: "sub_end")
  @nullable
  DateTime get subEnd;

  @BuiltValueField(wireName: "payment_fee")
  @nullable
  double get paymentFee;

  @BuiltValueField(wireName: "created_at")
  @nullable
  DateTime get createdAt;

  @BuiltValueField(wireName: "updated_at")
  @nullable
  DateTime get updatedAt;

  /// serializer
  static Serializer<ProjectCompany> get serializer => _$projectCompanySerializer;

  /// get ProjectCompany from Json
  static ProjectCompany fromJson(dynamic json) => standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}