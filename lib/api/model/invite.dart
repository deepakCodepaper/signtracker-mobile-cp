import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/serializers.dart';

part 'invite.g.dart';

abstract class Invite implements Built<Invite, InviteBuilder> {
  /// Initializes a new instance of the [Invite] class
  factory Invite([updates(InviteBuilder b)]) = _$Invite;

  Invite._();

  @BuiltValueField(wireName: "user_id")
  @nullable
  int get userId;

  @BuiltValueField(wireName: "project_id")
  @nullable
  int get projectId;

  @BuiltValueField(wireName: "notes")
  @nullable
  String get notes;

  /// serializer
  static Serializer<Invite> get serializer => _$inviteSerializer;

  /// get ProjectCompany from Json
  static Invite fromJson(dynamic json) => standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
