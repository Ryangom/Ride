import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var baseUrl = 'http://192.168.0.200:5000';

class AuthController {
  Future login(payload) async {
    var url = Uri.parse(baseUrl + '/login');
    var response = await http.post(url, body: payload);
    var data = json.decode(response.body);
    return data;
  }

  Future register(user) async {
    var url = Uri.parse(baseUrl + '/register');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(headers: headers, url, body: jsonEncode(user));
    var data = json.decode(response.body);
    return data;
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
