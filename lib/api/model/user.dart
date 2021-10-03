import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/serializers.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  /// Initializes a new instance of the [User] class
  factory User([updates(UserBuilder b)]) = _$User;

  User._();

  int get id;

  @nullable
  String get name;

  @nullable
  String get email;

  @BuiltValueField(wireName: "created_at")
  @nullable
  DateTime get createdAt;

  @BuiltValueField(wireName: "updated_at")
  @nullable
  DateTime get updatedAt;

  @nullable
  String get username;

  @nullable
  String get phone;

  @nullable
  String get avatar;

  @BuiltValueField(wireName: "country_code")
  @nullable
  String get countryCode;

  @BuiltValueField(wireName: "state_code")
  @nullable
  String get stateCode;

  /// serializer
  static Serializer<User> get serializer => _$userSerializer;

  /// get User from Json
  static User fromJson(dynamic json) => standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
