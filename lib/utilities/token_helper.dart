import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenHelper {
  static const KEY_TOKEN = "access_token";
  static const USER_NAME = "user_name";
  static const COUNTRY_CODE = "country_code";
  static const STATE_CODE = "state_code";

  final _storage = new FlutterSecureStorage();

  Future<void> persistToken(String accessToken) async {
    await _storage.write(key: KEY_TOKEN, value: accessToken);
  }

  Future<String> getToken() async {
    final token = await _storage.read(key: KEY_TOKEN);
    return token;
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: KEY_TOKEN);
  }

  Future<void> persistName(String name) async {
    await _storage.write(key: USER_NAME, value: name);
  }

  Future<String> getName() async {
    final userName = await _storage.read(key: USER_NAME);
    return userName;
  }

  Future<void> deleteName() async {
    await _storage.delete(key: USER_NAME);
  }

  Future<void> persistCountryCode(String countryCode) async {
    await _storage.write(key: COUNTRY_CODE, value: countryCode);
  }

  Future<String> getCountryCode() async {
    final countryCode = await _storage.read(key: COUNTRY_CODE);
    return countryCode;
  }

  Future<void> deleteCountryCode() async {
    await _storage.delete(key: COUNTRY_CODE);
  }

  Future<void> persistStateCode(String stateCode) async {
    await _storage.write(key: STATE_CODE, value: stateCode);
  }

  Future<String> getStateCode() async {
    final stateCode = await _storage.read(key: STATE_CODE);
    return stateCode;
  }

  Future<void> deleteStateCode() async {
    await _storage.delete(key: STATE_CODE);
  }
}
