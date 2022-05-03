import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:signtracker/app.dart';
import 'package:signtracker/utilities/app_flavors.dart';
import 'package:signtracker/utilities/constants.dart';

class AppBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BlocSupervisor.delegate = AppBlocDelegate();
  //OneSignal.shared.init("23fb4990-dac7-459e-8b80-d88fcbb2b565", iOSSettings: {OSiOSSettings.autoPrompt: false});
  OneSignal.shared.setAppId("23fb4990-dac7-459e-8b80-d88fcbb2b565");
  //OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });

  final settings = await _getFlavorSettings();
  apiUrl = settings.apiUrl;
  storageUrl = settings.storageUrl;
  portalImagesUrl = settings.portalImagesUrl;

  debugPrint('yow.apiUrl: $apiUrl');
  debugPrint('yow.storageUrl: $storageUrl');
  debugPrint('yow.portalImagesUrl: $portalImagesUrl');
  runApp(App());
}

Future<AppFlavors> _getFlavorSettings() async {
  String flavor =
      await const MethodChannel('flavor').invokeMethod<String>('getFlavor');
  switch (flavor) {
    case 'dev':
    case 'stg':
      return AppFlavors.stg();
    case 'prod':
      return AppFlavors.prod();
    default:
      throw Exception("Unknown flavor: $flavor");
  }
}
