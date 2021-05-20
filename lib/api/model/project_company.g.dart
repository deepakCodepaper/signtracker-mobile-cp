// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_company.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProjectCompany> _$projectCompanySerializer =
    new _$ProjectCompanySerializer();

class _$ProjectCompanySerializer
    implements StructuredSerializer<ProjectCompany> {
  @override
  final Iterable<Type> types = const [ProjectCompany, _$ProjectCompany];
  @override
  final String wireName = 'ProjectCompany';

  @override
  Iterable<Object> serialize(Serializers serializers, ProjectCompany object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.managerId != null) {
      result
        ..add('manager_id')
        ..add(serializers.serialize(object.managerId,
            specifiedType: const FullType(int)));
    }
    if (object.logo != null) {
      result
        ..add('logo')
        ..add(serializers.serialize(object.logo,
            specifiedType: const FullType(String)));
    }
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.email != null) {
      result
        ..add('email')
        ..add(serializers.serialize(object.email,
            specifiedType: const FullType(String)));
    }
    if (object.subStart != null) {
      result
        ..add('sub_start')
        ..add(serializers.serialize(object.subStart,
            specifiedType: const FullType(DateTime)));
    }
    if (object.subEnd != null) {
      result
        ..add('sub_end')
        ..add(serializers.serialize(object.subEnd,
            specifiedType: const FullType(DateTime)));
    }
    if (object.paymentFee != null) {
      result
        ..add('payment_fee')
        ..add(serializers.serialize(object.paymentFee,
            specifiedType: const FullType(double)));
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
    return result;
  }

  @override
  ProjectCompany deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProjectCompanyBuilder();

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
        case 'manager_id':
          result.managerId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'logo':
          result.logo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'sub_start':
          result.subStart = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'sub_end':
          result.subEnd = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'payment_fee':
          result.paymentFee = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$ProjectCompany extends ProjectCompany {
  @override
  final int id;
  @override
  final int managerId;
  @override
  final String logo;
  @override
  final String name;
  @override
  final String email;
  @override
  final DateTime subStart;
  @override
  final DateTime subEnd;
  @override
  final double paymentFee;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$ProjectCompany([void Function(ProjectCompanyBuilder) updates]) =>
      (new ProjectCompanyBuilder()..update(updates)).build();

  _$ProjectCompany._(
      {this.id,
      this.managerId,
      this.logo,
      this.name,
      this.email,
      this.subStart,
      this.subEnd,
      this.paymentFee,
      this.createdAt,
      this.updatedAt})
      : super._();

  @override
  ProjectCompany rebuild(void Function(ProjectCompanyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectCompanyBuilder toBuilder() =>
      new ProjectCompanyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProjectCompany &&
        id == other.id &&
        managerId == other.managerId &&
        logo == other.logo &&
        name == other.name &&
        email == other.email &&
        subStart == other.subStart &&
        subEnd == other.subEnd &&
        paymentFee == other.paymentFee &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
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
                                        managerId.hashCode),
                                    logo.hashCode),
                                name.hashCode),
                            email.hashCode),
                        subStart.hashCode),
                    subEnd.hashCode),
                paymentFee.hashCode),
            createdAt.hashCode),
        updatedAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProjectCompany')
          ..add('id', id)
          ..add('managerId', managerId)
          ..add('logo', logo)
          ..add('name', name)
          ..add('email', email)
          ..add('subStart', subStart)
          ..add('subEnd', subEnd)
          ..add('paymentFee', paymentFee)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class ProjectCompanyBuilder
    implements Builder<ProjectCompany, ProjectCompanyBuilder> {
  _$ProjectCompany _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  int _managerId;
  int get managerId => _$this._managerId;
  set managerId(int managerId) => _$this._managerId = managerId;

  String _logo;
  String get logo => _$this._logo;
  set logo(String logo) => _$this._logo = logo;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  DateTime _subStart;
  DateTime get subStart => _$this._subStart;
  set subStart(DateTime subStart) => _$this._subStart = subStart;

  DateTime _subEnd;
  DateTime get subEnd => _$this._subEnd;
  set subEnd(DateTime subEnd) => _$this._subEnd = subEnd;

  double _paymentFee;
  double get paymentFee => _$this._paymentFee;
  set paymentFee(double paymentFee) => _$this._paymentFee = paymentFee;

  DateTime _createdAt;
  DateTime get createdAt => _$this._createdAt;
  set createdAt(DateTime createdAt) => _$this._createdAt = createdAt;

  DateTime _updatedAt;
  DateTime get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime updatedAt) => _$this._updatedAt = updatedAt;

  ProjectCompanyBuilder();

  ProjectCompanyBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _managerId = _$v.managerId;
      _logo = _$v.logo;
      _name = _$v.name;
      _email = _$v.email;
      _subStart = _$v.subStart;
      _subEnd = _$v.subEnd;
      _paymentFee = _$v.paymentFee;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectCompany other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProjectCompany;
  }

  @override
  void update(void Function(ProjectCompanyBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProjectCompany build() {
    final _$result = _$v ??
        new _$ProjectCompany._(
            id: id,
            managerId: managerId,
            logo: logo,
            name: name,
            email: email,
            subStart: subStart,
            subEnd: subEnd,
            paymentFee: paymentFee,
            createdAt: createdAt,
            updatedAt: updatedAt);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
