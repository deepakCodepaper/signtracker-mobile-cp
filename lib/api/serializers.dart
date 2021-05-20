import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:signtracker/api/date_time_serializer.dart';
import 'package:signtracker/api/model/base_model.dart';
import 'package:signtracker/api/model/emails.dart';
import 'package:signtracker/api/model/invitation.dart';
import 'package:signtracker/api/model/login.dart';
import 'package:signtracker/api/model/members.dart';
import 'package:signtracker/api/model/project_company.dart';
import 'package:signtracker/api/model/request/company_invite_request.dart';
import 'package:signtracker/api/model/request/project_create_request.dart';
import 'package:signtracker/api/model/request/send_invite_request.dart';
import 'package:signtracker/api/model/request/update_project_request.dart';
import 'package:signtracker/api/model/request/close_project_request.dart';
import 'package:signtracker/api/model/sign.dart';
import 'package:signtracker/api/model/sign_masters.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/api/model/request/sign_request.dart';
import 'package:signtracker/api/model/template.dart';
import 'package:signtracker/api/model/user.dart';
import 'package:signtracker/api/model/user_device.dart';

import 'model/check_sign_project.dart';
import 'model/company.dart';
import 'model/details.dart';
import 'model/invite.dart';
import 'model/invite_project.dart';
import 'model/project_logs.dart';
import 'model/request/emails_request.dart';
import 'model/schedule.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  BaseModel,
  User,
  Login,
  Sign,
  SignProject,
  ProjectCompany,
  SignRequest,
  ProjectCreateRequest,
  UpdateProjectRequest,
  CloseProjectRequest,
  Invitation,
  Members,
  Invite,
  InviteProject,
  SendInviteRequest,
  ProjectLogs,
  Details,
  UserDevice,
  Emails,
  EmailsRequest,
  Template,
  SignMasters,
  Schedule,
  Company,
  CompanyInviteRequest,
  CheckSignProject,
])
final Serializers serializers = _$serializers;

final Serializers standardSerializers = (serializers.toBuilder()
      ..add(DateTimeSerializer())
      ..addPlugin(StandardJsonPlugin())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Emails)]),
          () => new ListBuilder<Emails>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>()))
    .build();

T deserializeOf<T>(dynamic value) => standardSerializers.deserializeWith<T>(
    standardSerializers.serializerForType(T), value);

BuiltList<T> deserializeListOf<T>(dynamic value) => BuiltList.from(
    value.map((value) => deserializeOf<T>(value)).toList(growable: false));
