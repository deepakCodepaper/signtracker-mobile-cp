// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'members.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Members> _$membersSerializer = new _$MembersSerializer();

class _$MembersSerializer implements StructuredSerializer<Members> {
  @override
  final Iterable<Type> types = const [Members, _$Members];
  @override
  final String wireName = 'Members';

  @override
  Iterable<Object> serialize(Serializers serializers, Members object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.email != null) {
      result
        ..add('email')
        ..add(serializers.serialize(object.email,
            specifiedType: const FullType(String)));
    }
    if (object.isInvited != null) {
      result
        ..add('is_invited')
        ..add(serializers.serialize(object.isInvited,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  Members deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MembersBuilder();

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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'is_invited':
          result.isInvited = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$Members extends Members {
  @override
  final int id;
  @override
  final String name;
  @override
  final String email;
  @override
  final bool isInvited;

  factory _$Members([void Function(MembersBuilder) updates]) =>
      (new MembersBuilder()..update(updates)).build();

  _$Members._({this.id, this.name, this.email, this.isInvited}) : super._();

  @override
  Members rebuild(void Function(MembersBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MembersBuilder toBuilder() => new MembersBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Members &&
        id == other.id &&
        name == other.name &&
        email == other.email &&
        isInvited == other.isInvited;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc($jc(0, id.hashCode), name.hashCode), email.hashCode),
        isInvited.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Members')
          ..add('id', id)
          ..add('name', name)
          ..add('email', email)
          ..add('isInvited', isInvited))
        .toString();
  }
}

class MembersBuilder implements Builder<Members, MembersBuilder> {
  _$Members _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  bool _isInvited;
  bool get isInvited => _$this._isInvited;
  set isInvited(bool isInvited) => _$this._isInvited = isInvited;

  MembersBuilder();

  MembersBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _email = _$v.email;
      _isInvited = _$v.isInvited;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Members other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Members;
  }

  @override
  void update(void Function(MembersBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Members build() {
    final _$result = _$v ??
        new _$Members._(id: id, name: name, email: email, isInvited: isInvited);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
