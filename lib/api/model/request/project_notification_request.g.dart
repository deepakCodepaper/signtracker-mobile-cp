// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_notification_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProjectNotificationRequest> _$projectNotificationRequestSerializer =
    new _$ProjectNotificationRequestSerializer();

class _$ProjectNotificationRequestSerializer
    implements StructuredSerializer<ProjectNotificationRequest> {
  @override
  final Iterable<Type> types = const [
    ProjectNotificationRequest,
    _$ProjectNotificationRequest
  ];
  @override
  final String wireName = 'ProjectNotificationRequest';

  @override
  Iterable<Object> serialize(
      Serializers serializers, ProjectNotificationRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.method;
    if (value != null) {
      result
        ..add('_method')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
        ..add(serializers.serialize(value, specifiedType: const FullType(String)));
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
  ProjectNotificationRequest deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProjectNotificationRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case '_method':
          result.method = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'project_id':
          result.projectId = serializers.deserialize(value,
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

class _$ProjectNotificationRequest extends ProjectNotificationRequest {
  @override
  final String method;
  @override
  final int projectId;
  @override
  final String day;
  @override
  final String time;

  factory _$ProjectNotificationRequest(
          [void Function(ProjectNotificationRequestBuilder) updates]) =>
      (new ProjectNotificationRequestBuilder()..update(updates)).build();

  _$ProjectNotificationRequest._(
      {this.method, this.projectId, this.day, this.time})
      : super._();

  @override
  ProjectNotificationRequest rebuild(
          void Function(ProjectNotificationRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectNotificationRequestBuilder toBuilder() =>
      new ProjectNotificationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProjectNotificationRequest &&
        method == other.method &&
        projectId == other.projectId &&
        day == other.day &&
        time == other.time;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, method.hashCode), projectId.hashCode), day.hashCode),
        time.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProjectNotificationRequest')
          ..add('method', method)
          ..add('projectId', projectId)
          ..add('day', day)
          ..add('time', time))
        .toString();
  }
}

class ProjectNotificationRequestBuilder
    implements
        Builder<ProjectNotificationRequest, ProjectNotificationRequestBuilder> {
  _$ProjectNotificationRequest _$v;

  String _method;
  String get method => _$this._method;
  set method(String method) => _$this._method = method;

  int _projectId;
  int get projectId => _$this._projectId;
  set projectId(int projectId) => _$this._projectId = projectId;

  String _day;
  String get day => _$this._day;
  set day(String day) => _$this._day = day;

  String _time;
  String get time => _$this._time;
  set time(String time) => _$this._time = time;

  ProjectNotificationRequestBuilder();

  ProjectNotificationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _method = $v.method;
      _projectId = $v.projectId;
      _day = $v.day;
      _time = $v.time;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectNotificationRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProjectNotificationRequest;
  }

  @override
  void update(void Function(ProjectNotificationRequestBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProjectNotificationRequest build() {
    final _$result = _$v ??
        new _$ProjectNotificationRequest._(
            method: method, projectId: projectId, day: day, time: time);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
