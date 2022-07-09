// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_logs.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProjectLogs> _$projectLogsSerializer = new _$ProjectLogsSerializer();

class _$ProjectLogsSerializer implements StructuredSerializer<ProjectLogs> {
  @override
  final Iterable<Type> types = const [ProjectLogs, _$ProjectLogs];
  @override
  final String wireName = 'ProjectLogs';

  @override
  Iterable<Object> serialize(Serializers serializers, ProjectLogs object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.projectId;
    if (value != null) {
      result
        ..add('project_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.createdAt;
    if (value != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.updatedAt;
    if (value != null) {
      result
        ..add('updated_at')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.updatedBy;
    if (value != null) {
      result
        ..add('updated_by')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(User)));
    }
    value = object.details;
    if (value != null) {
      result
        ..add('details')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Details)));
    }
    value = object.notes;
    if (value != null) {
      result
        ..add('notes')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ProjectLogs deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProjectLogsBuilder();

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
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'project_id':
          result.projectId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'updated_by':
          result.updatedBy.replace(serializers.deserialize(value,
              specifiedType: const FullType(User)) as User);
          break;
        case 'details':
          result.details.replace(serializers.deserialize(value,
              specifiedType: const FullType(Details)) as Details);
          break;
        case 'notes':
          result.notes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ProjectLogs extends ProjectLogs {
  @override
  final int id;
  @override
  final String message;
  @override
  final int projectId;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final User updatedBy;
  @override
  final Details details;
  @override
  final String notes;

  factory _$ProjectLogs([void Function(ProjectLogsBuilder) updates]) =>
      (new ProjectLogsBuilder()..update(updates)).build();

  _$ProjectLogs._(
      {this.id,
      this.message,
      this.projectId,
      this.createdAt,
      this.updatedAt,
      this.updatedBy,
      this.details,
      this.notes})
      : super._();

  @override
  ProjectLogs rebuild(void Function(ProjectLogsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectLogsBuilder toBuilder() => new ProjectLogsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProjectLogs &&
        id == other.id &&
        message == other.message &&
        projectId == other.projectId &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        updatedBy == other.updatedBy &&
        details == other.details &&
        notes == other.notes;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, id.hashCode), message.hashCode),
                            projectId.hashCode),
                        createdAt.hashCode),
                    updatedAt.hashCode),
                updatedBy.hashCode),
            details.hashCode),
        notes.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProjectLogs')
          ..add('id', id)
          ..add('message', message)
          ..add('projectId', projectId)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('updatedBy', updatedBy)
          ..add('details', details)
          ..add('notes', notes))
        .toString();
  }
}

class ProjectLogsBuilder implements Builder<ProjectLogs, ProjectLogsBuilder> {
  _$ProjectLogs _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  int _projectId;
  int get projectId => _$this._projectId;
  set projectId(int projectId) => _$this._projectId = projectId;

  DateTime _createdAt;
  DateTime get createdAt => _$this._createdAt;
  set createdAt(DateTime createdAt) => _$this._createdAt = createdAt;

  DateTime _updatedAt;
  DateTime get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime updatedAt) => _$this._updatedAt = updatedAt;

  UserBuilder _updatedBy;
  UserBuilder get updatedBy => _$this._updatedBy ??= new UserBuilder();
  set updatedBy(UserBuilder updatedBy) => _$this._updatedBy = updatedBy;

  DetailsBuilder _details;
  DetailsBuilder get details => _$this._details ??= new DetailsBuilder();
  set details(DetailsBuilder details) => _$this._details = details;

  String _notes;
  String get notes => _$this._notes;
  set notes(String notes) => _$this._notes = notes;

  ProjectLogsBuilder();

  ProjectLogsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _message = $v.message;
      _projectId = $v.projectId;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _updatedBy = $v.updatedBy?.toBuilder();
      _details = $v.details?.toBuilder();
      _notes = $v.notes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectLogs other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProjectLogs;
  }

  @override
  void update(void Function(ProjectLogsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProjectLogs build() {
    _$ProjectLogs _$result;
    try {
      _$result = _$v ??
          new _$ProjectLogs._(
              id: id,
              message: message,
              projectId: projectId,
              createdAt: createdAt,
              updatedAt: updatedAt,
              updatedBy: _updatedBy?.build(),
              details: _details?.build(),
              notes: notes);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'updatedBy';
        _updatedBy?.build();
        _$failedField = 'details';
        _details?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ProjectLogs', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
