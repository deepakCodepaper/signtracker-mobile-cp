// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Template> _$templateSerializer = new _$TemplateSerializer();

class _$TemplateSerializer implements StructuredSerializer<Template> {
  @override
  final Iterable<Type> types = const [Template, _$Template];
  @override
  final String wireName = 'Template';

  @override
  Iterable<Object> serialize(Serializers serializers, Template object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.companyId;
    if (value != null) {
      result
        ..add('company_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.drawingNumber;
    if (value != null) {
      result
        ..add('drawing_number')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.imageUrl;
    if (value != null) {
      result
        ..add('image_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.createdAt;
    if (value != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.updatedAt;
    if (value != null) {
      result
        ..add('updated_at')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.sortIndex;
    if (value != null) {
      result
        ..add('sort_index')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.rowNumber;
    if (value != null) {
      result
        ..add('row_number')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.template;
    if (value != null) {
      result
        ..add('template')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Template)));
    }
    return result;
  }

  @override
  Template deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TemplateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'company_id':
          result.companyId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'drawing_number':
          result.drawingNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'image_url':
          result.imageUrl = serializers.deserialize(value,
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
        case 'sort_index':
          result.sortIndex = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'row_number':
          result.rowNumber = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'template':
          result.template.replace(serializers.deserialize(value,
              specifiedType: const FullType(Template)) as Template);
          break;
      }
    }

    return result.build();
  }
}

class _$Template extends Template {
  @override
  final int id;
  @override
  final int companyId;
  @override
  final String drawingNumber;
  @override
  final String name;
  @override
  final String imageUrl;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final int sortIndex;
  @override
  final int rowNumber;
  @override
  final Template template;

  factory _$Template([void Function(TemplateBuilder) updates]) =>
      (new TemplateBuilder()..update(updates)).build();

  _$Template._(
      {this.id,
      this.companyId,
      this.drawingNumber,
      this.name,
      this.imageUrl,
      this.createdAt,
      this.updatedAt,
      this.sortIndex,
      this.rowNumber,
      this.template})
      : super._();

  @override
  Template rebuild(void Function(TemplateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TemplateBuilder toBuilder() => new TemplateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Template &&
        id == other.id &&
        companyId == other.companyId &&
        drawingNumber == other.drawingNumber &&
        name == other.name &&
        imageUrl == other.imageUrl &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        sortIndex == other.sortIndex &&
        rowNumber == other.rowNumber &&
        template == other.template;
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
                                    $jc($jc(0, id.hashCode),
                                        companyId.hashCode),
                                    drawingNumber.hashCode),
                                name.hashCode),
                            imageUrl.hashCode),
                        createdAt.hashCode),
                    updatedAt.hashCode),
                sortIndex.hashCode),
            rowNumber.hashCode),
        template.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Template')
          ..add('id', id)
          ..add('companyId', companyId)
          ..add('drawingNumber', drawingNumber)
          ..add('name', name)
          ..add('imageUrl', imageUrl)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('sortIndex', sortIndex)
          ..add('rowNumber', rowNumber)
          ..add('template', template))
        .toString();
  }
}

class TemplateBuilder implements Builder<Template, TemplateBuilder> {
  _$Template _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  int _companyId;
  int get companyId => _$this._companyId;
  set companyId(int companyId) => _$this._companyId = companyId;

  String _drawingNumber;
  String get drawingNumber => _$this._drawingNumber;
  set drawingNumber(String drawingNumber) =>
      _$this._drawingNumber = drawingNumber;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _imageUrl;
  String get imageUrl => _$this._imageUrl;
  set imageUrl(String imageUrl) => _$this._imageUrl = imageUrl;

  DateTime _createdAt;
  DateTime get createdAt => _$this._createdAt;
  set createdAt(DateTime createdAt) => _$this._createdAt = createdAt;

  DateTime _updatedAt;
  DateTime get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime updatedAt) => _$this._updatedAt = updatedAt;

  int _sortIndex;
  int get sortIndex => _$this._sortIndex;
  set sortIndex(int sortIndex) => _$this._sortIndex = sortIndex;

  int _rowNumber;
  int get rowNumber => _$this._rowNumber;
  set rowNumber(int rowNumber) => _$this._rowNumber = rowNumber;

  TemplateBuilder _template;
  TemplateBuilder get template => _$this._template ??= new TemplateBuilder();
  set template(TemplateBuilder template) => _$this._template = template;

  TemplateBuilder();

  TemplateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _companyId = $v.companyId;
      _drawingNumber = $v.drawingNumber;
      _name = $v.name;
      _imageUrl = $v.imageUrl;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _sortIndex = $v.sortIndex;
      _rowNumber = $v.rowNumber;
      _template = $v.template?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Template other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Template;
  }

  @override
  void update(void Function(TemplateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Template build() {
    _$Template _$result;
    try {
      _$result = _$v ??
          new _$Template._(
              id: id,
              companyId: companyId,
              drawingNumber: drawingNumber,
              name: name,
              imageUrl: imageUrl,
              createdAt: createdAt,
              updatedAt: updatedAt,
              sortIndex: sortIndex,
              rowNumber: rowNumber,
              template: _template?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'template';
        _template?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Template', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
