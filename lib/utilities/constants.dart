import 'dart:async';

import 'package:package_info_plus/package_info_plus.dart';

const String apiUrl = 'https://api.thesigntracker.com/api/v1/';
const String storageUrl = 'https://api.thesigntracker.com/storage';
const String portalImagesUrl = 'https://portal.thesigntracker.com/images/';

class Constants {
  static Future<String> getBaseUrl() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    print("yowyow.packageName: $packageName");

    return packageName;
  }
}
