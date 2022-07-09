// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BaseModel<Object>> _$baseModelSerializer =
    new _$BaseModelSerializer();

class _$BaseModelSerializer implements StructuredSerializer<BaseModel<Object>> {
  @override
  final Iterable<Type> types = const [BaseModel, _$BaseModel];
  @override
  final String wireName = 'BaseModel';

  @override
  Iterable<Object> serialize(Serializers serializers, BaseModel<Object> object,
      {FullType specifiedType = FullType.unspecified}) {
    final isUnderspecified =
        specifiedType.isUnspecified || specifiedType.parameters.isEmpty;
    if (!isUnderspecified) serializers.expectBuilder(specifiedType);
    final parameterT =
        isUnderspecified ? FullType.object : specifiedType.parameters[0];

    final result = <Object>[];
    Object value;
    value = object.success;
    if (value != null) {
      result
        ..add('success')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.data;
    if (value != null) {
      result
        ..add('data')
        ..add(serializers.serialize(value, specifiedType: parameterT));
    }
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  BaseModel<Object> deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final isUnderspecified =
        specifiedType.isUnspecified || specifiedType.parameters.isEmpty;
    if (!isUnderspecified) serializers.expectBuilder(specifiedType);
    final parameterT =
        isUnderspecified ? FullType.object : specifiedType.parameters[0];

    final result = isUnderspecified
        ? new BaseModelBuilder<Object>()
        : serializers.newBuilder(specifiedType) as BaseModelBuilder<Object>;

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'success':
          result.success = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'data':
          result.data =
              serializers.deserialize(value, specifiedType: parameterT);
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$BaseModel<T> extends BaseModel<T> {
  @override
  final bool success;
  @override
  final T data;
  @override
  final String message;

  factory _$BaseModel([void Function(BaseModelBuilder<T>) updates]) =>
      (new BaseModelBuilder<T>()..update(updates)).build();

  _$BaseModel._({this.success, this.data, this.message}) : super._() {
    if (T == dynamic) {
      throw new BuiltValueMissingGenericsError('BaseModel', 'T');
    }
  }

  @override
  BaseModel<T> rebuild(void Function(BaseModelBuilder<T>) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BaseModelBuilder<T> toBuilder() => new BaseModelBuilder<T>()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseModel &&
        success == other.success &&
        data == other.data &&
        message == other.message;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, success.hashCode), data.hashCode), message.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BaseModel')
          ..add('success', success)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseModelBuilder<T>
    implements Builder<BaseModel<T>, BaseModelBuilder<T>> {
  _$BaseModel<T> _$v;

  bool _success;
  bool get success => _$this._success;
  set success(bool success) => _$this._success = success;

  T _data;
  T get data => _$this._data;
  set data(T data) => _$this._data = data;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  BaseModelBuilder();

  BaseModelBuilder<T> get _$this {
    final $v = _$v;
    if ($v != null) {
      _success = $v.success;
      _data = $v.data;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BaseModel<T> other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BaseModel<T>;
  }

  @override
  void update(void Function(BaseModelBuilder<T>) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BaseModel<T> build() {
    final _$result = _$v ??
        new _$BaseModel<T>._(success: success, data: data, message: message);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
