// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_invite_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CompanyInviteRequest> _$companyInviteRequestSerializer =
    new _$CompanyInviteRequestSerializer();

class _$CompanyInviteRequestSerializer
    implements StructuredSerializer<CompanyInviteRequest> {
  @override
  final Iterable<Type> types = const [
    CompanyInviteRequest,
    _$CompanyInviteRequest
  ];
  @override
  final String wireName = 'CompanyInviteRequest';

  @override
  Iterable<Object> serialize(
      Serializers serializers, CompanyInviteRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.companies != null) {
      result
        ..add('company_ids')
        ..add(serializers.serialize(object.companies,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    return result;
  }

  @override
  CompanyInviteRequest deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CompanyInviteRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'company_ids':
          result.companies.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$CompanyInviteRequest extends CompanyInviteRequest {
  @override
  final BuiltList<int> companies;

  factory _$CompanyInviteRequest(
          [void Function(CompanyInviteRequestBuilder) updates]) =>
      (new CompanyInviteRequestBuilder()..update(updates)).build();

  _$CompanyInviteRequest._({this.companies}) : super._();

  @override
  CompanyInviteRequest rebuild(
          void Function(CompanyInviteRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CompanyInviteRequestBuilder toBuilder() =>
      new CompanyInviteRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CompanyInviteRequest && companies == other.companies;
  }

  @override
  int get hashCode {
    return $jf($jc(0, companies.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CompanyInviteRequest')
          ..add('companies', companies))
        .toString();
  }
}

class CompanyInviteRequestBuilder
    implements Builder<CompanyInviteRequest, CompanyInviteRequestBuilder> {
  _$CompanyInviteRequest _$v;

  ListBuilder<int> _companies;
  ListBuilder<int> get companies =>
      _$this._companies ??= new ListBuilder<int>();
  set companies(ListBuilder<int> companies) => _$this._companies = companies;

  CompanyInviteRequestBuilder();

  CompanyInviteRequestBuilder get _$this {
    if (_$v != null) {
      _companies = _$v.companies?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompanyInviteRequest other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CompanyInviteRequest;
  }

  @override
  void update(void Function(CompanyInviteRequestBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CompanyInviteRequest build() {
    _$CompanyInviteRequest _$result;
    try {
      _$result =
          _$v ?? new _$CompanyInviteRequest._(companies: _companies?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'companies';
        _companies?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CompanyInviteRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
