// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_project_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CloseProjectRequest> _$closeProjectRequestSerializer =
    new _$CloseProjectRequestSerializer();

class _$CloseProjectRequestSerializer
    implements StructuredSerializer<CloseProjectRequest> {
  @override
  final Iterable<Type> types = const [
    CloseProjectRequest,
    _$CloseProjectRequest
  ];
  @override
  final String wireName = 'CloseProjectRequest';

  @override
  Iterable<Object> serialize(
      Serializers serializers, CloseProjectRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.existingsSignsUncovered != null) {
      result
        ..add('existingsSignsUncovered')
        ..add(serializers.serialize(object.existingsSignsUncovered,
            specifiedType: const FullType(bool)));
    }
    if (object.signsRemoved != null) {
      result
        ..add('signsRemoved')
        ..add(serializers.serialize(object.signsRemoved,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  CloseProjectRequest deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CloseProjectRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'existingsSignsUncovered':
          result.existingsSignsUncovered = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'signsRemoved':
          result.signsRemoved = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$CloseProjectRequest extends CloseProjectRequest {
  @override
  final bool existingsSignsUncovered;
  @override
  final bool signsRemoved;

  factory _$CloseProjectRequest(
          [void Function(CloseProjectRequestBuilder) updates]) =>
      (new CloseProjectRequestBuilder()..update(updates)).build();

  _$CloseProjectRequest._({this.existingsSignsUncovered, this.signsRemoved})
      : super._();

  @override
  CloseProjectRequest rebuild(
          void Function(CloseProjectRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CloseProjectRequestBuilder toBuilder() =>
      new CloseProjectRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CloseProjectRequest &&
        existingsSignsUncovered == other.existingsSignsUncovered &&
        signsRemoved == other.signsRemoved;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc(0, existingsSignsUncovered.hashCode), signsRemoved.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CloseProjectRequest')
          ..add('existingsSignsUncovered', existingsSignsUncovered)
          ..add('signsRemoved', signsRemoved))
        .toString();
  }
}

class CloseProjectRequestBuilder
    implements Builder<CloseProjectRequest, CloseProjectRequestBuilder> {
  _$CloseProjectRequest _$v;

  bool _existingsSignsUncovered;
  bool get existingsSignsUncovered => _$this._existingsSignsUncovered;
  set existingsSignsUncovered(bool existingsSignsUncovered) =>
      _$this._existingsSignsUncovered = existingsSignsUncovered;

  bool _signsRemoved;
  bool get signsRemoved => _$this._signsRemoved;
  set signsRemoved(bool signsRemoved) => _$this._signsRemoved = signsRemoved;

  CloseProjectRequestBuilder();

  CloseProjectRequestBuilder get _$this {
    if (_$v != null) {
      _existingsSignsUncovered = _$v.existingsSignsUncovered;
      _signsRemoved = _$v.signsRemoved;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CloseProjectRequest other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CloseProjectRequest;
  }

  @override
  void update(void Function(CloseProjectRequestBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CloseProjectRequest build() {
    final _$result = _$v ??
        new _$CloseProjectRequest._(
            existingsSignsUncovered: existingsSignsUncovered,
            signsRemoved: signsRemoved);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
