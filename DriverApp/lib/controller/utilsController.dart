import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UtilsController {
  void setLocalStorage(String name, payload) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(name, payload);
  }

  getLocalStorage(name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final payload = prefs.getString(name);
    return payload;
  }

  void removeLocalStorage(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(name);
  }

  showSnackBar(BuildContext context, String message, Color bgColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor,
      ),
    );
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final payload = prefs.getString('token');
    return payload;
  }

  convert24To12(String time) {
    var hour = time.split(':')[0];
    var min = time.split(':')[1];
    var ampm = 'AM';
    if (int.parse(hour) > 12) {
      hour = (int.parse(hour) - 12).toString();
      ampm = 'PM';
    }
    return '$hour:$min $ampm';
  }
}
