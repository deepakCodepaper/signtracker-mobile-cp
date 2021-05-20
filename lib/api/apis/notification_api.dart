import 'dart:convert';

import 'package:signtracker/api/api_client.dart';
import 'package:signtracker/api/model/user_device.dart';
import 'package:signtracker/api/serializers.dart';
import 'package:dio/dio.dart';

class NotificationApi {
  NotificationApi({this.apiClient});

  final ApiClient apiClient;

  Future<UserDevice> registerDevice(String playerId) async {
    final path = 'user-devices';

    FormData formData = new FormData.fromMap({
      "player_id": playerId,
    });

    try {
      final response = await apiClient.dio.post(
        path,
        data: formData,
      );

      if (response.data != null) {
        return deserializeOf<UserDevice>(response.data['data']);
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }
}
