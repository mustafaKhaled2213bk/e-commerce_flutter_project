import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends ChangeNotifier {
  bool isLoggedIn = false;
  login() async {
    isLoggedIn = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
    notifyListeners();
  }

  LoginNotifier() {
    getLoginState();
  }
  logout() async {
    isLoggedIn = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    prefs.remove('userData');
    notifyListeners();
  }

  Future<void> getLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    notifyListeners();
  }

  setUser(String userName, String email, String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('userData', [userName, email, address]);
    notifyListeners();
  }

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = prefs.getStringList('userData');
    return userData;
  }
}
