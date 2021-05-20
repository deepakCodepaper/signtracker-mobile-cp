import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:signtracker/api/serializers.dart';

part 'schedule.g.dart';

abstract class Schedule implements Built<Schedule, ScheduleBuilder> {
  /// Initializes a new instance of the [Members] class
  factory Schedule([updates(ScheduleBuilder b)]) = _$Schedule;

  Schedule._();

  @nullable
  int get id;

  @BuiltValueField(wireName: "project_id")
  @nullable
  int get projectId;

  @BuiltValueField(wireName: "every_n_days")
  @nullable
  int get daily;

  @BuiltValueField(wireName: "every_n_weeks")
  @nullable
  int get weekly;

  @BuiltValueField(wireName: "day")
  @nullable
  String get day;

  @BuiltValueField(wireName: "time")
  @nullable
  String get time;

  /// serializer
  static Serializer<Schedule> get serializer => _$scheduleSerializer;

  /// get Emails from Json
  static Schedule fromJson(dynamic json) =>
      standardSerializers.deserialize(json);

  ///convert to Json
  dynamic toJson() => standardSerializers.serialize(this);

  factory Schedule.fromJsonMap(Map<String, dynamic> data) {
    return serializers.deserializeWith(Schedule.serializer, data);
  }

  Map<String, dynamic> toJsonMap() {
    return new Map.of(serializers.serialize(this,
            specifiedType: const FullType(Schedule)))
        .cast<String, dynamic>();
  }
}
