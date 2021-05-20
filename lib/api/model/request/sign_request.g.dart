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
    if (object.method != null) {
      result
        ..add('_method')
        ..add(serializers.serialize(object.method,
            specifiedType: const FullType(String)));
    }
    if (object.status != null) {
      result
        ..add('status')
        ..add(serializers.serialize(object.status,
            specifiedType: const FullType(String)));
    }
    if (object.projectId != null) {
      result
        ..add('project_id')
        ..add(serializers.serialize(object.projectId,
            specifiedType: const FullType(int)));
    }
    if (object.lat != null) {
      result
        ..add('lat')
        ..add(serializers.serialize(object.lat,
            specifiedType: const FullType(double)));
    }
    if (object.lng != null) {
      result
        ..add('lng')
        ..add(serializers.serialize(object.lng,
            specifiedType: const FullType(double)));
    }
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.nameId != null) {
      result
        ..add('id_name')
        ..add(serializers.serialize(object.nameId,
            specifiedType: const FullType(String)));
    }
    if (object.signMasterId != null) {
      result
        ..add('sign_master_id')
        ..add(serializers.serialize(object.signMasterId,
            specifiedType: const FullType(int)));
    }
    if (object.traffic != null) {
      result
        ..add('traffic')
        ..add(serializers.serialize(object.traffic,
            specifiedType: const FullType(int)));
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
      final dynamic value = iterator.current;
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
      this.traffic})
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
        traffic == other.traffic;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, method.hashCode), status.hashCode),
                                projectId.hashCode),
                            lat.hashCode),
                        lng.hashCode),
                    name.hashCode),
                nameId.hashCode),
            signMasterId.hashCode),
        traffic.hashCode));
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
          ..add('traffic', traffic))
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

  SignRequestBuilder();

  SignRequestBuilder get _$this {
    if (_$v != null) {
      _method = _$v.method;
      _status = _$v.status;
      _projectId = _$v.projectId;
      _lat = _$v.lat;
      _lng = _$v.lng;
      _name = _$v.name;
      _nameId = _$v.nameId;
      _signMasterId = _$v.signMasterId;
      _traffic = _$v.traffic;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignRequest other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
            traffic: traffic);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
