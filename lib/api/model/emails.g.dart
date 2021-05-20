// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emails.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Emails> _$emailsSerializer = new _$EmailsSerializer();

class _$EmailsSerializer implements StructuredSerializer<Emails> {
  @override
  final Iterable<Type> types = const [Emails, _$Emails];
  @override
  final String wireName = 'Emails';

  @override
  Iterable<Object> serialize(Serializers serializers, Emails object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'emails',
      serializers.serialize(object.emails,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  Emails deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EmailsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
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

class _$Emails extends Emails {
  @override
  final BuiltList<String> emails;

  factory _$Emails([void Function(EmailsBuilder) updates]) =>
      (new EmailsBuilder()..update(updates)).build();

  _$Emails._({this.emails}) : super._() {
    if (emails == null) {
      throw new BuiltValueNullFieldError('Emails', 'emails');
    }
  }

  @override
  Emails rebuild(void Function(EmailsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EmailsBuilder toBuilder() => new EmailsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Emails && emails == other.emails;
  }

  @override
  int get hashCode {
    return $jf($jc(0, emails.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Emails')..add('emails', emails))
        .toString();
  }
}

class EmailsBuilder implements Builder<Emails, EmailsBuilder> {
  _$Emails _$v;

  ListBuilder<String> _emails;
  ListBuilder<String> get emails =>
      _$this._emails ??= new ListBuilder<String>();
  set emails(ListBuilder<String> emails) => _$this._emails = emails;

  EmailsBuilder();

  EmailsBuilder get _$this {
    if (_$v != null) {
      _emails = _$v.emails?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Emails other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Emails;
  }

  @override
  void update(void Function(EmailsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Emails build() {
    _$Emails _$result;
    try {
      _$result = _$v ?? new _$Emails._(emails: emails.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'emails';
        emails.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Emails', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
