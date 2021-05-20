import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/model/user.dart';
import 'package:signtracker/api/serializers.dart';

part 'login.g.dart';

abstract class Login implements Built<Login, LoginBuilder> {
  /// Initializes a new instance of the [Login] class
  factory Login([updates(LoginBuilder b)]) = _$Login;

  Login._();

  bool get success;

  @BuiltValueField(wireName: "access_token")
  String get accessToken;

  @BuiltValueField(wireName: "token_type")
  String get tokenType;

  @BuiltValueField(wireName: "expires_in")
  int get expiresIn;

  //TODO fix data type of fields and uncomment
  @BuiltValueField(wireName: "user")
  User get user;

  /// serializer
  static Serializer<Login> get serializer => _$loginSerializer;

  /// get Login from Json
  static Login fromJson(dynamic json) => standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
