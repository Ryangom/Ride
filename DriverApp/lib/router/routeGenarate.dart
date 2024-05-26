import 'package:flutter/material.dart';
import 'package:ride_Driver/Pages/authPages/signUpPage.dart';
import 'package:ride_Driver/Pages/authPages/signupFileUploades.dart';
import 'package:ride_Driver/Pages/history.dart';
import 'package:ride_Driver/Pages/map.dart';

import '../Models/User.model.dart';
import '../Pages/InterCityRideDetails.dart';
import '../Pages/InterCityRides.dart';
import '../Pages/RideAcceptedInfo.dart';
import '../Pages/RideHistoryDetails.page.dart';
import '../Pages/Riderequest.dart';
import '../Pages/authPages/loginPage.dart';
import '../Pages/dashboard.page.dart';
import '../Pages/profile.page.dart';
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
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUpPage());

      case '/signupFileUploades':
        return MaterialPageRoute(
            builder: (_) => SignupFileUploades(
                  user: args as User,
                ));

      case '/history':
        return MaterialPageRoute(builder: (_) => const History());
      case '/scheduleRides':
        return MaterialPageRoute(builder: (_) => const ScheduleRides());

      case '/rentCarInfo':
        return MaterialPageRoute(
            builder: (_) => RideAcceptedInfo(data: args as Map<String, dynamic>));

      case '/scheduleRideDetails':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => ScheduleRideDetails(
              id: args,
            ),
          );
        }
        return _errorRoute();

      case '/rideRequests':
        return MaterialPageRoute(builder: (_) => const RideRequests());
      case '/rideHistoryDetails':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => RideHistoryDetails(
              rideId: args,
            ),
          );
        }
        return _errorRoute();
      case '/map':
        return MaterialPageRoute(
            builder: (_) => MyMap(
                  id: args,
                ));
      case '/profile':
        return MaterialPageRoute(builder: (_) => const Profile());
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
