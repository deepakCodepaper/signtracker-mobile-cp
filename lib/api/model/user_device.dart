import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'user_device.g.dart';

abstract class UserDevice implements Built<UserDevice, UserDeviceBuilder> {
  /// Initializes a new instance of the [User] class
  factory UserDevice([updates(UserDeviceBuilder b)]) = _$UserDevice;

  UserDevice._();

  @nullable
  int get id;

  @BuiltValueField(wireName: "player_id")
  @nullable
  String get playerId;

  @BuiltValueField(wireName: "user_id")
  @nullable
  int get userId;

  /// serializer
  static Serializer<UserDevice> get serializer => _$userDeviceSerializer;

  /// get UserDevice from Json
  static UserDevice fromJson(dynamic json) =>
      standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
