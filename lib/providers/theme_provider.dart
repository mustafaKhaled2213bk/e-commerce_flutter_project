import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  
  static const THEME_STATUS = "THEME_STATUS";
  bool _darkTheme = false;
  bool get getIsDarkTheme => _darkTheme;
  late Icon buttonIcon;
  ThemeProvider() {
    getTheme();
  }
  Future<void> setDarkTheme({required bool themeValue}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, themeValue);
    _darkTheme = themeValue;
    if (_darkTheme) {
      buttonIcon = const Icon(Icons.light_mode_outlined);
    } else {
      buttonIcon = const Icon(Icons.dark_mode_outlined);
    }
    notifyListeners();
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _darkTheme = prefs.getBool(THEME_STATUS) ?? false;

    if (_darkTheme) {
      buttonIcon = const Icon(Icons.light_mode_outlined);
    } else {
      buttonIcon = const Icon(Icons.dark_mode_outlined);
    }

    notifyListeners();
    return _darkTheme;
  }
}
