// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Details> _$detailsSerializer = new _$DetailsSerializer();

class _$DetailsSerializer implements StructuredSerializer<Details> {
  @override
  final Iterable<Type> types = const [Details, _$Details];
  @override
  final String wireName = 'Details';

  @override
  Iterable<Object> serialize(Serializers serializers, Details object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.sign;
    if (value != null) {
      result
        ..add('sign')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(Sign)));
    }
    return result;
  }

  @override
  Details deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DetailsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'sign':
          result.sign.replace(serializers.deserialize(value,
              specifiedType: const FullType(Sign)) as Sign);
          break;
      }
    }

    return result.build();
  }
}

class _$Details extends Details {
  @override
  final Sign sign;

  factory _$Details([void Function(DetailsBuilder) updates]) =>
      (new DetailsBuilder()..update(updates)).build();

  _$Details._({this.sign}) : super._();

  @override
  Details rebuild(void Function(DetailsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DetailsBuilder toBuilder() => new DetailsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Details && sign == other.sign;
  }

  @override
  int get hashCode {
    return $jf($jc(0, sign.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Details')..add('sign', sign))
        .toString();
  }
}

class DetailsBuilder implements Builder<Details, DetailsBuilder> {
  _$Details _$v;

  SignBuilder _sign;
  SignBuilder get sign => _$this._sign ??= new SignBuilder();
  set sign(SignBuilder sign) => _$this._sign = sign;

  DetailsBuilder();

  DetailsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sign = $v.sign?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Details other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Details;
  }

  @override
  void update(void Function(DetailsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Details build() {
    _$Details _$result;
    try {
      _$result = _$v ?? new _$Details._(sign: _sign?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'sign';
        _sign?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Details', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
