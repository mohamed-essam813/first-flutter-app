import 'package:flutter/material.dart';
import 'theme.dart';

class ThemeProvider extends ChangeNotifier {
  // initially, theme is light mode
  ThemeData _themeData = lightMode;

  // getter method to access the theme from other parts of the code
  ThemeData get themeData => _themeData;

  // getter method to see if we are in dark mode or not
  bool get isDarkMode => _themeData == darkMode;

  // setter method to set the new theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // we will use this toggle method to switch between light and dark mode
  void toggleTheme() {
    _themeData = isDarkMode ? lightMode : darkMode;
    notifyListeners();
  }
}