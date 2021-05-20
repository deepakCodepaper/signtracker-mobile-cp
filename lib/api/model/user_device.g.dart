// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_device.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserDevice> _$userDeviceSerializer = new _$UserDeviceSerializer();

class _$UserDeviceSerializer implements StructuredSerializer<UserDevice> {
  @override
  final Iterable<Type> types = const [UserDevice, _$UserDevice];
  @override
  final String wireName = 'UserDevice';

  @override
  Iterable<Object> serialize(Serializers serializers, UserDevice object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.playerId != null) {
      result
        ..add('player_id')
        ..add(serializers.serialize(object.playerId,
            specifiedType: const FullType(String)));
    }
    if (object.userId != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(object.userId,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  UserDevice deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserDeviceBuilder();

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
        case 'player_id':
          result.playerId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'user_id':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$UserDevice extends UserDevice {
  @override
  final int id;
  @override
  final String playerId;
  @override
  final int userId;

  factory _$UserDevice([void Function(UserDeviceBuilder) updates]) =>
      (new UserDeviceBuilder()..update(updates)).build();

  _$UserDevice._({this.id, this.playerId, this.userId}) : super._();

  @override
  UserDevice rebuild(void Function(UserDeviceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserDeviceBuilder toBuilder() => new UserDeviceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserDevice &&
        id == other.id &&
        playerId == other.playerId &&
        userId == other.userId;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, id.hashCode), playerId.hashCode), userId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserDevice')
          ..add('id', id)
          ..add('playerId', playerId)
          ..add('userId', userId))
        .toString();
  }
}

class UserDeviceBuilder implements Builder<UserDevice, UserDeviceBuilder> {
  _$UserDevice _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _playerId;
  String get playerId => _$this._playerId;
  set playerId(String playerId) => _$this._playerId = playerId;

  int _userId;
  int get userId => _$this._userId;
  set userId(int userId) => _$this._userId = userId;

  UserDeviceBuilder();

  UserDeviceBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _playerId = _$v.playerId;
      _userId = _$v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserDevice other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserDevice;
  }

  @override
  void update(void Function(UserDeviceBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserDevice build() {
    final _$result =
        _$v ?? new _$UserDevice._(id: id, playerId: playerId, userId: userId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
