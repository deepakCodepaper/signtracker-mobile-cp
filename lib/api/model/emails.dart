import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/serializers.dart';

part 'emails.g.dart';

abstract class Emails implements Built<Emails, EmailsBuilder> {
  /// Initializes a new instance of the [Members] class
  factory Emails([updates(EmailsBuilder b)]) = _$Emails;

  Emails._();

  BuiltList<String> get emails;

  /// serializer
  static Serializer<Emails> get serializer => _$emailsSerializer;

  /// get Emails from Json
  static Emails fromJson(dynamic json) => standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);

  factory Emails.fromJsonMap(Map<String, dynamic> data) {
    return serializers.deserializeWith(Emails.serializer, data);
  }

  Map<String, dynamic> toJsonMap() {
    return new Map.of(
            serializers.serialize(this, specifiedType: const FullType(Emails)))
        .cast<String, dynamic>();
  }
}
