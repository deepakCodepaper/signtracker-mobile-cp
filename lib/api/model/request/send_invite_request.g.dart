// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_invite_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SendInviteRequest> _$sendInviteRequestSerializer =
    new _$SendInviteRequestSerializer();

class _$SendInviteRequestSerializer
    implements StructuredSerializer<SendInviteRequest> {
  @override
  final Iterable<Type> types = const [SendInviteRequest, _$SendInviteRequest];
  @override
  final String wireName = 'SendInviteRequest';

  @override
  Iterable<Object> serialize(Serializers serializers, SendInviteRequest object,
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
  SendInviteRequest deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SendInviteRequestBuilder();

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

class _$SendInviteRequest extends SendInviteRequest {
  @override
  final int userId;
  @override
  final int projectId;
  @override
  final String notes;

  factory _$SendInviteRequest(
          [void Function(SendInviteRequestBuilder) updates]) =>
      (new SendInviteRequestBuilder()..update(updates)).build();

  _$SendInviteRequest._({this.userId, this.projectId, this.notes}) : super._();

  @override
  SendInviteRequest rebuild(void Function(SendInviteRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SendInviteRequestBuilder toBuilder() =>
      new SendInviteRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendInviteRequest &&
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
    return (newBuiltValueToStringHelper('SendInviteRequest')
          ..add('userId', userId)
          ..add('projectId', projectId)
          ..add('notes', notes))
        .toString();
  }
}

class SendInviteRequestBuilder
    implements Builder<SendInviteRequest, SendInviteRequestBuilder> {
  _$SendInviteRequest _$v;

  int _userId;
  int get userId => _$this._userId;
  set userId(int userId) => _$this._userId = userId;

  int _projectId;
  int get projectId => _$this._projectId;
  set projectId(int projectId) => _$this._projectId = projectId;

  String _notes;
  String get notes => _$this._notes;
  set notes(String notes) => _$this._notes = notes;

  SendInviteRequestBuilder();

  SendInviteRequestBuilder get _$this {
    if (_$v != null) {
      _userId = _$v.userId;
      _projectId = _$v.projectId;
      _notes = _$v.notes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendInviteRequest other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SendInviteRequest;
  }

  @override
  void update(void Function(SendInviteRequestBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SendInviteRequest build() {
    final _$result = _$v ??
        new _$SendInviteRequest._(
            userId: userId, projectId: projectId, notes: notes);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
