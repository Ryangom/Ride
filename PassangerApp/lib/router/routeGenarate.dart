import 'package:flutter/material.dart';
import 'package:ride_user/Pages/RideHistoryDetails.page.dart';
import 'package:ride_user/Pages/authPages/loginPage.dart';
import 'package:ride_user/Pages/dashboard.page.dart';
import 'package:ride_user/Pages/driverAcceptUserReq.dart';
import 'package:ride_user/Pages/driverBidded.dart';
import 'package:ride_user/Pages/driverBiddedInfo.dart';
import 'package:ride_user/Pages/profile.page.dart';
import 'package:ride_user/Pages/rentCar.page.dart';
import 'package:ride_user/Pages/rentCarInfo.dart';
import 'package:ride_user/Pages/rideHistory.page.dart';
import 'package:ride_user/Pages/rideNow.page.dart';
import 'package:ride_user/Pages/userSearchRiderLoading.page.dart';
import 'package:ride_user/utility/location_picker.dart';

import '../Pages/driverOnTheWay.dart';
import '../Pages/splash.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Splash());

      case '/dashboard':
        return MaterialPageRoute(builder: (_) => const Dashboard());

      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case '/profile':
        return MaterialPageRoute(builder: (_) => const Profile());

      case '/rideHistory':
        return MaterialPageRoute(builder: (_) => const RideHistory());

      case '/rideHistoryDetails':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => RideHistoryDetails(
              rideId: args,
            ),
          );
        }
        return _errorRoute();

      case '/rideNow':
        return MaterialPageRoute(builder: (_) => const RideNow());

      case '/rentCar':
        return MaterialPageRoute(builder: (_) => const RentCar());
      case '/rentCarInfo':
        return MaterialPageRoute(builder: (_) => RentCarInfo(data: args as Map<String, dynamic>));

      case '/userSearchRiderLoading':
        return MaterialPageRoute(builder: (_) => const UserSearchRiderLoading());

      case '/driverAccepteReq':
        return MaterialPageRoute(builder: (_) => const DriverAcceptReq());

      case '/driverOnTheWay':
        return MaterialPageRoute(builder: (_) => const DriverOnTheWay());

      case '/driverBidded':
        return MaterialPageRoute(builder: (_) => const DriverBidded());
      case '/driverBiddedInfo':
        return MaterialPageRoute(
            builder: (_) => DriverBiddedInfo(
                  rideId: args as String,
                ));

      case '/pickLocation':
        return MaterialPageRoute(builder: (_) => const LocationPickerScreen());

      case '/second':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => const Profile(
                // data: args,
                ),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

//404 page
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
