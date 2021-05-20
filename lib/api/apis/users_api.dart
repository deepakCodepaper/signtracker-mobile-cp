import 'package:signtracker/api/api_client.dart';
import 'package:signtracker/api/model/user.dart';
import 'package:signtracker/api/serializers.dart';
import 'package:dio/dio.dart';

class UsersApi {
  UsersApi({this.apiClient});

  final ApiClient apiClient;

  Future<User> getUserDetails() async {
    final path = 'auth/user';
    try {
      final response = await apiClient.dio.get(path);

      if (response.data != null) {
        return deserializeOf<User>(response.data['data']['user']);
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }
}
