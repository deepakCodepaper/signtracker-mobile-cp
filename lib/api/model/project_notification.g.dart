// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_notification.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProjectNotification> _$projectNotificationSerializer =
    new _$ProjectNotificationSerializer();

class _$ProjectNotificationSerializer
    implements StructuredSerializer<ProjectNotification> {
  @override
  final Iterable<Type> types = const [
    ProjectNotification,
    _$ProjectNotification
  ];
  @override
  final String wireName = 'ProjectNotification';

  @override
  Iterable<Object> serialize(
      Serializers serializers, ProjectNotification object,
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
    value = object.day;
    if (value != null) {
      result
        ..add('day')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.time;
    if (value != null) {
      result
        ..add('time')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.lastNotificationSendAt;
    if (value != null) {
      result
        ..add('last_notification_send_at')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ProjectNotification deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProjectNotificationBuilder();

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
        case 'day':
          result.day = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'time':
          result.time = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'last_notification_send_at':
          result.lastNotificationSendAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ProjectNotification extends ProjectNotification {
  @override
  final int id;
  @override
  final int projectId;
  @override
  final int day;
  @override
  final String time;
  @override
  final String lastNotificationSendAt;

  factory _$ProjectNotification(
          [void Function(ProjectNotificationBuilder) updates]) =>
      (new ProjectNotificationBuilder()..update(updates)).build();

  _$ProjectNotification._(
      {this.id,
      this.projectId,
      this.day,
      this.time,
      this.lastNotificationSendAt})
      : super._();

  @override
  ProjectNotification rebuild(
          void Function(ProjectNotificationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectNotificationBuilder toBuilder() =>
      new ProjectNotificationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProjectNotification &&
        id == other.id &&
        projectId == other.projectId &&
        day == other.day &&
        time == other.time &&
        lastNotificationSendAt == other.lastNotificationSendAt;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, id.hashCode), projectId.hashCode), day.hashCode),
            time.hashCode),
        lastNotificationSendAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProjectNotification')
          ..add('id', id)
          ..add('projectId', projectId)
          ..add('day', day)
          ..add('time', time)
          ..add('lastNotificationSendAt', lastNotificationSendAt))
        .toString();
  }
}

class ProjectNotificationBuilder
    implements Builder<ProjectNotification, ProjectNotificationBuilder> {
  _$ProjectNotification _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  int _projectId;
  int get projectId => _$this._projectId;
  set projectId(int projectId) => _$this._projectId = projectId;

  int _day;
  int get day => _$this._day;
  set day(int day) => _$this._day = day;

  String _time;
  String get time => _$this._time;
  set time(String time) => _$this._time = time;

  String _lastNotificationSendAt;
  String get lastNotificationSendAt => _$this._lastNotificationSendAt;
  set lastNotificationSendAt(String lastNotificationSendAt) =>
      _$this._lastNotificationSendAt = lastNotificationSendAt;

  ProjectNotificationBuilder();

  ProjectNotificationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _projectId = $v.projectId;
      _day = $v.day;
      _time = $v.time;
      _lastNotificationSendAt = $v.lastNotificationSendAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectNotification other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProjectNotification;
  }

  @override
  void update(void Function(ProjectNotificationBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProjectNotification build() {
    final _$result = _$v ??
        new _$ProjectNotification._(
            id: id,
            projectId: projectId,
            day: day,
            time: time,
            lastNotificationSendAt: lastNotificationSendAt);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
