import 'package:signtracker/api/api_client.dart';
import 'package:signtracker/api/apis/auth_api.dart';
import 'package:signtracker/utilities/constants.dart';

class AuthClient {
  // final String authBaseUrl = 'http://portal.thesigntracker.com/api/v1/';
  final String authBaseUrl = apiUrl;

  AuthApi getAuthApi() => AuthApi(ApiClient(basePath: authBaseUrl));
}
