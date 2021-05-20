import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NotifHelper {
  static const KEY_NOTIF = "notifications";

  final _storage = new FlutterSecureStorage();

  Future<void> persistNotif(String notif) async {
    await _storage.write(key: KEY_NOTIF, value: notif);
  }

  Future<String> getNotifNumber() async {
    final notif = await _storage.read(key: KEY_NOTIF);
    return notif;
  }

  Future<void> removeNotif() async {
    await _storage.delete(key: KEY_NOTIF);
  }
}
