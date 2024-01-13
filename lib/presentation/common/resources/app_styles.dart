import 'package:flutter/material.dart';

class AppStyles {
  // App Theme
  static ThemeData appTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    useMaterial3: true,
  ).copyWith(
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontSize: 15, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 13, color: Colors.black),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static ThemeData appDarkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    useMaterial3: true,
  ).copyWith(
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontSize: 15, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 13, color: Colors.black),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  // Text Styles
  static const TextStyle smallTextStyle = TextStyle(fontSize: 14);
  static const TextStyle bigTextStyle = TextStyle(fontSize: 18);
  static const TextStyle extraBigTextStyle = TextStyle(fontSize: 22);
}
