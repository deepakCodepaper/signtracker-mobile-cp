import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signtracker/feature/login/login_page.dart';
import 'package:signtracker/feature/register/register_page.dart';
import 'package:signtracker/widgets/rounded_button.dart';

class LandingPage extends StatelessWidget {
  static const String route = '/landing-page';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
          Container(
            child: Column(
              children: [
                Spacer(),
                RoundedButton(
                  padding: EdgeInsets.symmetric(horizontal: 80.0),
                  height: 50.0,
                  radius: 5.0,
                  onPressed: () =>
                      Navigator.pushNamed(context, LoginPage.route),
                  text: 'Sign in with Email',
                  textColor: Colors.black,
                  textSize: 20.0,
                  borderColor: Colors.orange,
                  borderWidth: 2.0,
                  color: Colors.white,
                  elevation: 0.0,
//                textColor: Colors.white,
//                fontWeight: FontWeight.bold,
//                textSize: 16.0,
//                textAlign: null,
//                borderColor: Colors.white,
//                borderWidth: 2.0,
//                color: Colors.transparent,
//                elevation: 0.0,
                  leading: Icon(
                    Icons.email,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'or'.toUpperCase(),
                  style: GoogleFonts.karla(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal),
                ),
//              SizedBox(height: 10),
//              RoundedButton(
//                padding: EdgeInsets.symmetric(horizontal: 40.0),
//                height: 50.0,
//                radius: 5.0,
//                onPressed: () {},
//                text: 'Sign in with Google',
//                textColor: Colors.black,
//                textSize: 16.0,
//                textAlign: null,
//                borderColor: Colors.orange,
//                borderWidth: 2.0,
//                color: Colors.white,
//                elevation: 0.0,
//                leading: SvgPicture.asset('assets/drawables/google.svg'),
//              ),
//              SizedBox(height: 10),
//              RoundedButton(
//                padding: EdgeInsets.symmetric(horizontal: 40.0),
//                height: 50.0,
//                radius: 5.0,
//                onPressed: () {},
//                text: 'Sign in with Facebook',
//                textColor: Colors.black,
//                textSize: 16.0,
//                textAlign: null,
//                borderColor: Colors.orange,
//                borderWidth: 2.0,
//                color: Colors.white,
//                elevation: 0.0,
//                leading: Row(
//                  children: [
//                    SvgPicture.asset('assets/drawables/facebook.svg'),
//                    SizedBox(width: 5),
//                  ],
//                ),
//              ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, RegisterPage.route),
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                        'Don\'t have an account?',
                        style: GoogleFonts.karla(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.normal),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Sign Up',
                        style: GoogleFonts.karla(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.normal),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
