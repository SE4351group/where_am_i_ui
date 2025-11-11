import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // Default theme colors
  Color _selectedColor = Colors.white;
  Color get selectedColor => _selectedColor;

  // Automatically calculate contrasting text colors
  Color get textColor {
    Brightness brightness = ThemeData.estimateBrightnessForColor(_selectedColor);
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  // Change theme
  void updateTheme(Color newColor) {
    _selectedColor = newColor;
    notifyListeners(); // Refresh all screens
  }
}
