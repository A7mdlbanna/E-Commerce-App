import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightMode = ThemeData(
  primaryColor: Color(0xFFF9F8F4),

  scaffoldBackgroundColor:  Color(0xFFF9F8F4),
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor:  Color(0xFFF9F8F4),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      unselectedIconTheme:
      IconThemeData(color: Colors.grey.shade700)),
  textTheme: TextTheme(
    headline1: const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headline2: TextStyle(
      color: Colors.grey.shade800,
      fontSize: 14,
    ),
    bodyText1: const TextStyle(
      fontSize: 14.0,
      color: Colors.black,
    ),
    bodyText2: TextStyle(
      fontSize: 14.0,
      color: Colors.grey.shade700,
    ),
    headline3: TextStyle(
      fontSize: 16.0,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  ),
);