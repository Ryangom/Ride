import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var baseUrl = 'http://192.168.0.200:5000/api/auth';

class AuthController {
  Future login(payload) async {
    var url = Uri.parse(baseUrl + '/login');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(url, headers: headers, body: jsonEncode(payload));
    var data = json.decode(response.body);
    return data;
  }

  Future driverRegister(user, File vehiclePic, File nID, File license, File registration) async {
    var url = Uri.parse('$baseUrl/driverRegister');
    var request = http.MultipartRequest('POST', url);

    request.fields['user'] = json.encode(user.toJson());

    request.files.add(await http.MultipartFile.fromPath('nID', nID.path));
    request.files.add(await http.MultipartFile.fromPath('vehicle_pic', vehiclePic.path));
    request.files.add(await http.MultipartFile.fromPath('driving_license', license.path));
    request.files.add(await http.MultipartFile.fromPath('vehicle_registration', registration.path));

    try {
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseString);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonResponse;
      } else {
        throw Exception('Failed to upload images');
      }
    } catch (e) {
      throw Exception('Server Error');
    }
  }

  Future forgetPassEmail(payload) async {
    var url = Uri.parse(baseUrl + '/login');
    var response = await http.post(url, body: payload);
    var data = json.decode(response.body);
    return data;
  }

  Future matchOTP(payload) async {
    var url = Uri.parse(baseUrl + '/login');
    var response = await http.post(url, body: payload);
    var data = json.decode(response.body);
    return data;
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
