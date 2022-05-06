import 'package:flutter/material.dart';

class TextManager {
  static TextTheme get textStyle => const TextTheme(
        headline1: TextStyle(
          fontSize: 19,
          height: 1,
          fontWeight: FontWeight.w600,
        ),
        headline2: TextStyle(
          fontSize: 17,
          height: 1.4,
          fontWeight: FontWeight.w600,
        ),
        subtitle1: TextStyle(
          fontSize: 16,
          height: 1.3,
          fontWeight: FontWeight.w600,
        ),
        subtitle2: TextStyle(
          fontSize: 14,
          height: 1.45,
          fontWeight: FontWeight.w600,
        ),
        bodyText1: TextStyle(
          fontSize: 15,
          height: 1.4,
          fontWeight: FontWeight.w400,
        ),
        bodyText2: TextStyle(
          fontSize: 14,
          height: 1.4,
          fontWeight: FontWeight.w400,
        ),
        overline: TextStyle(
          fontSize: 11,
          height: 1.4,
          fontWeight: FontWeight.w400,
        ),
      );
}
