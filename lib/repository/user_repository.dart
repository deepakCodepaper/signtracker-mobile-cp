import 'package:meta/meta.dart';
import 'package:signtracker/api/model/login.dart';
import 'package:signtracker/api/model/user.dart';
import 'package:signtracker/api/model/user_device.dart';
import 'package:signtracker/network/auth_client.dart';
import 'package:signtracker/network/sign_tracker_client.dart';
import 'package:signtracker/utilities/token_helper.dart';

class UserRepository {
  final authClient = AuthClient();

  final tokenHelper = TokenHelper();

  final signTrackerClient = SignTrackerClient();

  Future<dynamic> authenticate({
    @required String username,
    @required String password,
  }) async {
    final api = authClient.getAuthApi();
    final result = await api.login(username, password);
    print(result.toString());
    if (result is Login &&
        result?.success == true &&
        result?.accessToken != null &&
        result?.user != null) {
      print("success");
      tokenHelper.persistName(result.user.name);
      tokenHelper.persistToken(result.accessToken);
      tokenHelper.persistCountryCode(result.user.countryCode);
      tokenHelper.persistStateCode(result.user.stateCode);
    }
    print("fail");
    return result;
  }

  Future<bool> register({
    @required String username,
    @required String password,
    @required String name,
    @required String mobile,
    @required String companyCode,
    String countryName,
    String countryCode,
    String stateName,
    String stateCode,
  }) async {
    final api = authClient.getAuthApi();
    final register = await api.register(username, password, name, mobile,
        companyCode, countryName, countryCode, stateName, stateCode);
    if (register == true) {
      return true;
    }
    return false;
  }

  Future<bool> resetPassword({@required String email}) async {
    final api = authClient.getAuthApi();
    final result = await api.resetPassword(email);
    if (result == true) {
      return true;
    }
    return false;
  }

  Future<void> deleteToken() async {
    await tokenHelper.deleteToken();
  }

  Future<bool> hasToken() async {
    final token = await tokenHelper.getToken();
    print(token.isNotEmpty);
    print('====================');
    print(token.isEmpty);
    print('====================');
    print(token);
    if (token == null || token == '') {
      return false;
    } else {
      return true;
    }
  }

  Future<User> getUserDetails() async {
    final api = await signTrackerClient.getUsersApi();
    return api.getUserDetails();
  }

  Future<UserDevice> registerDevice(String playerId) async {
    final api = await signTrackerClient.getNotificationApi();
    return await api.registerDevice(playerId);
  }
}
