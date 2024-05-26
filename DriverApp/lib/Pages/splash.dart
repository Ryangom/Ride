import 'package:flutter/material.dart';

import '../controller/utilsController.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  UtilsController utilsController = UtilsController();
  @override
  void initState() {
    super.initState();
    // wait for 3 seconds then navigate to dashboard
    utilsController.getLocalStorage('isLogin').then((value) {
      Future.delayed(const Duration(seconds: 4), () {
        if (value == 'true') {
          Navigator.pushReplacementNamed(context, '/dashboard');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset(
          'assets/DriverLogo.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
