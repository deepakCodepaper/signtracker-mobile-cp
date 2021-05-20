import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/serializers.dart';

import '../invite.dart';

part 'send_invite_request.g.dart';

abstract class SendInviteRequest
    implements Built<SendInviteRequest, SendInviteRequestBuilder> {
  /// Initializes a new instance of the [SendInviteRequest] class
  factory SendInviteRequest([updates(SendInviteRequestBuilder b)]) =
      _$SendInviteRequest;

  SendInviteRequest._();

  SendInviteRequest copy(Invite invite) {
    return _$SendInviteRequest._(
        userId: invite.userId,
        projectId: invite.projectId,
        notes: invite.notes);
  }

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
  static Serializer<SendInviteRequest> get serializer =>
      _$sendInviteRequestSerializer;

  /// get Sign from Json
  static SendInviteRequest fromJson(dynamic json) =>
      standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
