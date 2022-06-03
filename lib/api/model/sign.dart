import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/serializers.dart';

part 'sign.g.dart';

abstract class Sign implements Built<Sign, SignBuilder> {
  /// Initializes a new instance of the [Sign] class
  factory Sign([updates(SignBuilder b)]) = _$Sign;

  Sign._();

  @nullable
  int get id;

  @nullable
  String get status;

  @BuiltValueField(wireName: "project_id")
  @nullable
  int get projectId;

  @BuiltValueField(wireName: "id_name")
  @nullable
  String get idName;

  @nullable
  double get lat;

  @nullable
  double get lng;

  @nullable
  String get name;

  @nullable
  int get traffic;

  @nullable
  String get image;

  @BuiltValueField(wireName: "created_at")
  @nullable
  DateTime get createdAt;

  @BuiltValueField(wireName: "updated_at")
  @nullable
  DateTime get updatedAt;

  @BuiltValueField(wireName: "id_name")
  @nullable
  String get nameId;

  @BuiltValueField(wireName: "sign_master_id")
  @nullable
  int get signMasterId;

  @nullable
  bool get isChecked;

  @nullable
  String get notes;

  /// serializer
  static Serializer<Sign> get serializer => _$signSerializer;

  /// get Sign from Json
  static Sign fromJson(dynamic json) => standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
