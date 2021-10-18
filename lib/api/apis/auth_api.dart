import 'dart:convert';

import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:signtracker/api/api_client.dart';
import 'package:signtracker/api/model/base_model.dart';
import 'package:signtracker/api/model/login.dart';
import 'package:signtracker/api/serializers.dart';

class AuthApi {
  AuthApi(this.apiClient);

  final ApiClient apiClient;

  final String apiPath = 'auth';

  Future<dynamic> login(String email, String password) async {
    final requestBody = <String, dynamic>{
      'email': email,
      'password': password,
    };

    if (email == null) return 'Email is required';

    if (password == null) return 'Password is required';

    final path = '$apiPath/login';

    try {
      final response = await apiClient.dio.post(path,
          data: jsonEncode(requestBody),
          options: buildCacheOptions(Duration(hours: 1)));

      if (response.data != null) {
        var message = (response.data['message'] ?? "").toString().toLowerCase();
        if (message == "unverified") {
          return "Your account hasn't been verified. Please check your Email";
        }
        return deserializeOf<Login>(response.data['data']);
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<bool> register(
      String email,
      String password,
      String name,
      String companyName,
      String countryName,
      String countryCode,
      String stateName,
      String stateCode) async {
    final requestBody = <String, dynamic>{
      'email': email,
      'password': password,
      'name': name,
      'company_name': companyName,
      'country_name': countryName,
      'country_code': countryCode,
      'state_name': stateName,
      'state_code': stateCode,
    };

    if (email == null) throw Exception('Email is required');
    if (password == null) throw Exception('Password is required');

    final path = 'admin/$apiPath/register';

    try {
      final _ = await apiClient.dio.post(path,
          data: jsonEncode(requestBody),
          options: buildCacheOptions(Duration(hours: 1)));

      return true;
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }
}

BaseModel<Login> fromJsonToLogin(String jsonString) {
  final specifiedType = const FullType(BaseModel, [FullType(Login)]);
  final serializersWithBuilder = (standardSerializers.toBuilder()
        ..addBuilderFactory(specifiedType, () => BaseModel<Login>()))
      .build();
  return serializersWithBuilder.deserialize(json.decode(jsonString),
      specifiedType: specifiedType);
}
