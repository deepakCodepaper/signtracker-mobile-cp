import 'package:flutter/material.dart';
import 'package:signtracker/styles/values/values.dart';

final defaultAppTheme = ThemeData(
  buttonTheme: ButtonThemeData(focusColor: Colors.blueGrey),
  primarySwatch: Colors.yellow,
  primaryColor: AppColors.yellowPrimary,
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 72.0,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontSize: 36.0,
      fontStyle: FontStyle.italic,
    ),
    bodyText1: TextStyle(
      fontSize: 14.0,
    ),
    bodyText2: TextStyle(
      color: Colors.blueAccent,
    ),
  ),
);
