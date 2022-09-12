import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signtracker/feature/dashboard/dashboard_page.dart';
import 'package:signtracker/feature/landing/landing_page.dart';
import 'package:signtracker/feature/login/login_page.dart';

class SplashPageArgs {
  const SplashPageArgs(this.isLoggedIn);

  final bool isLoggedIn;
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key key, @required this.isLoggedIn}) : super(key: key);

  static const String route = '/splash';
  final bool isLoggedIn;

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          SvgPicture.asset(
            'assets/drawables/landing1.svg',
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
          ),
          SvgPicture.asset(
            'assets/drawables/landing2.svg',
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
          ),
          SvgPicture.asset(
            'assets/drawables/landing3.svg',
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: SvgPicture.asset('assets/drawables/logo.svg'),
          ),
          Positioned(
            top: 120,
            right: -40,
            child: Image.asset('assets/drawables/banner_img.png'),
          ),
          Positioned(
            top: 200,
            left: 70,
            width: 180,
            child: Text(
              'Creating TAS\nrecords just\ngot easier',
              style: GoogleFonts.karla(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w100,
                  fontStyle: FontStyle.normal),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 100,
            right: 100,
            child: Center(child: CircularProgressIndicator()),
          )
        ],
      ),
    );
  }

  onDoneLoading() async {
    Navigator.pushReplacementNamed(
      context,
      widget.isLoggedIn ? DashboardPage.route : LandingPage.route,
    );
  }
}
