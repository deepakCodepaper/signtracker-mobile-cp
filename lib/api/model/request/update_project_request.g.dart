// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_project_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UpdateProjectRequest> _$updateProjectRequestSerializer =
    new _$UpdateProjectRequestSerializer();

class _$UpdateProjectRequestSerializer
    implements StructuredSerializer<UpdateProjectRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateProjectRequest,
    _$UpdateProjectRequest
  ];
  @override
  final String wireName = 'UpdateProjectRequest';

  @override
  Iterable<Object> serialize(
      Serializers serializers, UpdateProjectRequest object,
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
    value = object.status;
    if (value != null) {
      result
        ..add('status')
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
    value = object.closedAt;
    if (value != null) {
      result
        ..add('closed_at')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.signPlacement;
    if (value != null) {
      result
        ..add('sign_placement')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.location;
    if (value != null) {
      result
        ..add('location')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.designation;
    if (value != null) {
      result
        ..add('designation')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.workArea;
    if (value != null) {
      result
        ..add('work_area')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.shortSummary;
    if (value != null) {
      result
        ..add('short_summary')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.projectCompany;
    if (value != null) {
      result
        ..add('project_company')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(ProjectCompany)));
    }
    value = object.isSubProject;
    if (value != null) {
      result
        ..add('is_sub_project')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.userIds;
    if (value != null) {
      result
        ..add('user_ids')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    value = object.startedBy;
    if (value != null) {
      result
        ..add('started_by')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.onTime;
    if (value != null) {
      result
        ..add('on_time')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.closedEndDiff;
    if (value != null) {
      result
        ..add('closed_end_diff')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.closedEndDiffHours;
    if (value != null) {
      result
        ..add('closed_end_diff_hours')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  UpdateProjectRequest deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UpdateProjectRequestBuilder();

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
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'company_id':
          result.companyId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'parent':
          result.parent = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'identifier':
          result.identifier = serializers.deserialize(value,
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
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
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
        case 'start_date':
          result.startDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'end_date':
          result.endDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'closed_at':
          result.closedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'sign_placement':
          result.signPlacement = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'location':
          result.location = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'designation':
          result.designation = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'work_area':
          result.workArea = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'short_summary':
          result.shortSummary = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'project_company':
          result.projectCompany.replace(serializers.deserialize(value,
              specifiedType: const FullType(ProjectCompany)) as ProjectCompany);
          break;
        case 'is_sub_project':
          result.isSubProject = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'user_ids':
          result.userIds.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))
              as BuiltList<Object>);
          break;
        case 'started_by':
          result.startedBy = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'on_time':
          result.onTime = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'closed_end_diff':
          result.closedEndDiff = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'closed_end_diff_hours':
          result.closedEndDiffHours = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$UpdateProjectRequest extends UpdateProjectRequest {
  @override
  final String method;
  @override
  final int id;
  @override
  final int companyId;
  @override
  final int parent;
  @override
  final String identifier;
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
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String status;
  @override
  final int notifyFrequency;
  @override
  final int inactiveNotifyFrequency;
  @override
  final String startDate;
  @override
  final String endDate;
  @override
  final DateTime closedAt;
  @override
  final String signPlacement;
  @override
  final String location;
  @override
  final String designation;
  @override
  final String workArea;
  @override
  final String shortSummary;
  @override
  final ProjectCompany projectCompany;
  @override
  final bool isSubProject;
  @override
  final BuiltList<int> userIds;
  @override
  final int startedBy;
  @override
  final bool onTime;
  @override
  final int closedEndDiff;
  @override
  final int closedEndDiffHours;

  factory _$UpdateProjectRequest(
          [void Function(UpdateProjectRequestBuilder) updates]) =>
      (new UpdateProjectRequestBuilder()..update(updates)).build();

  _$UpdateProjectRequest._(
      {this.method,
      this.id,
      this.companyId,
      this.parent,
      this.identifier,
      this.type,
      this.highway,
      this.intersection,
      this.speed,
      this.distance,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.notifyFrequency,
      this.inactiveNotifyFrequency,
      this.startDate,
      this.endDate,
      this.closedAt,
      this.signPlacement,
      this.location,
      this.designation,
      this.workArea,
      this.shortSummary,
      this.projectCompany,
      this.isSubProject,
      this.userIds,
      this.startedBy,
      this.onTime,
      this.closedEndDiff,
      this.closedEndDiffHours})
      : super._();

  @override
  UpdateProjectRequest rebuild(
          void Function(UpdateProjectRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateProjectRequestBuilder toBuilder() =>
      new UpdateProjectRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateProjectRequest &&
        method == other.method &&
        id == other.id &&
        companyId == other.companyId &&
        parent == other.parent &&
        identifier == other.identifier &&
        type == other.type &&
        highway == other.highway &&
        intersection == other.intersection &&
        speed == other.speed &&
        distance == other.distance &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        status == other.status &&
        notifyFrequency == other.notifyFrequency &&
        inactiveNotifyFrequency == other.inactiveNotifyFrequency &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        closedAt == other.closedAt &&
        signPlacement == other.signPlacement &&
        location == other.location &&
        designation == other.designation &&
        workArea == other.workArea &&
        shortSummary == other.shortSummary &&
        projectCompany == other.projectCompany &&
        isSubProject == other.isSubProject &&
        userIds == other.userIds &&
        startedBy == other.startedBy &&
        onTime == other.onTime &&
        closedEndDiff == other.closedEndDiff &&
        closedEndDiffHours == other.closedEndDiffHours;
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
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, method.hashCode), id.hashCode), companyId.hashCode), parent.hashCode), identifier.hashCode), type.hashCode), highway.hashCode), intersection.hashCode), speed.hashCode), distance.hashCode), createdAt.hashCode),
                                                                                updatedAt.hashCode),
                                                                            status.hashCode),
                                                                        notifyFrequency.hashCode),
                                                                    inactiveNotifyFrequency.hashCode),
                                                                startDate.hashCode),
                                                            endDate.hashCode),
                                                        closedAt.hashCode),
                                                    signPlacement.hashCode),
                                                location.hashCode),
                                            designation.hashCode),
                                        workArea.hashCode),
                                    shortSummary.hashCode),
                                projectCompany.hashCode),
                            isSubProject.hashCode),
                        userIds.hashCode),
                    startedBy.hashCode),
                onTime.hashCode),
            closedEndDiff.hashCode),
        closedEndDiffHours.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UpdateProjectRequest')
          ..add('method', method)
          ..add('id', id)
          ..add('companyId', companyId)
          ..add('parent', parent)
          ..add('identifier', identifier)
          ..add('type', type)
          ..add('highway', highway)
          ..add('intersection', intersection)
          ..add('speed', speed)
          ..add('distance', distance)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('status', status)
          ..add('notifyFrequency', notifyFrequency)
          ..add('inactiveNotifyFrequency', inactiveNotifyFrequency)
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('closedAt', closedAt)
          ..add('signPlacement', signPlacement)
          ..add('location', location)
          ..add('designation', designation)
          ..add('workArea', workArea)
          ..add('shortSummary', shortSummary)
          ..add('projectCompany', projectCompany)
          ..add('isSubProject', isSubProject)
          ..add('userIds', userIds)
          ..add('startedBy', startedBy)
          ..add('onTime', onTime)
          ..add('closedEndDiff', closedEndDiff)
          ..add('closedEndDiffHours', closedEndDiffHours))
        .toString();
  }
}

class UpdateProjectRequestBuilder
    implements Builder<UpdateProjectRequest, UpdateProjectRequestBuilder> {
  _$UpdateProjectRequest _$v;

  String _method;
  String get method => _$this._method;
  set method(String method) => _$this._method = method;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  int _companyId;
  int get companyId => _$this._companyId;
  set companyId(int companyId) => _$this._companyId = companyId;

  int _parent;
  int get parent => _$this._parent;
  set parent(int parent) => _$this._parent = parent;

  String _identifier;
  String get identifier => _$this._identifier;
  set identifier(String identifier) => _$this._identifier = identifier;

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

  DateTime _createdAt;
  DateTime get createdAt => _$this._createdAt;
  set createdAt(DateTime createdAt) => _$this._createdAt = createdAt;

  DateTime _updatedAt;
  DateTime get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime updatedAt) => _$this._updatedAt = updatedAt;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  int _notifyFrequency;
  int get notifyFrequency => _$this._notifyFrequency;
  set notifyFrequency(int notifyFrequency) =>
      _$this._notifyFrequency = notifyFrequency;

  int _inactiveNotifyFrequency;
  int get inactiveNotifyFrequency => _$this._inactiveNotifyFrequency;
  set inactiveNotifyFrequency(int inactiveNotifyFrequency) =>
      _$this._inactiveNotifyFrequency = inactiveNotifyFrequency;

  String _startDate;
  String get startDate => _$this._startDate;
  set startDate(String startDate) => _$this._startDate = startDate;

  String _endDate;
  String get endDate => _$this._endDate;
  set endDate(String endDate) => _$this._endDate = endDate;

  DateTime _closedAt;
  DateTime get closedAt => _$this._closedAt;
  set closedAt(DateTime closedAt) => _$this._closedAt = closedAt;

  String _signPlacement;
  String get signPlacement => _$this._signPlacement;
  set signPlacement(String signPlacement) =>
      _$this._signPlacement = signPlacement;

  String _location;
  String get location => _$this._location;
  set location(String location) => _$this._location = location;

  String _designation;
  String get designation => _$this._designation;
  set designation(String designation) => _$this._designation = designation;

  String _workArea;
  String get workArea => _$this._workArea;
  set workArea(String workArea) => _$this._workArea = workArea;

  String _shortSummary;
  String get shortSummary => _$this._shortSummary;
  set shortSummary(String shortSummary) => _$this._shortSummary = shortSummary;

  ProjectCompanyBuilder _projectCompany;
  ProjectCompanyBuilder get projectCompany =>
      _$this._projectCompany ??= new ProjectCompanyBuilder();
  set projectCompany(ProjectCompanyBuilder projectCompany) =>
      _$this._projectCompany = projectCompany;

  bool _isSubProject;
  bool get isSubProject => _$this._isSubProject;
  set isSubProject(bool isSubProject) => _$this._isSubProject = isSubProject;

  ListBuilder<int> _userIds;
  ListBuilder<int> get userIds => _$this._userIds ??= new ListBuilder<int>();
  set userIds(ListBuilder<int> userIds) => _$this._userIds = userIds;

  int _startedBy;
  int get startedBy => _$this._startedBy;
  set startedBy(int startedBy) => _$this._startedBy = startedBy;

  bool _onTime;
  bool get onTime => _$this._onTime;
  set onTime(bool onTime) => _$this._onTime = onTime;

  int _closedEndDiff;
  int get closedEndDiff => _$this._closedEndDiff;
  set closedEndDiff(int closedEndDiff) => _$this._closedEndDiff = closedEndDiff;

  int _closedEndDiffHours;
  int get closedEndDiffHours => _$this._closedEndDiffHours;
  set closedEndDiffHours(int closedEndDiffHours) =>
      _$this._closedEndDiffHours = closedEndDiffHours;

  UpdateProjectRequestBuilder();

  UpdateProjectRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _method = $v.method;
      _id = $v.id;
      _companyId = $v.companyId;
      _parent = $v.parent;
      _identifier = $v.identifier;
      _type = $v.type;
      _highway = $v.highway;
      _intersection = $v.intersection;
      _speed = $v.speed;
      _distance = $v.distance;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _status = $v.status;
      _notifyFrequency = $v.notifyFrequency;
      _inactiveNotifyFrequency = $v.inactiveNotifyFrequency;
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _closedAt = $v.closedAt;
      _signPlacement = $v.signPlacement;
      _location = $v.location;
      _designation = $v.designation;
      _workArea = $v.workArea;
      _shortSummary = $v.shortSummary;
      _projectCompany = $v.projectCompany?.toBuilder();
      _isSubProject = $v.isSubProject;
      _userIds = $v.userIds?.toBuilder();
      _startedBy = $v.startedBy;
      _onTime = $v.onTime;
      _closedEndDiff = $v.closedEndDiff;
      _closedEndDiffHours = $v.closedEndDiffHours;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateProjectRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UpdateProjectRequest;
  }

  @override
  void update(void Function(UpdateProjectRequestBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UpdateProjectRequest build() {
    _$UpdateProjectRequest _$result;
    try {
      _$result = _$v ??
          new _$UpdateProjectRequest._(
              method: method,
              id: id,
              companyId: companyId,
              parent: parent,
              identifier: identifier,
              type: type,
              highway: highway,
              intersection: intersection,
              speed: speed,
              distance: distance,
              createdAt: createdAt,
              updatedAt: updatedAt,
              status: status,
              notifyFrequency: notifyFrequency,
              inactiveNotifyFrequency: inactiveNotifyFrequency,
              startDate: startDate,
              endDate: endDate,
              closedAt: closedAt,
              signPlacement: signPlacement,
              location: location,
              designation: designation,
              workArea: workArea,
              shortSummary: shortSummary,
              projectCompany: _projectCompany?.build(),
              isSubProject: isSubProject,
              userIds: _userIds?.build(),
              startedBy: startedBy,
              onTime: onTime,
              closedEndDiff: closedEndDiff,
              closedEndDiffHours: closedEndDiffHours);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'projectCompany';
        _projectCompany?.build();

        _$failedField = 'userIds';
        _userIds?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UpdateProjectRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
