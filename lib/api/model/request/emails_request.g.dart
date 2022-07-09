// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emails_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<EmailsRequest> _$emailsRequestSerializer =
    new _$EmailsRequestSerializer();

class _$EmailsRequestSerializer implements StructuredSerializer<EmailsRequest> {
  @override
  final Iterable<Type> types = const [EmailsRequest, _$EmailsRequest];
  @override
  final String wireName = 'EmailsRequest';

  @override
  Iterable<Object> serialize(Serializers serializers, EmailsRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.emails;
    if (value != null) {
      result
        ..add('emails')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    return result;
  }

  @override
  EmailsRequest deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EmailsRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'emails':
          result.emails.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$EmailsRequest extends EmailsRequest {
  @override
  final BuiltList<String> emails;

  factory _$EmailsRequest([void Function(EmailsRequestBuilder) updates]) =>
      (new EmailsRequestBuilder()..update(updates)).build();

  _$EmailsRequest._({this.emails}) : super._();

  @override
  EmailsRequest rebuild(void Function(EmailsRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EmailsRequestBuilder toBuilder() => new EmailsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EmailsRequest && emails == other.emails;
  }

  @override
  int get hashCode {
    return $jf($jc(0, emails.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('EmailsRequest')..add('emails', emails))
        .toString();
  }
}

class EmailsRequestBuilder
    implements Builder<EmailsRequest, EmailsRequestBuilder> {
  _$EmailsRequest _$v;

  ListBuilder<String> _emails;
  ListBuilder<String> get emails =>
      _$this._emails ??= new ListBuilder<String>();
  set emails(ListBuilder<String> emails) => _$this._emails = emails;

  EmailsRequestBuilder();

  EmailsRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _emails = $v.emails?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EmailsRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$EmailsRequest;
  }

  @override
  void update(void Function(EmailsRequestBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$EmailsRequest build() {
    _$EmailsRequest _$result;
    try {
      _$result = _$v ?? new _$EmailsRequest._(emails: _emails?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'emails';
        _emails?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'EmailsRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
