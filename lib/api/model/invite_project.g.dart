// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_project.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<InviteProject> _$inviteProjectSerializer =
    new _$InviteProjectSerializer();

class _$InviteProjectSerializer implements StructuredSerializer<InviteProject> {
  @override
  final Iterable<Type> types = const [InviteProject, _$InviteProject];
  @override
  final String wireName = 'InviteProject';

  @override
  Iterable<Object> serialize(Serializers serializers, InviteProject object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.userId != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(object.userId,
            specifiedType: const FullType(int)));
    }
    if (object.invitedById != null) {
      result
        ..add('invited_by_id')
        ..add(serializers.serialize(object.invitedById,
            specifiedType: const FullType(int)));
    }
    if (object.projectId != null) {
      result
        ..add('project_id')
        ..add(serializers.serialize(object.projectId,
            specifiedType: const FullType(int)));
    }
    if (object.status != null) {
      result
        ..add('status')
        ..add(serializers.serialize(object.status,
            specifiedType: const FullType(String)));
    }
    if (object.notes != null) {
      result
        ..add('notes')
        ..add(serializers.serialize(object.notes,
            specifiedType: const FullType(String)));
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
    if (object.companyId != null) {
      result
        ..add('company_id')
        ..add(serializers.serialize(object.companyId,
            specifiedType: const FullType(int)));
    }
    if (object.companyName != null) {
      result
        ..add('company_name')
        ..add(serializers.serialize(object.companyName,
            specifiedType: const FullType(String)));
    }
    if (object.projectStatus != null) {
      result
        ..add('project_status')
        ..add(serializers.serialize(object.projectStatus,
            specifiedType: const FullType(String)));
    }
    if (object.shortSummary != null) {
      result
        ..add('shorts_summary')
        ..add(serializers.serialize(object.shortSummary,
            specifiedType: const FullType(String)));
    }
    if (object.userName != null) {
      result
        ..add('user_name')
        ..add(serializers.serialize(object.userName,
            specifiedType: const FullType(String)));
    }
    if (object.managerName != null) {
      result
        ..add('manager_name')
        ..add(serializers.serialize(object.managerName,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  InviteProject deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InviteProjectBuilder();

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
        case 'user_id':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'invited_by_id':
          result.invitedById = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'project_id':
          result.projectId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'notes':
          result.notes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'company_id':
          result.companyId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'company_name':
          result.companyName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'project_status':
          result.projectStatus = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'shorts_summary':
          result.shortSummary = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'user_name':
          result.userName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'manager_name':
          result.managerName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$InviteProject extends InviteProject {
  @override
  final int id;
  @override
  final int userId;
  @override
  final int invitedById;
  @override
  final int projectId;
  @override
  final String status;
  @override
  final String notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final int companyId;
  @override
  final String companyName;
  @override
  final String projectStatus;
  @override
  final String shortSummary;
  @override
  final String userName;
  @override
  final String managerName;

  factory _$InviteProject([void Function(InviteProjectBuilder) updates]) =>
      (new InviteProjectBuilder()..update(updates)).build();

  _$InviteProject._(
      {this.id,
      this.userId,
      this.invitedById,
      this.projectId,
      this.status,
      this.notes,
      this.createdAt,
      this.updatedAt,
      this.companyId,
      this.companyName,
      this.projectStatus,
      this.shortSummary,
      this.userName,
      this.managerName})
      : super._();

  @override
  InviteProject rebuild(void Function(InviteProjectBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InviteProjectBuilder toBuilder() => new InviteProjectBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InviteProject &&
        id == other.id &&
        userId == other.userId &&
        invitedById == other.invitedById &&
        projectId == other.projectId &&
        status == other.status &&
        notes == other.notes &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        companyId == other.companyId &&
        companyName == other.companyName &&
        projectStatus == other.projectStatus &&
        shortSummary == other.shortSummary &&
        userName == other.userName &&
        managerName == other.managerName;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc($jc(0, id.hashCode),
                                                        userId.hashCode),
                                                    invitedById.hashCode),
                                                projectId.hashCode),
                                            status.hashCode),
                                        notes.hashCode),
                                    createdAt.hashCode),
                                updatedAt.hashCode),
                            companyId.hashCode),
                        companyName.hashCode),
                    projectStatus.hashCode),
                shortSummary.hashCode),
            userName.hashCode),
        managerName.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InviteProject')
          ..add('id', id)
          ..add('userId', userId)
          ..add('invitedById', invitedById)
          ..add('projectId', projectId)
          ..add('status', status)
          ..add('notes', notes)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('companyId', companyId)
          ..add('companyName', companyName)
          ..add('projectStatus', projectStatus)
          ..add('shortSummary', shortSummary)
          ..add('userName', userName)
          ..add('managerName', managerName))
        .toString();
  }
}

class InviteProjectBuilder
    implements Builder<InviteProject, InviteProjectBuilder> {
  _$InviteProject _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  int _userId;
  int get userId => _$this._userId;
  set userId(int userId) => _$this._userId = userId;

  int _invitedById;
  int get invitedById => _$this._invitedById;
  set invitedById(int invitedById) => _$this._invitedById = invitedById;

  int _projectId;
  int get projectId => _$this._projectId;
  set projectId(int projectId) => _$this._projectId = projectId;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  String _notes;
  String get notes => _$this._notes;
  set notes(String notes) => _$this._notes = notes;

  DateTime _createdAt;
  DateTime get createdAt => _$this._createdAt;
  set createdAt(DateTime createdAt) => _$this._createdAt = createdAt;

  DateTime _updatedAt;
  DateTime get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime updatedAt) => _$this._updatedAt = updatedAt;

  int _companyId;
  int get companyId => _$this._companyId;
  set companyId(int companyId) => _$this._companyId = companyId;

  String _companyName;
  String get companyName => _$this._companyName;
  set companyName(String companyName) => _$this._companyName = companyName;

  String _projectStatus;
  String get projectStatus => _$this._projectStatus;
  set projectStatus(String projectStatus) =>
      _$this._projectStatus = projectStatus;

  String _shortSummary;
  String get shortSummary => _$this._shortSummary;
  set shortSummary(String shortSummary) => _$this._shortSummary = shortSummary;

  String _userName;
  String get userName => _$this._userName;
  set userName(String userName) => _$this._userName = userName;

  String _managerName;
  String get managerName => _$this._managerName;
  set managerName(String managerName) => _$this._managerName = managerName;

  InviteProjectBuilder();

  InviteProjectBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _userId = _$v.userId;
      _invitedById = _$v.invitedById;
      _projectId = _$v.projectId;
      _status = _$v.status;
      _notes = _$v.notes;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _companyId = _$v.companyId;
      _companyName = _$v.companyName;
      _projectStatus = _$v.projectStatus;
      _shortSummary = _$v.shortSummary;
      _userName = _$v.userName;
      _managerName = _$v.managerName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InviteProject other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InviteProject;
  }

  @override
  void update(void Function(InviteProjectBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InviteProject build() {
    final _$result = _$v ??
        new _$InviteProject._(
            id: id,
            userId: userId,
            invitedById: invitedById,
            projectId: projectId,
            status: status,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            companyId: companyId,
            companyName: companyName,
            projectStatus: projectStatus,
            shortSummary: shortSummary,
            userName: userName,
            managerName: managerName);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
