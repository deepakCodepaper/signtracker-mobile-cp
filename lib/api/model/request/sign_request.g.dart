// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SignRequest> _$signRequestSerializer = new _$SignRequestSerializer();

class _$SignRequestSerializer implements StructuredSerializer<SignRequest> {
  @override
  final Iterable<Type> types = const [SignRequest, _$SignRequest];
  @override
  final String wireName = 'SignRequest';

  @override
  Iterable<Object> serialize(Serializers serializers, SignRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.method;
    if (value != null) {
      result
        ..add('_method')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.projectId;
    if (value != null) {
      result
        ..add('project_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.lat;
    if (value != null) {
      result
        ..add('lat')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.lng;
    if (value != null) {
      result
        ..add('lng')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.nameId;
    if (value != null) {
      result
        ..add('id_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.signMasterId;
    if (value != null) {
      result
        ..add('sign_master_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.traffic;
    if (value != null) {
      result
        ..add('traffic')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.notes;
    if (value != null) {
      result
        ..add('notes')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  SignRequest deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SignRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case '_method':
          result.method = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'project_id':
          result.projectId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'lat':
          result.lat = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'lng':
          result.lng = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id_name':
          result.nameId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'sign_master_id':
          result.signMasterId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'traffic':
          result.traffic = serializers.deserialize(value,
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

class _$SignRequest extends SignRequest {
  @override
  final String method;
  @override
  final String status;
  @override
  final int projectId;
  @override
  final double lat;
  @override
  final double lng;
  @override
  final String name;
  @override
  final String nameId;
  @override
  final int signMasterId;
  @override
  final int traffic;
  @override
  final String notes;

  factory _$SignRequest([void Function(SignRequestBuilder) updates]) =>
      (new SignRequestBuilder()..update(updates)).build();

  _$SignRequest._(
      {this.method,
      this.status,
      this.projectId,
      this.lat,
      this.lng,
      this.name,
      this.nameId,
      this.signMasterId,
      this.traffic,
      this.notes})
      : super._();

  @override
  SignRequest rebuild(void Function(SignRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SignRequestBuilder toBuilder() => new SignRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignRequest &&
        method == other.method &&
        status == other.status &&
        projectId == other.projectId &&
        lat == other.lat &&
        lng == other.lng &&
        name == other.name &&
        nameId == other.nameId &&
        signMasterId == other.signMasterId &&
        traffic == other.traffic &&
        notes == other.notes;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc($jc(0, method.hashCode),
                                        status.hashCode),
                                    projectId.hashCode),
                                lat.hashCode),
                            lng.hashCode),
                        name.hashCode),
                    nameId.hashCode),
                signMasterId.hashCode),
            traffic.hashCode),
        notes.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SignRequest')
          ..add('method', method)
          ..add('status', status)
          ..add('projectId', projectId)
          ..add('lat', lat)
          ..add('lng', lng)
          ..add('name', name)
          ..add('nameId', nameId)
          ..add('signMasterId', signMasterId)
          ..add('traffic', traffic)
          ..add('notes', notes))
        .toString();
  }
}

class SignRequestBuilder implements Builder<SignRequest, SignRequestBuilder> {
  _$SignRequest _$v;

  String _method;
  String get method => _$this._method;
  set method(String method) => _$this._method = method;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  int _projectId;
  int get projectId => _$this._projectId;
  set projectId(int projectId) => _$this._projectId = projectId;

  double _lat;
  double get lat => _$this._lat;
  set lat(double lat) => _$this._lat = lat;

  double _lng;
  double get lng => _$this._lng;
  set lng(double lng) => _$this._lng = lng;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _nameId;
  String get nameId => _$this._nameId;
  set nameId(String nameId) => _$this._nameId = nameId;

  int _signMasterId;
  int get signMasterId => _$this._signMasterId;
  set signMasterId(int signMasterId) => _$this._signMasterId = signMasterId;

  int _traffic;
  int get traffic => _$this._traffic;
  set traffic(int traffic) => _$this._traffic = traffic;

  String _notes;
  String get notes => _$this._notes;
  set notes(String notes) => _$this._notes = notes;

  SignRequestBuilder();

  SignRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _method = $v.method;
      _status = $v.status;
      _projectId = $v.projectId;
      _lat = $v.lat;
      _lng = $v.lng;
      _name = $v.name;
      _nameId = $v.nameId;
      _signMasterId = $v.signMasterId;
      _traffic = $v.traffic;
      _notes = $v.notes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SignRequest;
  }

  @override
  void update(void Function(SignRequestBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SignRequest build() {
    final _$result = _$v ??
        new _$SignRequest._(
            method: method,
            status: status,
            projectId: projectId,
            lat: lat,
            lng: lng,
            name: name,
            nameId: nameId,
            signMasterId: signMasterId,
            traffic: traffic,
            notes: notes);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
