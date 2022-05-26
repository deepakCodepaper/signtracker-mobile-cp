import 'dart:io';

import 'package:badges/badges.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signtracker/feature/check_signs/check_signs_page.dart';
import 'package:signtracker/feature/login/login_page.dart';
import 'package:signtracker/feature/project/create/initialize_project_page.dart';
import 'package:signtracker/feature/project/list/project_list_page.dart';
import 'package:signtracker/styles/values/values.dart';
import 'package:signtracker/utilities/color_helper.dart';
import 'package:signtracker/utilities/notif_helper.dart';
import 'package:signtracker/utilities/token_helper.dart';
import 'package:signtracker/widgets/app_bar.dart';
import 'package:signtracker/widgets/menu_button.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardPage extends StatefulWidget {
  static const String route = "/dashboard";

  @override
  State<StatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 3;
  bool isNotificationON = false;
  int numberOfNotifications = 0;
  String name = '';

  bool newProjectTapped = false;
  bool openProjectTapped = false;
  bool checkSignsTapped = false;
  bool signLibraryTapped = false;
  bool helpTapped = false;
  bool notificationsTapped = false;

  @override
  void initState() {
    super.initState();
    initDynamicLinks(context);
    print(isNotificationON);
    loadNotificationState();
    getNumberOfNotif();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkIfShowTutorial();
    });
  }

  void showTutorial() {
    showDialog<dynamic>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            title: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: HexColor("#4CAF50"),
                    size: 75,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Welcome to the SignTracker',
                    style: GoogleFonts.karla(
                        color: AppColors.yellowPrimary,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            content: Container(
              height: 260,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'The only digital TAS Report generation system. \nClick Tutorials for dozens of video tutorials or click Enter to get started.',
                      style: GoogleFonts.karla(
                          fontSize: 16, fontStyle: FontStyle.normal),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 25),
                    Container(
                      height: 48,
                      width: 180,
                      child: FlatButton(
                        color: AppColors.blueDialogButton,
                        child: new Text(
                          'TUTORIALS',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          _launchURL();
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: 48,
                      width: 180,
                      child: FlatButton(
                        color: Colors.green,
                        child: new Text(
                          'ENTER',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final menuList = <Widget>[
      MenuButton(
        backgroundColor: newProjectTapped
            ? AppColors.yellowPrimary
            : AppColors.grayButtonsBackground,
        text: 'New Project',
        leading: Icon(Icons.add_circle_outline, color: Colors.black),
        onPressed: () {
          setState(() {
            newProjectTapped = true;
          });
          Navigator.pushNamed(context, InitializeProjectPage.route);
          setState(() {
            newProjectTapped = false;
          });
        },
      ),
      MenuButton(
        backgroundColor: openProjectTapped
            ? AppColors.yellowPrimary
            : AppColors.grayButtonsBackground,
        text: 'Open Project',
        leading: SvgPicture.asset(
          'assets/drawables/open-project.svg',
          fit: BoxFit.fill,
        ),
        onPressed: () => Navigator.pushNamed(context, ProjectListPage.route,
            arguments: ProjectListPageArgs(0)),
      ),
      MenuButton(
        backgroundColor: checkSignsTapped
            ? AppColors.yellowPrimary
            : AppColors.grayButtonsBackground,
        text: 'Check Signs',
        leading: Icon(Icons.flag, color: Colors.black),
        onPressed: () => Navigator.pushNamed(context, CheckSignsPage.route,
            arguments: CheckSignsPageArgs(false)),
      ),
//      MenuButton(
//        backgroundColor: signLibraryTapped
//            ? AppColors.yellowPrimary
//            : AppColors.grayButtonsBackground,
//        text: 'Sign Library',
//        leading: ImageIcon(AssetImage('assets/images/sign-library.png'),
//            color: Colors.black),
//        onPressed: () => Navigator.pushNamed(context, SignLibraryPage.route),
//      ),
      MenuButton(
        backgroundColor: helpTapped
            ? AppColors.yellowPrimary
            : AppColors.grayButtonsBackground,
        text: 'Video Tutorials',
        leading: Icon(Icons.help, color: Colors.black),
        onPressed: () => _launchURL(),
      ),
      MenuButton(
        backgroundColor: notificationsTapped
            ? AppColors.yellowPrimary
            : AppColors.grayButtonsBackground,
        text: 'Notifications',
        leading: Badge(
          showBadge: numberOfNotifications == 0 ? false : true,
          badgeColor: Colors.yellow[700],
          badgeContent: Text(
            '$numberOfNotifications',
            style: TextStyle(color: Colors.white),
          ),
          child: Icon(Icons.notifications, color: Colors.black),
        ),
        trailing: Switch(
            value: isNotificationON,
            onChanged: (bool newValue) {
              setState(() {
                isNotificationON = newValue;
                applyNotificationPermission(newValue);
              });
            }),
        onPressed: () => Navigator.pushNamed(context, CheckSignsPage.route,
            arguments: CheckSignsPageArgs(true)),
      )
    ];

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.grayBackground,
        appBar: SignTrackerAppBar.createAppBar(context, 'My Dashboard'),
        body: Container(
          child: Column(children: <Widget>[
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 20, 0),
                        child: RichText(
                          text: TextSpan(
                            text: "Hello ",
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      '${name != null ? name.toUpperCase() : ''},',
                                  style: GoogleFonts.karla(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 20, 0),
                        child: Text(
                          'Let\'s get started!',
                          style: GoogleFonts.montserrat(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 0),
            Flexible(
              child: ListView.builder(
                //Creating a ListView builder and sending the data set in menuList to create a list
                padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                // Giving space from top
                itemCount: menuList.length,
                itemBuilder: (context, index) => menuList[index],
              ),
            ),
          ]),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.yellowPrimary,
          selectedItemColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: onTabTapped,
          // new
          currentIndex: _currentIndex,
          // new
          items: [
            new BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.black,
              ),
              label: 'New',
            ),
            new BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/drawables/open-project.svg',
                fit: BoxFit.fill,
              ),
              label: 'Open',
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.flag, color: Colors.black),
              label: 'Check',
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black),
              label: 'Home',
            )
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, InitializeProjectPage.route);
        break;
      case 1:
        Navigator.pushNamed(context, ProjectListPage.route,
            arguments: ProjectListPageArgs(0));
        break;
      case 2:
        Navigator.pushNamed(context, CheckSignsPage.route,
            arguments: CheckSignsPageArgs(false));
        break;
    }
  }

  _launchURL() async {
    const url = 'http://admin.thesigntracker.com/tutorials';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void setMenuData() {}

  void onPressNotif() {}

  void onPressProfile() {}

  void onPressMenu() {}

  Future<bool> _onWillPop() {
    if (Platform.isAndroid) {
      return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit from SignTracker'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('No'),
                ),
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }
  }

  applyNotificationPermission(bool newValue) async {
    if (newValue == true) {
      bool result =
          await OneSignal.shared.promptUserForPushNotificationPermission();
      if (result ?? true) {
        OneSignal.shared.disablePush(true);
        print('subscription true');
      } else {
        print('subscription false');
        OneSignal.shared.disablePush(false);
      }
    } else {
      print('subscription false');
      OneSignal.shared.disablePush(false);
    }
  }

  void loadNotificationState() {
    OneSignal.shared.getDeviceState().then((onValue) {
      setState(() {
        //isNotificationON = onValue.subscriptionStatus.userSubscriptionSetting;
        isNotificationON = onValue.hasNotificationPermission;
      });
    });
  }

  Future<String> getNumberOfNotif() async {
    name = await TokenHelper().getName();
    if (name == null) {
      Navigator.pushReplacementNamed(
        context,
        LoginPage.route,
      );
    }
    final notifNumber = await NotifHelper().getNotifNumber();
    numberOfNotifications = notifNumber ?? int.parse(notifNumber);
    return notifNumber;
  }

  initDynamicLinks(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3));
    var data = await FirebaseDynamicLinks.instance.getInitialLink();
    var deepLink = data?.link;
    print("LNK 000 -- " + deepLink.toString());
    final queryParams = deepLink.queryParameters;
    debugPrint('test');

    if (queryParams.length > 0) {
//      var userName = queryParams['userId'];
      debugPrint('has params');

      var projectId = queryParams['id'];
      print(projectId);

      Navigator.pushNamed(context, ProjectListPage.route,
          arguments: ProjectListPageArgs(projectId as int));
    }
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLink) async {
      var deepLink = dynamicLink?.link;
      print("LNK 00000 -- " + deepLink.toString());
      debugPrint('test2');
      debugPrint('DynamicLinks onLink $deepLink');
      Navigator.pushNamed(context, ProjectListPage.route,
          arguments: ProjectListPageArgs(0));
    }, onError: (e) async {
      debugPrint('DynamicLinks onError $e');
    });

    FirebaseDynamicLinks.instance.onLink.listen((PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;
      print("LNK 0000011 -- " + deepLink.toString());
      if (deepLink != null) {
        print(deepLink.queryParameters['id']); // <- prints 'abc'
        Navigator.pushNamed(context, ProjectListPage.route,
            arguments:
                ProjectListPageArgs(deepLink.queryParameters['id'] as int));
      }
    }, onError: (e) async {
      print('onLinkError');
      print(e.message);
    });
  }

  Future<void> checkIfShowTutorial() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('first_login') ?? true) {
      showTutorial();
      prefs.setBool('first_login', false);
    }
  }
}

class NextPage extends StatelessWidget {
  NextPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
    );
  }
}
