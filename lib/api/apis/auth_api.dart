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
      Response<dynamic> response = await apiClient.dio.post(
        path,
        data: jsonEncode(requestBody),
        options: buildCacheOptions(
          Duration(hours: 1),
        ),
      );

      if (response.data != null) {
        print("yes");
        var message = (response.data['message'] ?? "").toString().toLowerCase();
        print("MESSAGE====" + message);
        if (message == "unverified") {
          return "Your account hasn't been verified. Please check your Email";
        }
        return deserializeOf<Login>(response.data['data']);
      }
    } on DioError catch (e) {
      print("e");
      print(e.message);
    } on Exception catch (e) {
      print("exce");
      print(e.toString());
    }
    return null;
  }

  Future<bool> register(
      String email,
      String password,
      String name,
      String mobile,
      String companyCode,
      String countryName,
      String countryCode,
      String stateName,
      String stateCode,
      String city,
      String street_address) async {
    final requestBody = <String, dynamic>{
      'email': email,
      'password': password,
      'name': name,
      'mobile': mobile,
      'company_name': companyCode,
      'country_name': countryName,
      'country_code': countryCode,
      'state_name': stateName,
      'state_code': stateCode,
      'city': city,
      'street_address': street_address,
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

  Future<bool> resetPassword(String email) async {
    final requestBody = <String, dynamic>{'email': email};

    if (email == null) throw Exception('Email is required');

    final path = '/reset_password';

    try {
      final response = await apiClient.dio.post(path,
          data: jsonEncode(requestBody),
          options: buildCacheOptions(Duration(hours: 1)));

      if (response.data['success'] ?? false) {
        return true;
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }
    return false;
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
