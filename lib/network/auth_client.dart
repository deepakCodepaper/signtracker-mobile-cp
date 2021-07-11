import 'package:signtracker/api/api_client.dart';
import 'package:signtracker/api/apis/auth_api.dart';

class AuthClient {
  // final String authBaseUrl = 'http://portal.thesigntracker.com/api/v1/';
  final String authBaseUrl = 'https://api.thesigntracker.com/api/v1/';

  AuthApi getAuthApi() => AuthApi(ApiClient(basePath: authBaseUrl));
}
