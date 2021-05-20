// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Login> _$loginSerializer = new _$LoginSerializer();

class _$LoginSerializer implements StructuredSerializer<Login> {
  @override
  final Iterable<Type> types = const [Login, _$Login];
  @override
  final String wireName = 'Login';

  @override
  Iterable<Object> serialize(Serializers serializers, Login object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'success',
      serializers.serialize(object.success,
          specifiedType: const FullType(bool)),
      'access_token',
      serializers.serialize(object.accessToken,
          specifiedType: const FullType(String)),
      'token_type',
      serializers.serialize(object.tokenType,
          specifiedType: const FullType(String)),
      'expires_in',
      serializers.serialize(object.expiresIn,
          specifiedType: const FullType(int)),
      'user',
      serializers.serialize(object.user, specifiedType: const FullType(User)),
    ];

    return result;
  }

  @override
  Login deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LoginBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'success':
          result.success = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'access_token':
          result.accessToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'token_type':
          result.tokenType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'expires_in':
          result.expiresIn = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'user':
          result.user.replace(serializers.deserialize(value,
              specifiedType: const FullType(User)) as User);
          break;
      }
    }

    return result.build();
  }
}

class _$Login extends Login {
  @override
  final bool success;
  @override
  final String accessToken;
  @override
  final String tokenType;
  @override
  final int expiresIn;
  @override
  final User user;

  factory _$Login([void Function(LoginBuilder) updates]) =>
      (new LoginBuilder()..update(updates)).build();

  _$Login._(
      {this.success,
      this.accessToken,
      this.tokenType,
      this.expiresIn,
      this.user})
      : super._() {
    if (success == null) {
      throw new BuiltValueNullFieldError('Login', 'success');
    }
    if (accessToken == null) {
      throw new BuiltValueNullFieldError('Login', 'accessToken');
    }
    if (tokenType == null) {
      throw new BuiltValueNullFieldError('Login', 'tokenType');
    }
    if (expiresIn == null) {
      throw new BuiltValueNullFieldError('Login', 'expiresIn');
    }
    if (user == null) {
      throw new BuiltValueNullFieldError('Login', 'user');
    }
  }

  @override
  Login rebuild(void Function(LoginBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginBuilder toBuilder() => new LoginBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Login &&
        success == other.success &&
        accessToken == other.accessToken &&
        tokenType == other.tokenType &&
        expiresIn == other.expiresIn &&
        user == other.user;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, success.hashCode), accessToken.hashCode),
                tokenType.hashCode),
            expiresIn.hashCode),
        user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Login')
          ..add('success', success)
          ..add('accessToken', accessToken)
          ..add('tokenType', tokenType)
          ..add('expiresIn', expiresIn)
          ..add('user', user))
        .toString();
  }
}

class LoginBuilder implements Builder<Login, LoginBuilder> {
  _$Login _$v;

  bool _success;
  bool get success => _$this._success;
  set success(bool success) => _$this._success = success;

  String _accessToken;
  String get accessToken => _$this._accessToken;
  set accessToken(String accessToken) => _$this._accessToken = accessToken;

  String _tokenType;
  String get tokenType => _$this._tokenType;
  set tokenType(String tokenType) => _$this._tokenType = tokenType;

  int _expiresIn;
  int get expiresIn => _$this._expiresIn;
  set expiresIn(int expiresIn) => _$this._expiresIn = expiresIn;

  UserBuilder _user;
  UserBuilder get user => _$this._user ??= new UserBuilder();
  set user(UserBuilder user) => _$this._user = user;

  LoginBuilder();

  LoginBuilder get _$this {
    if (_$v != null) {
      _success = _$v.success;
      _accessToken = _$v.accessToken;
      _tokenType = _$v.tokenType;
      _expiresIn = _$v.expiresIn;
      _user = _$v.user?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Login other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Login;
  }

  @override
  void update(void Function(LoginBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Login build() {
    _$Login _$result;
    try {
      _$result = _$v ??
          new _$Login._(
              success: success,
              accessToken: accessToken,
              tokenType: tokenType,
              expiresIn: expiresIn,
              user: user.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Login', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
