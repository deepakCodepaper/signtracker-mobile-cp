import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signtracker/blocs/auth/authentication_bloc.dart';
import 'package:signtracker/feature/project/list/project_list_page.dart';
import 'package:signtracker/feature/splash/splash_page.dart';
import 'package:signtracker/repository/invitation_repository.dart';
import 'package:signtracker/repository/project_repository.dart';
import 'package:signtracker/repository/sign_repository.dart';
import 'package:signtracker/utilities/app_router.dart';
import 'package:signtracker/utilities/app_theme.dart';
import 'package:signtracker/utilities/notif_helper.dart';

import 'feature/check_signs/check_signs_page.dart';
import 'repository/user_repository.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StatefulApp();
  }
}

class StatefulApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatefulAppState();
}

class _StatefulAppState extends State<StatefulApp> {
  UserRepository userRepository;
  SignRepository signRepository;
  ProjectRepository projectRepository;
  InvitationRepository invitationRepository;
  AuthenticationBloc authenticationBloc;
  bool isLoggedIn = false;
  String firstRoute = '';
  NotifHelper notifHelper;

  final navigatorKey = GlobalKey<NavigatorState>();

  void checkAuth() async {
    final userLoggedIn = await authenticationBloc.isLoggedIn();
    setState(() => isLoggedIn = userLoggedIn);
  }

  Future<void> onSelectNotification(String payload) {
    return Navigator.pushNamed(context, CheckSignsPage.route,
        arguments: CheckSignsPageArgs(true));
  }

  // What to do when the user opens/taps on a notification
  void _handleNotificationOpened(OSNotificationOpenedResult result) async {
    print('[notification_service - _handleNotificationOpened()');
    print(
        "Opened notification: ${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}");

    // Since the only thing we can get current are new Alerts -- go to the Alert screen
    navigatorKey.currentState
        .pushNamed(CheckSignsPage.route, arguments: CheckSignsPageArgs(true));
  }

  void _handleNotificationReceived(OSNotification notification) async {
    notification.payload.jsonRepresentation();
    print(notification.jsonRepresentation());

    notifHelper.getNotifNumber().then((value) {
      notifHelper.persistNotif((int.parse(value) + 1).toString());
    });
  }

  @override
  void initState() {
    checkIfFirstRun();
    initDynamicLinks(context);
    initRepositories();
    initBlocs();
    notifHelper = NotifHelper();
    super.initState();

    OneSignal.shared
      ..setNotificationReceivedHandler(_handleNotificationReceived);

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      navigatorKey.currentState
          .pushNamed(CheckSignsPage.route, arguments: CheckSignsPageArgs(true));
    });
    checkAuth();
  }

  void initRepositories() {
    userRepository = UserRepository();
    signRepository = SignRepository();
    projectRepository = ProjectRepository();
    invitationRepository = InvitationRepository();
  }

  void initBlocs() {
    authenticationBloc = AuthenticationBloc(
      userRepository: userRepository,
    );
  }

  void showSuccessSnackBar(String message) {
    Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      message: message,
      icon: Icon(
        Icons.info,
        color: Colors.green,
        size: 20.0,
      ),
      duration: Duration(seconds: 2),
    ).show(context);
  }

  initDynamicLinks(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3));
    var data = await FirebaseDynamicLinks.instance.getInitialLink();
    var deepLink = data?.link;
    final queryParams = deepLink.queryParameters;
    debugPrint('test');
    showSuccessSnackBar('test');

    if (queryParams.length > 0) {
//      var userName = queryParams['userId'];
      debugPrint('has params');

      showSuccessSnackBar('has params');
      var projectId = queryParams['id'];
      print(projectId);

      showSuccessSnackBar(projectId);

      navigatorKey.currentState.pushNamed(ProjectListPage.route,
          arguments: ProjectListPageArgs(projectId as int));
    }
    FirebaseDynamicLinks.instance.onLink(onSuccess: (dynamicLink) async {
      var deepLink = dynamicLink?.link;
      debugPrint('test2');
      debugPrint('DynamicLinks onLink $deepLink');
    }, onError: (e) async {
      debugPrint('DynamicLinks onError $e');
    });

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;
      if (deepLink != null) {
        print(deepLink.queryParameters['id']); // <- prints 'abc'
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (context) => userRepository,
        ),
        RepositoryProvider<SignRepository>(
          create: (context) => signRepository,
        ),
        RepositoryProvider<ProjectRepository>(
          create: (context) => projectRepository,
        ),
        RepositoryProvider<InvitationRepository>(
          create: (context) => invitationRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              userRepository: userRepository,
            ),
          ),
        ],

        child: MaterialApp(
          builder: (context, widget) => ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, widget),
            maxWidth: 1200,
            minWidth: 450,
            defaultScale: true,
            breakpoints: [
              ResponsiveBreakpoint.autoScale(450, name: MOBILE),
              ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ],
            background: Container(
              color: Color(0xFFF5F5F5),
            ),
          ),
          title: 'Dexy',
          theme: defaultAppTheme,
          home: SplashPage(
            isLoggedIn: isLoggedIn,
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.generateRoute,
        ),
//        child: MaterialApp(
//          title: 'SignTracker',
//          theme: defaultAppTheme,
//          home: SplashPage(isLoggedIn: isLoggedIn),
//          debugShowCheckedModeBanner: false,
//          onGenerateRoute: AppRouter.generateRoute,
//          navigatorKey: navigatorKey,
//        ),
      ),
    );
  }

  @override
  void dispose() {
    authenticationBloc.close();
    super.dispose();
  }

  void checkIfFirstRun() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('first_run') ?? true) {
      FlutterSecureStorage storage = FlutterSecureStorage();

      await storage.delete(key: 'access_token');
      await storage.delete(key: 'user_name');
      await storage.deleteAll();

      prefs.setBool('first_run', false);
    }
  }
}
