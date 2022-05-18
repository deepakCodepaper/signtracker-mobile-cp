import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/serializers.dart';

part 'template.g.dart';

abstract class Template implements Built<Template, TemplateBuilder> {
  /// Initializes a new instance of the [Template] class
  factory Template([updates(TemplateBuilder b)]) = _$Template;

  Template._();

  @nullable
  int get id;

  @BuiltValueField(wireName: "company_id")
  @nullable
  int get companyId;

  @BuiltValueField(wireName: "drawing_number")
  @nullable
  String get drawingNumber;

  @nullable
  String get name;

  @BuiltValueField(wireName: "image_url")
  @nullable
  String get imageUrl;

  @BuiltValueField(wireName: "created_at")
  @nullable
  DateTime get createdAt;

  @BuiltValueField(wireName: "updated_at")
  @nullable
  DateTime get updatedAt;

  @BuiltValueField(wireName: "sort_index")
  @nullable
  int get sortIndex;

  @BuiltValueField(wireName: "row_number")
  @nullable
  int get rowNumber;

  @BuiltValueField(wireName: "template")
  @nullable
  Template get template;

  /// serializer
  static Serializer<Template> get serializer => _$templateSerializer;

  /// get SignProject from Json
  static Template fromJson(dynamic json) =>
      standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}
