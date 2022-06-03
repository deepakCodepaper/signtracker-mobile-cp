// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Sign> _$signSerializer = new _$SignSerializer();

class _$SignSerializer implements StructuredSerializer<Sign> {
  @override
  final Iterable<Type> types = const [Sign, _$Sign];
  @override
  final String wireName = 'Sign';

  @override
  Iterable<Object> serialize(Serializers serializers, Sign object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
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
    if (object.idName != null) {
      result
        ..add('id_name')
        ..add(serializers.serialize(object.idName,
            specifiedType: const FullType(String)));
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
    if (object.traffic != null) {
      result
        ..add('traffic')
        ..add(serializers.serialize(object.traffic,
            specifiedType: const FullType(int)));
    }
    if (object.image != null) {
      result
        ..add('image')
        ..add(serializers.serialize(object.image,
            specifiedType: const FullType(String)));
    }
    if (object.createdAt != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(object.createdAt,
            specifiedType: const FullType(DateTime)));
    }
    if (object.updatedAt != null) {
      result
        ..add('updated_at')
        ..add(serializers.serialize(object.updatedAt,
            specifiedType: const FullType(DateTime)));
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
    if (object.isChecked != null) {
      result
        ..add('isChecked')
        ..add(serializers.serialize(object.isChecked,
            specifiedType: const FullType(bool)));
    }

    if (object.notes != null) {
      result
        ..add('isChecked')
        ..add(serializers.serialize(object.notes,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Sign deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SignBuilder();

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
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'project_id':
          result.projectId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'id_name':
          result.idName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
        case 'traffic':
          result.traffic = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'image':
          result.image = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'id_name':
          result.nameId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'sign_master_id':
          result.signMasterId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'isChecked':
          result.isChecked = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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

class _$Sign extends Sign {
  @override
  final int id;
  @override
  final String status;
  @override
  final int projectId;
  @override
  final String idName;
  @override
  final double lat;
  @override
  final double lng;
  @override
  final String name;
  @override
  final int traffic;
  @override
  final String image;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String nameId;
  @override
  final int signMasterId;
  @override
  final bool isChecked;
  @override
  final String notes;

  factory _$Sign([void Function(SignBuilder) updates]) =>
      (new SignBuilder()..update(updates)).build();

  _$Sign._(
      {this.id,
      this.status,
      this.projectId,
      this.idName,
      this.lat,
      this.lng,
      this.name,
      this.traffic,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.nameId,
      this.signMasterId,
      this.isChecked,
      this.notes})
      : super._();

  @override
  Sign rebuild(void Function(SignBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SignBuilder toBuilder() => new SignBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Sign &&
        id == other.id &&
        status == other.status &&
        projectId == other.projectId &&
        idName == other.idName &&
        lat == other.lat &&
        lng == other.lng &&
        name == other.name &&
        traffic == other.traffic &&
        image == other.image &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        nameId == other.nameId &&
        signMasterId == other.signMasterId &&
        isChecked == other.isChecked &&
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
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc($jc(0, id.hashCode),
                                                        status.hashCode),
                                                    projectId.hashCode),
                                                idName.hashCode),
                                            lat.hashCode),
                                        lng.hashCode),
                                    name.hashCode),
                                traffic.hashCode),
                            image.hashCode),
                        createdAt.hashCode),
                    updatedAt.hashCode),
                nameId.hashCode),
            signMasterId.hashCode),
        isChecked.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Sign')
          ..add('id', id)
          ..add('status', status)
          ..add('projectId', projectId)
          ..add('idName', idName)
          ..add('lat', lat)
          ..add('lng', lng)
          ..add('name', name)
          ..add('traffic', traffic)
          ..add('image', image)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('nameId', nameId)
          ..add('signMasterId', signMasterId)
          ..add('isChecked', isChecked)
          ..add('notes', notes))
        .toString();
  }
}

class SignBuilder implements Builder<Sign, SignBuilder> {
  _$Sign _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  int _projectId;
  int get projectId => _$this._projectId;
  set projectId(int projectId) => _$this._projectId = projectId;

  String _idName;
  String get idName => _$this._idName;
  set idName(String idName) => _$this._idName = idName;

  double _lat;
  double get lat => _$this._lat;
  set lat(double lat) => _$this._lat = lat;

  double _lng;
  double get lng => _$this._lng;
  set lng(double lng) => _$this._lng = lng;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  int _traffic;
  int get traffic => _$this._traffic;
  set traffic(int traffic) => _$this._traffic = traffic;

  String _image;
  String get image => _$this._image;
  set image(String image) => _$this._image = image;

  DateTime _createdAt;
  DateTime get createdAt => _$this._createdAt;
  set createdAt(DateTime createdAt) => _$this._createdAt = createdAt;

  DateTime _updatedAt;
  DateTime get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime updatedAt) => _$this._updatedAt = updatedAt;

  String _nameId;
  String get nameId => _$this._nameId;
  set nameId(String nameId) => _$this._nameId = nameId;

  int _signMasterId;
  int get signMasterId => _$this._signMasterId;
  set signMasterId(int signMasterId) => _$this._signMasterId = signMasterId;

  bool _isChecked;
  bool get isChecked => _$this._isChecked;
  set isChecked(bool isChecked) => _$this._isChecked = isChecked;

  String _notes;
  String get notes => _$this._notes;
  set notes(String notes) => _$this._notes = notes;

  SignBuilder();

  SignBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _status = _$v.status;
      _projectId = _$v.projectId;
      _idName = _$v.idName;
      _lat = _$v.lat;
      _lng = _$v.lng;
      _name = _$v.name;
      _traffic = _$v.traffic;
      _image = _$v.image;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _nameId = _$v.nameId;
      _signMasterId = _$v.signMasterId;
      _isChecked = _$v.isChecked;
      _notes = _$v.notes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Sign other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Sign;
  }

  @override
  void update(void Function(SignBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Sign build() {
    final _$result = _$v ??
        new _$Sign._(
            id: id,
            status: status,
            projectId: projectId,
            idName: idName,
            lat: lat,
            lng: lng,
            name: name,
            traffic: traffic,
            image: image,
            createdAt: createdAt,
            updatedAt: updatedAt,
            nameId: nameId,
            signMasterId: signMasterId,
            isChecked: isChecked,
            notes: notes);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
