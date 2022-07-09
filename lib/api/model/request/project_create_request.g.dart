// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProjectCreateRequest> _$projectCreateRequestSerializer =
    new _$ProjectCreateRequestSerializer();

class _$ProjectCreateRequestSerializer
    implements StructuredSerializer<ProjectCreateRequest> {
  @override
  final Iterable<Type> types = const [
    ProjectCreateRequest,
    _$ProjectCreateRequest
  ];
  @override
  final String wireName = 'ProjectCreateRequest';

  @override
  Iterable<Object> serialize(
      Serializers serializers, ProjectCreateRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.parent;
    if (value != null) {
      result
        ..add('parent')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.identifier;
    if (value != null) {
      result
        ..add('identifier')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.templateId;
    if (value != null) {
      result
        ..add('template_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.commissionedBy;
    if (value != null) {
      result
        ..add('commissioned_by')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.plan;
    if (value != null) {
      result
        ..add('plan')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.type;
    if (value != null) {
      result
        ..add('type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.highway;
    if (value != null) {
      result
        ..add('highway')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.intersection;
    if (value != null) {
      result
        ..add('intersection')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.speed;
    if (value != null) {
      result
        ..add('speed')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.distance;
    if (value != null) {
      result
        ..add('distance')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.startDate;
    if (value != null) {
      result
        ..add('start_date')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.endDate;
    if (value != null) {
      result
        ..add('end_date')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.notifyFrequency;
    if (value != null) {
      result
        ..add('notify_frequency')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.inactiveNotifyFrequency;
    if (value != null) {
      result
        ..add('inactive_notify_frequency')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  ProjectCreateRequest deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProjectCreateRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'parent':
          result.parent = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'identifier':
          result.identifier = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'template_id':
          result.templateId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'commissioned_by':
          result.commissionedBy = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'plan':
          result.plan = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'highway':
          result.highway = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'intersection':
          result.intersection = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'speed':
          result.speed = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'distance':
          result.distance = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'start_date':
          result.startDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'end_date':
          result.endDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'notify_frequency':
          result.notifyFrequency = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'inactive_notify_frequency':
          result.inactiveNotifyFrequency = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$ProjectCreateRequest extends ProjectCreateRequest {
  @override
  final int parent;
  @override
  final String identifier;
  @override
  final int templateId;
  @override
  final String commissionedBy;
  @override
  final String description;
  @override
  final String plan;
  @override
  final String type;
  @override
  final String highway;
  @override
  final String intersection;
  @override
  final double speed;
  @override
  final double distance;
  @override
  final String startDate;
  @override
  final String endDate;
  @override
  final int notifyFrequency;
  @override
  final int inactiveNotifyFrequency;

  factory _$ProjectCreateRequest(
          [void Function(ProjectCreateRequestBuilder) updates]) =>
      (new ProjectCreateRequestBuilder()..update(updates)).build();

  _$ProjectCreateRequest._(
      {this.parent,
      this.identifier,
      this.templateId,
      this.commissionedBy,
      this.description,
      this.plan,
      this.type,
      this.highway,
      this.intersection,
      this.speed,
      this.distance,
      this.startDate,
      this.endDate,
      this.notifyFrequency,
      this.inactiveNotifyFrequency})
      : super._();

  @override
  ProjectCreateRequest rebuild(
          void Function(ProjectCreateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectCreateRequestBuilder toBuilder() =>
      new ProjectCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProjectCreateRequest &&
        parent == other.parent &&
        identifier == other.identifier &&
        templateId == other.templateId &&
        commissionedBy == other.commissionedBy &&
        description == other.description &&
        plan == other.plan &&
        type == other.type &&
        highway == other.highway &&
        intersection == other.intersection &&
        speed == other.speed &&
        distance == other.distance &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        notifyFrequency == other.notifyFrequency &&
        inactiveNotifyFrequency == other.inactiveNotifyFrequency;
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
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                0,
                                                                parent
                                                                    .hashCode),
                                                            identifier
                                                                .hashCode),
                                                        templateId.hashCode),
                                                    commissionedBy.hashCode),
                                                description.hashCode),
                                            plan.hashCode),
                                        type.hashCode),
                                    highway.hashCode),
                                intersection.hashCode),
                            speed.hashCode),
                        distance.hashCode),
                    startDate.hashCode),
                endDate.hashCode),
            notifyFrequency.hashCode),
        inactiveNotifyFrequency.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProjectCreateRequest')
          ..add('parent', parent)
          ..add('identifier', identifier)
          ..add('templateId', templateId)
          ..add('commissionedBy', commissionedBy)
          ..add('description', description)
          ..add('plan', plan)
          ..add('type', type)
          ..add('highway', highway)
          ..add('intersection', intersection)
          ..add('speed', speed)
          ..add('distance', distance)
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('notifyFrequency', notifyFrequency)
          ..add('inactiveNotifyFrequency', inactiveNotifyFrequency))
        .toString();
  }
}

class ProjectCreateRequestBuilder
    implements Builder<ProjectCreateRequest, ProjectCreateRequestBuilder> {
  _$ProjectCreateRequest _$v;

  int _parent;
  int get parent => _$this._parent;
  set parent(int parent) => _$this._parent = parent;

  String _identifier;
  String get identifier => _$this._identifier;
  set identifier(String identifier) => _$this._identifier = identifier;

  int _templateId;
  int get templateId => _$this._templateId;
  set templateId(int templateId) => _$this._templateId = templateId;

  String _commissionedBy;
  String get commissionedBy => _$this._commissionedBy;
  set commissionedBy(String commissionedBy) =>
      _$this._commissionedBy = commissionedBy;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _plan;
  String get plan => _$this._plan;
  set plan(String plan) => _$this._plan = plan;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  String _highway;
  String get highway => _$this._highway;
  set highway(String highway) => _$this._highway = highway;

  String _intersection;
  String get intersection => _$this._intersection;
  set intersection(String intersection) => _$this._intersection = intersection;

  double _speed;
  double get speed => _$this._speed;
  set speed(double speed) => _$this._speed = speed;

  double _distance;
  double get distance => _$this._distance;
  set distance(double distance) => _$this._distance = distance;

  String _startDate;
  String get startDate => _$this._startDate;
  set startDate(String startDate) => _$this._startDate = startDate;

  String _endDate;
  String get endDate => _$this._endDate;
  set endDate(String endDate) => _$this._endDate = endDate;

  int _notifyFrequency;
  int get notifyFrequency => _$this._notifyFrequency;
  set notifyFrequency(int notifyFrequency) =>
      _$this._notifyFrequency = notifyFrequency;

  int _inactiveNotifyFrequency;
  int get inactiveNotifyFrequency => _$this._inactiveNotifyFrequency;
  set inactiveNotifyFrequency(int inactiveNotifyFrequency) =>
      _$this._inactiveNotifyFrequency = inactiveNotifyFrequency;

  ProjectCreateRequestBuilder();

  ProjectCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _parent = $v.parent;
      _identifier = $v.identifier;
      _templateId = $v.templateId;
      _commissionedBy = $v.commissionedBy;
      _description = $v.description;
      _plan = $v.plan;
      _type = $v.type;
      _highway = $v.highway;
      _intersection = $v.intersection;
      _speed = $v.speed;
      _distance = $v.distance;
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _notifyFrequency = $v.notifyFrequency;
      _inactiveNotifyFrequency = $v.inactiveNotifyFrequency;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectCreateRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProjectCreateRequest;
  }

  @override
  void update(void Function(ProjectCreateRequestBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProjectCreateRequest build() {
    final _$result = _$v ??
        new _$ProjectCreateRequest._(
            parent: parent,
            identifier: identifier,
            templateId: templateId,
            commissionedBy: commissionedBy,
            description: description,
            plan: plan,
            type: type,
            highway: highway,
            intersection: intersection,
            speed: speed,
            distance: distance,
            startDate: startDate,
            endDate: endDate,
            notifyFrequency: notifyFrequency,
            inactiveNotifyFrequency: inactiveNotifyFrequency);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
