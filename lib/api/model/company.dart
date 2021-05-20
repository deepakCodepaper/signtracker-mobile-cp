import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/model/project_company.dart';
import 'package:signtracker/api/serializers.dart';

part 'company.g.dart';

abstract class Company implements Built<Company, CompanyBuilder> {
  /// Initializes a new instance of the [Members] class
  factory Company([updates(CompanyBuilder b)]) = _$Company;

  Company._();

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
  static Serializer<Company> get serializer => _$companySerializer;

  /// get Invitation from Json
  static Company fromJson(dynamic json) =>
      standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
