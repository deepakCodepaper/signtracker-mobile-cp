import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/serializers.dart';

part 'sign_masters.g.dart';

abstract class SignMasters implements Built<SignMasters, SignMastersBuilder> {
  /// Initializes a new instance of the [Sign] class
  factory SignMasters([updates(SignMastersBuilder b)]) = _$SignMasters;

  SignMasters._();

  @nullable
  int get id;

  @nullable
  String get name;

  @BuiltValueField(wireName: "id_name")
  @nullable
  String get idName;

  @nullable
  String get image;

  @BuiltValueField(wireName: "approved_at")
  @nullable
  DateTime get approvedAt;

  @BuiltValueField(wireName: "created_at")
  @nullable
  DateTime get createdAt;

  @BuiltValueField(wireName: "updated_at")
  @nullable
  DateTime get updatedAt;

  @BuiltValueField(wireName: "image_url")
  @nullable
  String get imageUrl;

  @BuiltValueField(wireName: "is_approved")
  @nullable
  bool get isApproved;

  @BuiltValueField(wireName: "favourite_by_users_count")
  @nullable
  int get isFavorite;

  /// serializer
  static Serializer<SignMasters> get serializer => _$signMastersSerializer;

  /// get Sign from Json
  static SignMasters fromJson(dynamic json) =>
      standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
