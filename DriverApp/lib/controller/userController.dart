import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../Models/User.model.dart';

var baseUrl = 'http://192.168.0.200:5000/api/user';

class UserController {
  Future userGetProfile(String id) async {
    // var url = Uri.parse(baseUrl + '/login');
    var url = Uri.parse('$baseUrl/getUserProfile/$id');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);
    var data = json.decode(response.body);
    return data;
  }

  Future userUpdateProfile(User user, File image) async {
    var url = Uri.parse(baseUrl + '/api/user/upload');
    var request = http.MultipartRequest('POST', url);

    request.fields['user'] = json.encode(user.toJson());

    if (image.path != '') {
      request.files.add(await http.MultipartFile.fromPath('profile_pic', image.path));
    }

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

  Future userGetRideHistory() async {
    // var url = Uri.parse(baseUrl + '/login');
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);
    var data = json.decode(response.body);
    return data;
  }

  Future test() async {
    // var url = Uri.parse(baseUrl + '/login');
    var url = Uri.parse('http://192.168.0.200:5000/api/admin/adminGetsAllUser/user');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);
    var data = json.decode(response.body);
    return data;
  }
}
