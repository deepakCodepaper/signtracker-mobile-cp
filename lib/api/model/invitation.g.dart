// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Invitation> _$invitationSerializer = new _$InvitationSerializer();

class _$InvitationSerializer implements StructuredSerializer<Invitation> {
  @override
  final Iterable<Type> types = const [Invitation, _$Invitation];
  @override
  final String wireName = 'Invitation';

  @override
  Iterable<Object> serialize(Serializers serializers, Invitation object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.userId;
    if (value != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.invitedById;
    if (value != null) {
      result
        ..add('invited_by_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.projectId;
    if (value != null) {
      result
        ..add('project_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.notes;
    if (value != null) {
      result
        ..add('notes')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
    value = object.companyId;
    if (value != null) {
      result
        ..add('company_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.companyName;
    if (value != null) {
      result
        ..add('company_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.projectStatus;
    if (value != null) {
      result
        ..add('project_status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.shortSummary;
    if (value != null) {
      result
        ..add('short_summary')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.username;
    if (value != null) {
      result
        ..add('user_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.managerName;
    if (value != null) {
      result
        ..add('manager_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.project;
    if (value != null) {
      result
        ..add('project')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(SignProject)));
    }
    return result;
  }

  @override
  Invitation deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvitationBuilder();

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
        case 'short_summary':
          result.shortSummary = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'user_name':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'manager_name':
          result.managerName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'project':
          result.project.replace(serializers.deserialize(value,
              specifiedType: const FullType(SignProject)) as SignProject);
          break;
      }
    }

    return result.build();
  }
}

class _$Invitation extends Invitation {
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
  final String username;
  @override
  final String managerName;
  @override
  final SignProject project;

  factory _$Invitation([void Function(InvitationBuilder) updates]) =>
      (new InvitationBuilder()..update(updates)).build();

  _$Invitation._(
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
      this.username,
      this.managerName,
      this.project})
      : super._();

  @override
  Invitation rebuild(void Function(InvitationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvitationBuilder toBuilder() => new InvitationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Invitation &&
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
        username == other.username &&
        managerName == other.managerName &&
        project == other.project;
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
                username.hashCode),
            managerName.hashCode),
        project.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Invitation')
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
          ..add('username', username)
          ..add('managerName', managerName)
          ..add('project', project))
        .toString();
  }
}

class InvitationBuilder implements Builder<Invitation, InvitationBuilder> {
  _$Invitation _$v;

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

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  String _managerName;
  String get managerName => _$this._managerName;
  set managerName(String managerName) => _$this._managerName = managerName;

  SignProjectBuilder _project;
  SignProjectBuilder get project =>
      _$this._project ??= new SignProjectBuilder();
  set project(SignProjectBuilder project) => _$this._project = project;

  InvitationBuilder();

  InvitationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _invitedById = $v.invitedById;
      _projectId = $v.projectId;
      _status = $v.status;
      _notes = $v.notes;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _companyId = $v.companyId;
      _companyName = $v.companyName;
      _projectStatus = $v.projectStatus;
      _shortSummary = $v.shortSummary;
      _username = $v.username;
      _managerName = $v.managerName;
      _project = $v.project?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Invitation other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Invitation;
  }

  @override
  void update(void Function(InvitationBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Invitation build() {
    _$Invitation _$result;
    try {
      _$result = _$v ??
          new _$Invitation._(
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
              username: username,
              managerName: managerName,
              project: _project?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'project';
        _project?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Invitation', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
