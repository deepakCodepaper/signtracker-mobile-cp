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
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.companyId != null) {
      result
        ..add('company_id')
        ..add(serializers.serialize(object.companyId,
            specifiedType: const FullType(int)));
    }
    if (object.drawingNumber != null) {
      result
        ..add('drawing_number')
        ..add(serializers.serialize(object.drawingNumber,
            specifiedType: const FullType(String)));
    }
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
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
    if (object.sortIndex != null) {
      result
        ..add('sort_index')
        ..add(serializers.serialize(object.sortIndex,
            specifiedType: const FullType(int)));
    }
    if (object.rowNumber != null) {
      result
        ..add('row_number')
        ..add(serializers.serialize(object.rowNumber,
            specifiedType: const FullType(int)));
    }
    if (object.template != null) {
      result
        ..add('template')
        ..add(serializers.serialize(object.template,
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
      final dynamic value = iterator.current;
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
                            $jc($jc($jc(0, id.hashCode), companyId.hashCode),
                                drawingNumber.hashCode),
                            name.hashCode),
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
    if (_$v != null) {
      _id = _$v.id;
      _companyId = _$v.companyId;
      _drawingNumber = _$v.drawingNumber;
      _name = _$v.name;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _sortIndex = _$v.sortIndex;
      _rowNumber = _$v.rowNumber;
      _template = _$v.template?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Template other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
