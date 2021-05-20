import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/model/project_company.dart';
import 'package:signtracker/api/serializers.dart';

part 'members.g.dart';

abstract class Members implements Built<Members, MembersBuilder> {
  /// Initializes a new instance of the [Members] class
  factory Members([updates(MembersBuilder b)]) = _$Members;

  Members._();

  @nullable
  int get id;

  @nullable
  String get name;

  @nullable
  String get email;

  @BuiltValueField(wireName: "is_invited")
  @nullable
  bool get isInvited;

  /// serializer
  static Serializer<Members> get serializer => _$membersSerializer;

  /// get Invitation from Json
  static Members fromJson(dynamic json) =>
      standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
