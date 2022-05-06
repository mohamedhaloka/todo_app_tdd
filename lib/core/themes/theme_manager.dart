import 'package:flutter/material.dart';
import 'package:todo_app_tdd/core/themes/text_manager.dart';
import 'colors_manager.dart';

class ThemeManager {
  static ThemeData get theme => ThemeData(
        primaryColor: ColorManager.blue,
        primaryColorLight: const Color(0xFFffffff),
        brightness: Brightness.light,
        fontFamily: 'Rubik',
        scaffoldBackgroundColor: Colors.grey[50],
        platform: TargetPlatform.iOS,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: false,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            iconTheme: IconThemeData(
              size: 30,
              color: Colors.white,
            )),
        iconTheme: const IconThemeData(
          size: 30,
          color: ColorManager.lightGrey,
        ),
        textTheme: TextManager.textStyle,
      );

  static ThemeData get darkTheme => ThemeData(
        primaryColor: ColorManager.blue,
        primaryColorLight: const Color(0xff323232),
        brightness: Brightness.dark,
        fontFamily: 'Rubik',
        platform: TargetPlatform.iOS,
        appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff323232),
            elevation: 0.0,
            centerTitle: false,
            titleTextStyle: TextStyle(
              color: Color(0xff323232),
              fontSize: 18,
            ),
            iconTheme: IconThemeData(
              size: 30,
              color: Color(0xff323232),
            )),
        iconTheme: const IconThemeData(
          size: 30,
          color: ColorManager.lightGrey,
        ),
        textTheme: TextManager.textStyle,
      );

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}
