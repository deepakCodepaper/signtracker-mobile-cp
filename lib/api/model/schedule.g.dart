// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Schedule> _$scheduleSerializer = new _$ScheduleSerializer();

class _$ScheduleSerializer implements StructuredSerializer<Schedule> {
  @override
  final Iterable<Type> types = const [Schedule, _$Schedule];
  @override
  final String wireName = 'Schedule';

  @override
  Iterable<Object> serialize(Serializers serializers, Schedule object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.projectId;
    if (value != null) {
      result
        ..add('project_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.daily;
    if (value != null) {
      result
        ..add('every_n_days')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.weekly;
    if (value != null) {
      result
        ..add('every_n_weeks')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.day;
    if (value != null) {
      result
        ..add('day')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.time;
    if (value != null) {
      result
        ..add('time')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Schedule deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ScheduleBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'project_id':
          result.projectId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'every_n_days':
          result.daily = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'every_n_weeks':
          result.weekly = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'day':
          result.day = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'time':
          result.time = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Schedule extends Schedule {
  @override
  final int id;
  @override
  final int projectId;
  @override
  final int daily;
  @override
  final int weekly;
  @override
  final String day;
  @override
  final String time;

  factory _$Schedule([void Function(ScheduleBuilder) updates]) =>
      (new ScheduleBuilder()..update(updates)).build();

  _$Schedule._(
      {this.id, this.projectId, this.daily, this.weekly, this.day, this.time})
      : super._();

  @override
  Schedule rebuild(void Function(ScheduleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScheduleBuilder toBuilder() => new ScheduleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Schedule &&
        id == other.id &&
        projectId == other.projectId &&
        daily == other.daily &&
        weekly == other.weekly &&
        day == other.day &&
        time == other.time;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, id.hashCode), projectId.hashCode),
                    daily.hashCode),
                weekly.hashCode),
            day.hashCode),
        time.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Schedule')
          ..add('id', id)
          ..add('projectId', projectId)
          ..add('daily', daily)
          ..add('weekly', weekly)
          ..add('day', day)
          ..add('time', time))
        .toString();
  }
}

class ScheduleBuilder implements Builder<Schedule, ScheduleBuilder> {
  _$Schedule _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  int _projectId;
  int get projectId => _$this._projectId;
  set projectId(int projectId) => _$this._projectId = projectId;

  int _daily;
  int get daily => _$this._daily;
  set daily(int daily) => _$this._daily = daily;

  int _weekly;
  int get weekly => _$this._weekly;
  set weekly(int weekly) => _$this._weekly = weekly;

  String _day;
  String get day => _$this._day;
  set day(String day) => _$this._day = day;

  String _time;
  String get time => _$this._time;
  set time(String time) => _$this._time = time;

  ScheduleBuilder();

  ScheduleBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _projectId = $v.projectId;
      _daily = $v.daily;
      _weekly = $v.weekly;
      _day = $v.day;
      _time = $v.time;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Schedule other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Schedule;
  }

  @override
  void update(void Function(ScheduleBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Schedule build() {
    final _$result = _$v ??
        new _$Schedule._(
            id: id,
            projectId: projectId,
            daily: daily,
            weekly: weekly,
            day: day,
            time: time);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
