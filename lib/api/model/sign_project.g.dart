// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_project.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SignProject> _$signProjectSerializer = new _$SignProjectSerializer();

class _$SignProjectSerializer implements StructuredSerializer<SignProject> {
  @override
  final Iterable<Type> types = const [SignProject, _$SignProject];
  @override
  final String wireName = 'SignProject';

  @override
  Iterable<Object> serialize(Serializers serializers, SignProject object,
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
    if (object.templateId != null) {
      result
        ..add('template_id')
        ..add(serializers.serialize(object.templateId,
            specifiedType: const FullType(int)));
    }
    if (object.parent != null) {
      result
        ..add('parent')
        ..add(serializers.serialize(object.parent,
            specifiedType: const FullType(int)));
    }
    if (object.contractNumber != null) {
      result
        ..add('contract_number')
        ..add(serializers.serialize(object.contractNumber,
            specifiedType: const FullType(String)));
    }
    if (object.commissionedBy != null) {
      result
        ..add('commissioned_by')
        ..add(serializers.serialize(object.commissionedBy,
            specifiedType: const FullType(String)));
    }
    if (object.identifier != null) {
      result
        ..add('identifier')
        ..add(serializers.serialize(object.identifier,
            specifiedType: const FullType(String)));
    }
    if (object.type != null) {
      result
        ..add('type')
        ..add(serializers.serialize(object.type,
            specifiedType: const FullType(String)));
    }
    if (object.plan != null) {
      result
        ..add('plan')
        ..add(serializers.serialize(object.plan,
            specifiedType: const FullType(String)));
    }
    if (object.highway != null) {
      result
        ..add('highway')
        ..add(serializers.serialize(object.highway,
            specifiedType: const FullType(String)));
    }
    if (object.intersection != null) {
      result
        ..add('intersection')
        ..add(serializers.serialize(object.intersection,
            specifiedType: const FullType(String)));
    }
    if (object.speed != null) {
      result
        ..add('speed')
        ..add(serializers.serialize(object.speed,
            specifiedType: const FullType(double)));
    }
    if (object.distance != null) {
      result
        ..add('distance')
        ..add(serializers.serialize(object.distance,
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
    if (object.status != null) {
      result
        ..add('status')
        ..add(serializers.serialize(object.status,
            specifiedType: const FullType(String)));
    }
    if (object.notifyFrequency != null) {
      result
        ..add('notify_frequency')
        ..add(serializers.serialize(object.notifyFrequency,
            specifiedType: const FullType(int)));
    }
    if (object.inactiveNotifyFrequency != null) {
      result
        ..add('inactive_notify_frequency')
        ..add(serializers.serialize(object.inactiveNotifyFrequency,
            specifiedType: const FullType(int)));
    }
    if (object.startDate != null) {
      result
        ..add('start_date')
        ..add(serializers.serialize(object.startDate,
            specifiedType: const FullType(String)));
    }
    if (object.endDate != null) {
      result
        ..add('end_date')
        ..add(serializers.serialize(object.endDate,
            specifiedType: const FullType(String)));
    }
    if (object.closedAt != null) {
      result
        ..add('closed_at')
        ..add(serializers.serialize(object.closedAt,
            specifiedType: const FullType(DateTime)));
    }
    if (object.signPlacement != null) {
      result
        ..add('sign_placement')
        ..add(serializers.serialize(object.signPlacement,
            specifiedType: const FullType(String)));
    }
    if (object.location != null) {
      result
        ..add('location')
        ..add(serializers.serialize(object.location,
            specifiedType: const FullType(String)));
    }
    if (object.designation != null) {
      result
        ..add('designation')
        ..add(serializers.serialize(object.designation,
            specifiedType: const FullType(String)));
    }
    if (object.workArea != null) {
      result
        ..add('work_area')
        ..add(serializers.serialize(object.workArea,
            specifiedType: const FullType(String)));
    }
    if (object.shortSummary != null) {
      result
        ..add('short_summary')
        ..add(serializers.serialize(object.shortSummary,
            specifiedType: const FullType(String)));
    }
    if (object.projectCompany != null) {
      result
        ..add('project_company')
        ..add(serializers.serialize(object.projectCompany,
            specifiedType: const FullType(ProjectCompany)));
    }
    if (object.isSubProject != null) {
      result
        ..add('is_sub_project')
        ..add(serializers.serialize(object.isSubProject,
            specifiedType: const FullType(bool)));
    }
    if (object.userIds != null) {
      result
        ..add('user_ids')
        ..add(serializers.serialize(object.userIds,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    if (object.startedBy != null) {
      result
        ..add('started_by')
        ..add(serializers.serialize(object.startedBy,
            specifiedType: const FullType(int)));
    }
    if (object.onTime != null) {
      result
        ..add('on_time')
        ..add(serializers.serialize(object.onTime,
            specifiedType: const FullType(bool)));
    }
    if (object.closedEndDiff != null) {
      result
        ..add('closed_end_diff')
        ..add(serializers.serialize(object.closedEndDiff,
            specifiedType: const FullType(int)));
    }
    if (object.closedEndDiffHours != null) {
      result
        ..add('closed_end_diff_hours')
        ..add(serializers.serialize(object.closedEndDiffHours,
            specifiedType: const FullType(int)));
    }
    if (object.method != null) {
      result
        ..add('_method')
        ..add(serializers.serialize(object.method,
            specifiedType: const FullType(String)));
    }
    if (object.subProjects != null) {
      result
        ..add('sub_projects')
        ..add(serializers.serialize(object.subProjects,
            specifiedType: const FullType(
                BuiltList, const [const FullType(SignProject)])));
    }
    if (object.members != null) {
      result
        ..add('members')
        ..add(serializers.serialize(object.members,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Members)])));
    }
    return result;
  }

  @override
  SignProject deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SignProjectBuilder();

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
        case 'template_id':
          result.templateId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'parent':
          result.parent = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'contract_number':
          result.contractNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'commissioned_by':
          result.commissionedBy = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'identifier':
          result.identifier = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'plan':
          result.plan = serializers.deserialize(value,
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
        case '_method':
          result.method = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'sub_projects':
          result.subProjects.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(SignProject)]))
              as BuiltList<Object>);
          break;
        case 'members':
          result.members.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Members)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$SignProject extends SignProject {
  @override
  final int id;
  @override
  final int companyId;
  @override
  final int templateId;
  @override
  final int parent;
  @override
  final String contractNumber;
  @override
  final String commissionedBy;
  @override
  final String identifier;
  @override
  final String type;
  @override
  final String plan;
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
  @override
  final String method;
  @override
  final BuiltList<SignProject> subProjects;
  @override
  final BuiltList<Members> members;

  factory _$SignProject([void Function(SignProjectBuilder) updates]) =>
      (new SignProjectBuilder()..update(updates)).build();

  _$SignProject._(
      {this.id,
      this.companyId,
      this.templateId,
      this.parent,
      this.contractNumber,
      this.commissionedBy,
      this.identifier,
      this.type,
      this.plan,
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
      this.closedEndDiffHours,
      this.method,
      this.subProjects,
      this.members})
      : super._();

  @override
  SignProject rebuild(void Function(SignProjectBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SignProjectBuilder toBuilder() => new SignProjectBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignProject &&
        id == other.id &&
        companyId == other.companyId &&
        templateId == other.templateId &&
        parent == other.parent &&
        contractNumber == other.contractNumber &&
        commissionedBy == other.commissionedBy &&
        identifier == other.identifier &&
        type == other.type &&
        plan == other.plan &&
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
        closedEndDiffHours == other.closedEndDiffHours &&
        method == other.method &&
        subProjects == other.subProjects &&
        members == other.members;
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, id.hashCode), companyId.hashCode), templateId.hashCode), parent.hashCode), contractNumber.hashCode), commissionedBy.hashCode), identifier.hashCode), type.hashCode), plan.hashCode), highway.hashCode), intersection.hashCode), speed.hashCode), distance.hashCode), createdAt.hashCode), updatedAt.hashCode), status.hashCode), notifyFrequency.hashCode),
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
                    closedEndDiffHours.hashCode),
                method.hashCode),
            subProjects.hashCode),
        members.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SignProject')
          ..add('id', id)
          ..add('companyId', companyId)
          ..add('templateId', templateId)
          ..add('parent', parent)
          ..add('contractNumber', contractNumber)
          ..add('commissionedBy', commissionedBy)
          ..add('identifier', identifier)
          ..add('type', type)
          ..add('plan', plan)
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
          ..add('closedEndDiffHours', closedEndDiffHours)
          ..add('method', method)
          ..add('subProjects', subProjects)
          ..add('members', members))
        .toString();
  }
}

class SignProjectBuilder implements Builder<SignProject, SignProjectBuilder> {
  _$SignProject _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  int _companyId;
  int get companyId => _$this._companyId;
  set companyId(int companyId) => _$this._companyId = companyId;

  int _templateId;
  int get templateId => _$this._templateId;
  set templateId(int templateId) => _$this._templateId = templateId;

  int _parent;
  int get parent => _$this._parent;
  set parent(int parent) => _$this._parent = parent;

  String _contractNumber;
  String get contractNumber => _$this._contractNumber;
  set contractNumber(String contractNumber) =>
      _$this._contractNumber = contractNumber;

  String _commissionedBy;
  String get commissionedBy => _$this._commissionedBy;
  set commissionedBy(String commissionedBy) =>
      _$this._commissionedBy = commissionedBy;

  String _identifier;
  String get identifier => _$this._identifier;
  set identifier(String identifier) => _$this._identifier = identifier;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  String _plan;
  String get plan => _$this._plan;
  set plan(String plan) => _$this._plan = plan;

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

  String _method;
  String get method => _$this._method;
  set method(String method) => _$this._method = method;

  ListBuilder<SignProject> _subProjects;
  ListBuilder<SignProject> get subProjects =>
      _$this._subProjects ??= new ListBuilder<SignProject>();
  set subProjects(ListBuilder<SignProject> subProjects) =>
      _$this._subProjects = subProjects;

  ListBuilder<Members> _members;
  ListBuilder<Members> get members =>
      _$this._members ??= new ListBuilder<Members>();
  set members(ListBuilder<Members> members) => _$this._members = members;

  SignProjectBuilder();

  SignProjectBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _companyId = _$v.companyId;
      _templateId = _$v.templateId;
      _parent = _$v.parent;
      _contractNumber = _$v.contractNumber;
      _commissionedBy = _$v.commissionedBy;
      _identifier = _$v.identifier;
      _type = _$v.type;
      _plan = _$v.plan;
      _highway = _$v.highway;
      _intersection = _$v.intersection;
      _speed = _$v.speed;
      _distance = _$v.distance;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _status = _$v.status;
      _notifyFrequency = _$v.notifyFrequency;
      _inactiveNotifyFrequency = _$v.inactiveNotifyFrequency;
      _startDate = _$v.startDate;
      _endDate = _$v.endDate;
      _closedAt = _$v.closedAt;
      _signPlacement = _$v.signPlacement;
      _location = _$v.location;
      _designation = _$v.designation;
      _workArea = _$v.workArea;
      _shortSummary = _$v.shortSummary;
      _projectCompany = _$v.projectCompany?.toBuilder();
      _isSubProject = _$v.isSubProject;
      _userIds = _$v.userIds?.toBuilder();
      _startedBy = _$v.startedBy;
      _onTime = _$v.onTime;
      _closedEndDiff = _$v.closedEndDiff;
      _closedEndDiffHours = _$v.closedEndDiffHours;
      _method = _$v.method;
      _subProjects = _$v.subProjects?.toBuilder();
      _members = _$v.members?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignProject other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SignProject;
  }

  @override
  void update(void Function(SignProjectBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SignProject build() {
    _$SignProject _$result;
    try {
      _$result = _$v ??
          new _$SignProject._(
              id: id,
              companyId: companyId,
              templateId: templateId,
              parent: parent,
              contractNumber: contractNumber,
              commissionedBy: commissionedBy,
              identifier: identifier,
              type: type,
              plan: plan,
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
              closedEndDiffHours: closedEndDiffHours,
              method: method,
              subProjects: _subProjects?.build(),
              members: _members?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'projectCompany';
        _projectCompany?.build();

        _$failedField = 'userIds';
        _userIds?.build();

        _$failedField = 'subProjects';
        _subProjects?.build();
        _$failedField = 'members';
        _members?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SignProject', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
