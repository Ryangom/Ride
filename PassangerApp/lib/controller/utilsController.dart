import 'package:shared_preferences/shared_preferences.dart';

class UtilsController {
  void setLocalStorage(String name, payload) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(name, payload);
  }

  getLocalStorage(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final payload = prefs.getString(name);
    return payload;
  }
}
