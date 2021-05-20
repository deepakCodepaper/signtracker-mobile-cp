import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/serializers.dart';

import '../emails.dart';

part 'emails_request.g.dart';

abstract class EmailsRequest
    implements Built<EmailsRequest, EmailsRequestBuilder> {
  /// Initializes a new instance of the [EmailsRequest] class
  factory EmailsRequest([updates(EmailsRequestBuilder b)]) = _$EmailsRequest;

  EmailsRequest._();

  EmailsRequest copy(BuiltList<String> emails) {
    return _$EmailsRequest._(
      emails: emails,
    );
  }

  @BuiltValueField(wireName: "emails")
  @nullable
  BuiltList<String> get emails;

  /// serializer
  static Serializer<EmailsRequest> get serializer => _$emailsRequestSerializer;

  /// get Sign from Json
  static EmailsRequest fromJson(dynamic json) =>
      standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
