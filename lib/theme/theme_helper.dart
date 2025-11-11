import 'package:flutter/material.dart';

String _appTheme = "lightCode";
LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

class ThemeHelper {
  final Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors(),
  };

  final Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme,
  };

  void changeTheme(String newTheme) {
    _appTheme = newTheme;
  }

  LightCodeColors _getThemeColors() =>
      _supportedCustomColor[_appTheme] ?? LightCodeColors();

  ThemeData _getThemeData() {
    var colorScheme = _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(visualDensity: VisualDensity.standard, colorScheme: colorScheme);
  }

  LightCodeColors themeColor() => _getThemeColors();
  ThemeData themeData() => _getThemeData();
}

class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light();
}

class LightCodeColors {
  Color get gray_600 => const Color(0xFF828282);
  Color get gray_100 => const Color(0xFFF5F5F5);
  Color get black_900 => const Color(0xFF000000);
  Color get gray_900 => const Color(0xFF1E1E1E);
  Color get green_50 => const Color(0xFFE3FADE);
  Color get amber_A200 => const Color(0xFFFCD53F);
  Color get indigo_100_91 => const Color(0x91B4B9EC);
  Color get blue_gray_100 => const Color(0xFFD9D9D9);
  Color get gray_900_01 => const Color(0xFF1D1B20);
  Color get white_A700 => const Color(0xFFFFFFFF);
  Color get transparentCustom => Colors.transparent;
  Color get color3F0000 => const Color(0x3F000000);
}
