import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

var baseUrl = 'https://jsonplaceholder.typicode.com';

class LocationController {
  Future getUserCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();

    if (!serviceEnabled) {
      serviceEnabled = await Geolocator.openLocationSettings();
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future getDistanceBetweenTwoPoints(
      double startLatitude, double startLongitude, double endLatitude, double endLongitude) async {
    // return Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
    return Geolocator.distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
  }

  // estimatedTime Haversine formula
  Future getEstimatedTime(
      double startLatitude, double startLongitude, double endLatitude, double endLongitude) async {
    var distance =
        await getDistanceBetweenTwoPoints(startLatitude, startLongitude, endLatitude, endLongitude);
    var estimatedTime = distance / 60;
    return estimatedTime;
  }

// Total Fare Estimate: Distance Charge(km) + Time Charge + admin charge
// fare = (distance * 15tk) + (estimatedTime * 0.5tk) + 50
  getFair(double distance, double estimatedTime) {
    double fair = (distance * 15) + (estimatedTime * 0.5);
    fair = fair + (fair * 10) / 100; // 10% admin charge
    return fair;
  }

  Future getpolyFromMapbox(LatLng orgin, LatLng dest) async {
    List<LatLng> polylineCoordinates = [];
    var orginLng = orgin.longitude;
    var orginLat = orgin.latitude;
    var destLng = dest.longitude;
    var destLat = dest.latitude;

    //get api here
    var url = Uri.parse(
        'https://api.mapbox.com/directions/v5/mapbox/driving/$orginLng%2C$orginLat%3B$destLng%2C$destLat?alternatives=true&geometries=geojson&language=en&overview=simplified&steps=true&access_token=pk.eyJ1IjoibWFwYm94NzcxMSIsImEiOiJjbGd1a2plMzMwbTEzM3NvNXd6cWZwa2d6In0.s1fiha82GmzYRHT8_zgYsw');
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    var geometry = data['routes'][0]['geometry']['coordinates'];
    var distanceInMeter = data['routes'][0]['distance'];
    var duration = data['routes'][0]['duration'];

    var fullMinutes = (duration / 60);
    var extraSeconds = (fullMinutes - fullMinutes.toInt()) * 60;
    var minutes = fullMinutes.toInt();
    var seconds = extraSeconds.toInt();
    var distance = (distanceInMeter / 1000).toStringAsFixed(2);

    for (int i = 0; i < geometry.length; i++) {
      polylineCoordinates.add(LatLng(geometry[i][1], geometry[i][0]));
    }
    return {
      'polylineCoordinates': polylineCoordinates,
      'distance': distance,
      'duration': '$minutes min $seconds sec'
    };
  }
}
