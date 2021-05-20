import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatefulWidget {
  static const String route = '/help';

  @override
  State<StatefulWidget> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: CircularProgressIndicator(),
          ),
          SizedBox(height: 50),
          Text(
            'Please wait while we\nredirect you to the website',
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 15, color: Colors.white)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
