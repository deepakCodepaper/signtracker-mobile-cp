import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/model/sign.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/api/serializers.dart';

part 'details.g.dart';

abstract class Details implements Built<Details, DetailsBuilder> {
  /// Initializes a new instance of the [ProjectLogs] class
  factory Details([updates(DetailsBuilder b)]) = _$Details;

  Details._();

  @BuiltValueField(wireName: "sign")
  @nullable
  Sign get sign;

  /// serializer
  static Serializer<Details> get serializer => _$detailsSerializer;

  /// get Sign from Json
  static Details fromJson(dynamic json) =>
      standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
