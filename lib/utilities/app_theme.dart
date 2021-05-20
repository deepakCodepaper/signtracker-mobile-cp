import 'package:flutter/material.dart';
import 'package:signtracker/styles/values/values.dart';

final defaultAppTheme = ThemeData(
  buttonTheme: ButtonThemeData(focusColor: Colors.blueGrey),
  primarySwatch: Colors.yellow,
  primaryColor: AppColors.yellowPrimary,
  textTheme: TextTheme(
    headline: TextStyle(
      fontSize: 72.0,
      fontWeight: FontWeight.bold,
    ),
    title: TextStyle(
      fontSize: 36.0,
      fontStyle: FontStyle.italic,
    ),
    body1: TextStyle(
      fontSize: 14.0,
    ),
    body2: TextStyle(
      color: Colors.blueAccent,
    ),
  ),
);
