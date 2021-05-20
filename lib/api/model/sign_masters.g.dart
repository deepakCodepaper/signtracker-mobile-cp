// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_masters.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SignMasters> _$signMastersSerializer = new _$SignMastersSerializer();

class _$SignMastersSerializer implements StructuredSerializer<SignMasters> {
  @override
  final Iterable<Type> types = const [SignMasters, _$SignMasters];
  @override
  final String wireName = 'SignMasters';

  @override
  Iterable<Object> serialize(Serializers serializers, SignMasters object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.idName != null) {
      result
        ..add('id_name')
        ..add(serializers.serialize(object.idName,
            specifiedType: const FullType(String)));
    }
    if (object.image != null) {
      result
        ..add('image')
        ..add(serializers.serialize(object.image,
            specifiedType: const FullType(String)));
    }
    if (object.approvedAt != null) {
      result
        ..add('approved_at')
        ..add(serializers.serialize(object.approvedAt,
            specifiedType: const FullType(DateTime)));
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
    if (object.imageUrl != null) {
      result
        ..add('image_url')
        ..add(serializers.serialize(object.imageUrl,
            specifiedType: const FullType(String)));
    }
    if (object.isApproved != null) {
      result
        ..add('is_approved')
        ..add(serializers.serialize(object.isApproved,
            specifiedType: const FullType(bool)));
    }
    if (object.isFavorite != null) {
      result
        ..add('favourite_by_users_count')
        ..add(serializers.serialize(object.isFavorite,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  SignMasters deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SignMastersBuilder();

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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id_name':
          result.idName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'image':
          result.image = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'approved_at':
          result.approvedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'image_url':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'is_approved':
          result.isApproved = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'favourite_by_users_count':
          result.isFavorite = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$SignMasters extends SignMasters {
  @override
  final int id;
  @override
  final String name;
  @override
  final String idName;
  @override
  final String image;
  @override
  final DateTime approvedAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String imageUrl;
  @override
  final bool isApproved;
  @override
  final int isFavorite;

  factory _$SignMasters([void Function(SignMastersBuilder) updates]) =>
      (new SignMastersBuilder()..update(updates)).build();

  _$SignMasters._(
      {this.id,
      this.name,
      this.idName,
      this.image,
      this.approvedAt,
      this.createdAt,
      this.updatedAt,
      this.imageUrl,
      this.isApproved,
      this.isFavorite})
      : super._();

  @override
  SignMasters rebuild(void Function(SignMastersBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SignMastersBuilder toBuilder() => new SignMastersBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignMasters &&
        id == other.id &&
        name == other.name &&
        idName == other.idName &&
        image == other.image &&
        approvedAt == other.approvedAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        imageUrl == other.imageUrl &&
        isApproved == other.isApproved &&
        isFavorite == other.isFavorite;
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
                                $jc($jc($jc(0, id.hashCode), name.hashCode),
                                    idName.hashCode),
                                image.hashCode),
                            approvedAt.hashCode),
                        createdAt.hashCode),
                    updatedAt.hashCode),
                imageUrl.hashCode),
            isApproved.hashCode),
        isFavorite.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SignMasters')
          ..add('id', id)
          ..add('name', name)
          ..add('idName', idName)
          ..add('image', image)
          ..add('approvedAt', approvedAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('imageUrl', imageUrl)
          ..add('isApproved', isApproved)
          ..add('isFavorite', isFavorite))
        .toString();
  }
}

class SignMastersBuilder implements Builder<SignMasters, SignMastersBuilder> {
  _$SignMasters _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _idName;
  String get idName => _$this._idName;
  set idName(String idName) => _$this._idName = idName;

  String _image;
  String get image => _$this._image;
  set image(String image) => _$this._image = image;

  DateTime _approvedAt;
  DateTime get approvedAt => _$this._approvedAt;
  set approvedAt(DateTime approvedAt) => _$this._approvedAt = approvedAt;

  DateTime _createdAt;
  DateTime get createdAt => _$this._createdAt;
  set createdAt(DateTime createdAt) => _$this._createdAt = createdAt;

  DateTime _updatedAt;
  DateTime get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime updatedAt) => _$this._updatedAt = updatedAt;

  String _imageUrl;
  String get imageUrl => _$this._imageUrl;
  set imageUrl(String imageUrl) => _$this._imageUrl = imageUrl;

  bool _isApproved;
  bool get isApproved => _$this._isApproved;
  set isApproved(bool isApproved) => _$this._isApproved = isApproved;

  int _isFavorite;
  int get isFavorite => _$this._isFavorite;
  set isFavorite(int isFavorite) => _$this._isFavorite = isFavorite;

  SignMastersBuilder();

  SignMastersBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _idName = _$v.idName;
      _image = _$v.image;
      _approvedAt = _$v.approvedAt;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _imageUrl = _$v.imageUrl;
      _isApproved = _$v.isApproved;
      _isFavorite = _$v.isFavorite;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignMasters other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SignMasters;
  }

  @override
  void update(void Function(SignMastersBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SignMasters build() {
    final _$result = _$v ??
        new _$SignMasters._(
            id: id,
            name: name,
            idName: idName,
            image: image,
            approvedAt: approvedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            imageUrl: imageUrl,
            isApproved: isApproved,
            isFavorite: isFavorite);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
