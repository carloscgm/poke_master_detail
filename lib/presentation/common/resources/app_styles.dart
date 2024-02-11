import 'package:flutter/material.dart';
import 'package:poke_master_detail/model/pokemon.dart';
import 'package:poke_master_detail/presentation/common/resources/app_colors.dart';

class AppStyles {
  // App Theme
  static ThemeData appTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    useMaterial3: true,
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

  static BoxDecoration getBackground(Pokemon pokemon) {
    if (pokemon.types.length == 2) {
      return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColors.getColorType(pokemon.types.first.type.name),
              AppColors.getColorType(pokemon.types[1].type.name),
            ]),
      );
    } else {
      return BoxDecoration(
        color: AppColors.getColorType(pokemon.types.first.type.name),
      );
    }
  }
}
