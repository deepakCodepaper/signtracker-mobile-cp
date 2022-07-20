import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signtracker/feature/landing/landing_page.dart';
import 'package:signtracker/styles/values/values.dart';
import 'package:signtracker/utilities/token_helper.dart';

class SignTrackerAppBar {
  static AppBar createAppBar(BuildContext context, String title) {
    return AppBar(
      leading: title == 'My Dashboard' ? null : BackButton(color: Colors.black),
      backgroundColor: Colors.white,
      title: Text(title ?? "",
          style: GoogleFonts.montserrat(
              color: Colors.black, fontWeight: FontWeight.w700)),
      centerTitle: false,
      actions: <Widget>[
        IconButton(
          onPressed: () => showLogout(context),
          icon: Icon(Icons.account_circle, color: AppColors.yellowPrimary),
        )
      ],
    );
  }

  // user defined function
  static showLogout(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            'LOGOUT',
            style: GoogleFonts.karla(color: Colors.black, fontSize: 12),
          ),
          content: new Text("Logout from SignTracker?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Logout",
                  style: GoogleFonts.karla(color: Colors.black)),
              onPressed: () {
                final tokenHelper = TokenHelper();
                tokenHelper.deleteToken();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LandingPage.route, (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
