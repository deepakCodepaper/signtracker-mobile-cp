import 'package:signtracker/api/api_client.dart';
import 'package:signtracker/api/apis/invitation_api.dart';
import 'package:signtracker/api/apis/notification_api.dart';
import 'package:signtracker/api/apis/project_api.dart';
import 'package:signtracker/api/apis/sign_api.dart';
import 'package:signtracker/api/apis/template_api.dart';
import 'package:signtracker/api/apis/users_api.dart';
import 'package:signtracker/utilities/token_helper.dart';

class SignTrackerClient {
  final String _apiBaseUrl = 'https://api.thesigntracker.com/api/v1/';

  Future<String> _getToken() async => await TokenHelper().getToken();

  Future<ApiClient> _getApiClient() async =>
      ApiClient(basePath: _apiBaseUrl, token: await _getToken());

  Future<SignApi> getSignApi() async =>
      SignApi(apiClient: await _getApiClient());

  Future<ProjectApi> getProjectAPI() async =>
      ProjectApi(apiClient: await _getApiClient());

  Future<InvitationApi> getInvitationApi() async =>
      InvitationApi(apiClient: await _getApiClient());

  Future<UsersApi> getUsersApi() async =>
      UsersApi(apiClient: await _getApiClient());

  Future<NotificationApi> getNotificationApi() async =>
      NotificationApi(apiClient: await _getApiClient());

  Future<TemplateApi> getTemplatesApi() async =>
      TemplateApi(apiClient: await _getApiClient());
}
