import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/serializers.dart';

part 'base_model.g.dart';

abstract class BaseModel<T> implements Built<BaseModel<T>, BaseModelBuilder<T>> {
  /// Initializes a new instance of the [BaseModel] class
  factory BaseModel([updates(BaseModelBuilder<T> b)]) = _$BaseModel<T>;

  BaseModel._();

  @nullable
  bool get success;

  @nullable
  T get data;

  @nullable
  String get message;

  /// serializer
  static Serializer<BaseModel> get serializer => _$baseModelSerializer;

  /// get BaseModel from Json
  static BaseModel fromJson(dynamic json) => standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);
}