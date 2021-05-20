import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signtracker/styles/values/values.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    @required this.text,
    this.leading,
    this.trailing,
    @required this.onPressed,
    this.isNotification,
    this.backgroundColor,
  });

  final String text;
  final Widget leading;
  final Widget trailing;
  final VoidCallback onPressed;
  final bool isNotification;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Here in the list view I have used first a Container instead of directly using ListTile
      margin:
          EdgeInsets.fromLTRB(20, 10, 20, 10), // Giving space from left side
      decoration: new BoxDecoration(
        //Box  Decoration is user to customise the look we want for each cell
        color: backgroundColor,
//        borderRadius: new BorderRadius.only(
//          //This is where we are creating the semi circle on left side by using radius.
//          topLeft: const Radius.circular(30.0),
//          bottomLeft: const Radius.circular(30.0),
//          topRight: const Radius.circular(0.0),
//        ),
      ),
      child: ListTile(
        //adding the list tile to show icon and name and get on tap gesture
        title: new Text(text,
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 17, color: Colors.black),
                fontWeight: FontWeight.w700)),
        leading: leading,
        trailing: trailing,
        onTap: onPressed,
      ),
    );
  }
}
