import 'package:flutter/material.dart';
import '../core/app_export.dart';

class TextStyleHelper {
  static TextStyleHelper? _instance;
  TextStyleHelper._();
  static TextStyleHelper get instance {
    _instance ??= TextStyleHelper._();
    return _instance!;
  }

  TextStyle get display40BoldInter => TextStyle(
        fontSize: 40.fSize,
        fontWeight: FontWeight.w700,
        fontFamily: 'Inter',
        color: appTheme.black_900,
      );

  TextStyle get headline25BoldInter => TextStyle(
        fontSize: 25.fSize,
        fontWeight: FontWeight.w700,
        fontFamily: 'Inter',
        color: appTheme.black_900,
      );

  TextStyle get title22BoldInter => TextStyle(
        fontSize: 22.fSize,
        fontWeight: FontWeight.w700,
        fontFamily: 'Inter',
        color: appTheme.black_900,
      );

  TextStyle get title20RegularRoboto => TextStyle(
        fontSize: 20.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      );

  TextStyle get title16RegularInter => TextStyle(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
      );
}
