import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/model/sign.dart';
import 'package:signtracker/api/serializers.dart';

import '../sign_masters.dart';

part 'sign_request.g.dart';

abstract class SignRequest implements Built<SignRequest, SignRequestBuilder> {
  /// Initializes a new instance of the [SignRequest] class
  factory SignRequest([updates(SignRequestBuilder b)]) = _$SignRequest;

  SignRequest._();

  SignRequest copy(Sign sign) {
    return _$SignRequest._(
      projectId: sign.projectId,
      name: sign.name,
      nameId: sign.nameId,
      signMasterId: sign.id,
      status: sign.status,
      traffic: sign.traffic,
      lat: sign.lat,
      lng: sign.lng,
    );
  }

  @BuiltValueField(wireName: "_method")
  @nullable
  String get method;

  @nullable
  String get status;

  @BuiltValueField(wireName: "project_id")
  @nullable
  int get projectId;

  @nullable
  double get lat;

  @nullable
  double get lng;

  @nullable
  String get name;

  @BuiltValueField(wireName: "id_name")
  @nullable
  String get nameId;

  @BuiltValueField(wireName: "sign_master_id")
  @nullable
  int get signMasterId;

  @nullable
  int get traffic;

  /// serializer
  static Serializer<SignRequest> get serializer => _$signRequestSerializer;

  /// get Sign from Json
  static SignRequest fromJson(dynamic json) =>
      standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
