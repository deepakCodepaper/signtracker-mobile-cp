// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Invite> _$inviteSerializer = new _$InviteSerializer();

class _$InviteSerializer implements StructuredSerializer<Invite> {
  @override
  final Iterable<Type> types = const [Invite, _$Invite];
  @override
  final String wireName = 'Invite';

  @override
  Iterable<Object> serialize(Serializers serializers, Invite object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.userId != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(object.userId,
            specifiedType: const FullType(int)));
    }
    if (object.projectId != null) {
      result
        ..add('project_id')
        ..add(serializers.serialize(object.projectId,
            specifiedType: const FullType(int)));
    }
    if (object.notes != null) {
      result
        ..add('notes')
        ..add(serializers.serialize(object.notes,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Invite deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InviteBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'user_id':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'project_id':
          result.projectId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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

class _$Invite extends Invite {
  @override
  final int userId;
  @override
  final int projectId;
  @override
  final String notes;

  factory _$Invite([void Function(InviteBuilder) updates]) =>
      (new InviteBuilder()..update(updates)).build();

  _$Invite._({this.userId, this.projectId, this.notes}) : super._();

  @override
  Invite rebuild(void Function(InviteBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InviteBuilder toBuilder() => new InviteBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Invite &&
        userId == other.userId &&
        projectId == other.projectId &&
        notes == other.notes;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, userId.hashCode), projectId.hashCode), notes.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Invite')
          ..add('userId', userId)
          ..add('projectId', projectId)
          ..add('notes', notes))
        .toString();
  }
}

class InviteBuilder implements Builder<Invite, InviteBuilder> {
  _$Invite _$v;

  int _userId;
  int get userId => _$this._userId;
  set userId(int userId) => _$this._userId = userId;

  int _projectId;
  int get projectId => _$this._projectId;
  set projectId(int projectId) => _$this._projectId = projectId;

  String _notes;
  String get notes => _$this._notes;
  set notes(String notes) => _$this._notes = notes;

  InviteBuilder();

  InviteBuilder get _$this {
    if (_$v != null) {
      _userId = _$v.userId;
      _projectId = _$v.projectId;
      _notes = _$v.notes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Invite other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Invite;
  }

  @override
  void update(void Function(InviteBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Invite build() {
    final _$result = _$v ??
        new _$Invite._(userId: userId, projectId: projectId, notes: notes);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
