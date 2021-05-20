// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_sign_project.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CheckSignProject> _$checkSignProjectSerializer =
    new _$CheckSignProjectSerializer();

class _$CheckSignProjectSerializer
    implements StructuredSerializer<CheckSignProject> {
  @override
  final Iterable<Type> types = const [CheckSignProject, _$CheckSignProject];
  @override
  final String wireName = 'CheckSignProject';

  @override
  Iterable<Object> serialize(Serializers serializers, CheckSignProject object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.projectId != null) {
      result
        ..add('project_id')
        ..add(serializers.serialize(object.projectId,
            specifiedType: const FullType(int)));
    }
    if (object.schedule != null) {
      result
        ..add('schedule')
        ..add(serializers.serialize(object.schedule,
            specifiedType: const FullType(DateTime)));
    }
    if (object.status != null) {
      result
        ..add('status')
        ..add(serializers.serialize(object.status,
            specifiedType: const FullType(String)));
    }
    if (object.project != null) {
      result
        ..add('project')
        ..add(serializers.serialize(object.project,
            specifiedType: const FullType(SignProject)));
    }
    if (object.createdAt != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(object.createdAt,
            specifiedType: const FullType(DateTime)));
    }
    if (object.updatedAt != null) {
      result
        ..add('updated_at')
        ..add(serializers.serialize(object.updatedAt,
            specifiedType: const FullType(DateTime)));
    }
    return result;
  }

  @override
  CheckSignProject deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CheckSignProjectBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'project_id':
          result.projectId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'schedule':
          result.schedule = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'project':
          result.project.replace(serializers.deserialize(value,
              specifiedType: const FullType(SignProject)) as SignProject);
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$CheckSignProject extends CheckSignProject {
  @override
  final int id;
  @override
  final int projectId;
  @override
  final DateTime schedule;
  @override
  final String status;
  @override
  final SignProject project;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$CheckSignProject(
          [void Function(CheckSignProjectBuilder) updates]) =>
      (new CheckSignProjectBuilder()..update(updates)).build();

  _$CheckSignProject._(
      {this.id,
      this.projectId,
      this.schedule,
      this.status,
      this.project,
      this.createdAt,
      this.updatedAt})
      : super._();

  @override
  CheckSignProject rebuild(void Function(CheckSignProjectBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CheckSignProjectBuilder toBuilder() =>
      new CheckSignProjectBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CheckSignProject &&
        id == other.id &&
        projectId == other.projectId &&
        schedule == other.schedule &&
        status == other.status &&
        project == other.project &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, id.hashCode), projectId.hashCode),
                        schedule.hashCode),
                    status.hashCode),
                project.hashCode),
            createdAt.hashCode),
        updatedAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CheckSignProject')
          ..add('id', id)
          ..add('projectId', projectId)
          ..add('schedule', schedule)
          ..add('status', status)
          ..add('project', project)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class CheckSignProjectBuilder
    implements Builder<CheckSignProject, CheckSignProjectBuilder> {
  _$CheckSignProject _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  int _projectId;
  int get projectId => _$this._projectId;
  set projectId(int projectId) => _$this._projectId = projectId;

  DateTime _schedule;
  DateTime get schedule => _$this._schedule;
  set schedule(DateTime schedule) => _$this._schedule = schedule;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  SignProjectBuilder _project;
  SignProjectBuilder get project =>
      _$this._project ??= new SignProjectBuilder();
  set project(SignProjectBuilder project) => _$this._project = project;

  DateTime _createdAt;
  DateTime get createdAt => _$this._createdAt;
  set createdAt(DateTime createdAt) => _$this._createdAt = createdAt;

  DateTime _updatedAt;
  DateTime get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime updatedAt) => _$this._updatedAt = updatedAt;

  CheckSignProjectBuilder();

  CheckSignProjectBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _projectId = _$v.projectId;
      _schedule = _$v.schedule;
      _status = _$v.status;
      _project = _$v.project?.toBuilder();
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CheckSignProject other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CheckSignProject;
  }

  @override
  void update(void Function(CheckSignProjectBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CheckSignProject build() {
    _$CheckSignProject _$result;
    try {
      _$result = _$v ??
          new _$CheckSignProject._(
              id: id,
              projectId: projectId,
              schedule: schedule,
              status: status,
              project: _project?.build(),
              createdAt: createdAt,
              updatedAt: updatedAt);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'project';
        _project?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CheckSignProject', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
