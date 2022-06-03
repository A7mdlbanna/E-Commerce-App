import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkMode =   ThemeData(
  primaryColor:
  Color(0xFF000000),
  // Color(0xFF0E122F),
  scaffoldBackgroundColor:
  Color(0xFF000000),
  // Color(0xFF0E122F),
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Color(0xFF020315),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF080E21),
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      unselectedLabelStyle: TextStyle(color: Color(0xFF080E21))),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline2: TextStyle(
      color: Colors.grey,
      fontSize: 14,
    ),
    bodyText1: TextStyle(
      fontSize: 14.0,
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      color: Colors.grey,
      fontSize: 14,
    ),
    headline3: TextStyle(
      fontSize: 16.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
);