import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class NetworkProvider {
  // var baseUrl = 'http://192.168.0.200:5000/api';
  var baseUrl = '';

// Get Method

  Future<dynamic> get(String url) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString('token');

    var uri = Uri.parse(baseUrl + url);

    // var header = {'Authorization': 'Bearer $token'};
    var header = {
      'Authorization': 'Bearer akjdka',
      'Content-Type': 'application/json'
    };

    var response = await http.get(uri, headers: header);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
      // return response.body;
    } else {
      return response;
    }
  }

//Post method
  Future<dynamic> post(String url, dynamic payload) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString('token');

    var uri = Uri.parse(baseUrl + url);
    var _payload = jsonEncode(payload);
    var header = {
      'Authorization': 'Bearer sdfsdf',
      'Content-Type': 'application/json'
    };

    var response = await http.post(uri, body: _payload, headers: header);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  Future<dynamic> postWithQueryParams(String url, Map<String, dynamic> data,
      Map<String, dynamic> queryParams) async {
    // Create a Uri by adding the query parameters to the provided URL
    final uri = Uri.parse(url).replace(queryParameters: queryParams);

    try {
      final response = await http.post(uri, body: data);

      return response;
    } catch (e) {
      throw Exception('Failed to load $uri: ${e.toString()}');
    }
  }

  Future<dynamic> postImages(String url, File image1) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl + url));

    // Add the first image to the request
    var pic1 = await http.MultipartFile.fromPath('profile_pic', image1.path);
    request.files.add(pic1);

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
      print('Error: $e');
      throw Exception('Failed to upload images: $e');
    }
  }
}
