import 'dart:convert';

import 'package:http/http.dart' as http;

var baseUrl = 'http://192.168.0.200:5000';

class RideController {
  Future driverGetsScheduleRides() async {
    var url = Uri.parse('http://192.168.0.200:5000/driverFindRents');
    var response = await http.get(url);
    var data = json.decode(response.body);
    return data;
  }

  Future driverGetsAcceptedRents(String driverId) async {
    var url = Uri.parse('http://192.168.0.200:5000/driverFindAcceptedRents/$driverId');
    var response = await http.get(url);
    var data = json.decode(response.body);
    return data;
  }

  Future driverGetRentInfo(String id) async {
    var url = Uri.parse('http://192.168.0.200:5000/driverGetRentInfo/$id');
    var response = await http.get(url);
    var data = json.decode(response.body);
    return data;
  }

  Future driverBidPrice(body) async {
    var url = Uri.parse('http://192.168.0.200:5000/driverBidonRent');
    var response = await http.post(url, body: body);
    var data = json.decode(response.body);
    return data;
  }

  Future getDriverStats(String id) async {
    var url = Uri.parse('http://192.168.0.200:5000/api/driver/driverStats/$id');
    var response = await http.get(url);
    var data = json.decode(response.body);
    return data;
  }

  Future driverCompleteIntercityRide(String id) async {
    var url = Uri.parse('http://192.168.0.200:5000/api/driver/driverCompleteIntercityRide/$id');
    var response = await http.post(url);
    var data = json.decode(response.body);
    return data;
  }

  Future getAdminShare() async {
    var url = Uri.parse('http://192.168.0.200:5000/api/user/userGetAdminShareInfo');
    var response = await http.get(url);
    var data = json.decode(response.body);
    return data;
  }

  Future userGetRideInfo(rideId, rideType) async {
    var url = Uri.parse('http://192.168.0.200:5000/api/user/userGetRideInfo/$rideId/$rideType');
    var response = await http.get(url);
    var data = json.decode(response.body);
    return data;
  }
}
