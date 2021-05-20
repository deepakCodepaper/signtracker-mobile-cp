import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/serializers.dart';

import '../emails.dart';

part 'company_invite_request.g.dart';

abstract class CompanyInviteRequest
    implements Built<CompanyInviteRequest, CompanyInviteRequestBuilder> {
  /// Initializes a new instance of the [CompanyInviteRequest] class
  factory CompanyInviteRequest([updates(CompanyInviteRequestBuilder b)]) =
      _$CompanyInviteRequest;

  CompanyInviteRequest._();

  CompanyInviteRequest copy(BuiltList<int> emails) {
    return _$CompanyInviteRequest._(
      companies: emails,
    );
  }

  @BuiltValueField(wireName: "company_ids")
  @nullable
  BuiltList<int> get companies;

  /// serializer
  static Serializer<CompanyInviteRequest> get serializer =>
      _$companyInviteRequestSerializer;

  /// get Sign from Json
  static CompanyInviteRequest fromJson(dynamic json) =>
      standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
