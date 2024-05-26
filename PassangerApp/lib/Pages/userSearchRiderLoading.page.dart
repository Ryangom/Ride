// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ride_user/controller/locationController.dart';

import '../component/button.dart';

class UserSearchRiderLoading extends StatefulWidget {
  final pickUpAddress;
  final destinationAddress;
  final pickUpLatLng;
  final destinationLatLng;
  const UserSearchRiderLoading({
    super.key,
    this.pickUpAddress,
    this.destinationAddress,
    this.pickUpLatLng,
    this.destinationLatLng,
  });

  @override
  State<UserSearchRiderLoading> createState() => _UserSearchRiderLoadingState();
}

class _UserSearchRiderLoadingState extends State<UserSearchRiderLoading> {
  LocationController locationController = LocationController();
  List data = [];
  @override
  void initState() {
    super.initState();
    checkForDrivers();
  }

  void checkForDrivers() async {
    // make a interval of 5 seconds
    // Timer.periodic(Duration(seconds: 5), (timer) async {
    //   if (data.length > 0) {
    //     timer.cancel();
    //     // Navigator.popAndPushNamed(context, '/driverAccepteReq');
    //   } else {}
    // });
    Duration duration = Duration(seconds: 10);
    Timer(duration, () {
      Navigator.popAndPushNamed(context, '/driverAccepteReq');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/animations/searchingDriver.json', width: 200),
                const Text(
                  'Searching for drivers...',
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 140,
                ),
                MyButton(
                  text: 'Cancel',
                  onPressed: () => {Navigator.pop(context)},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
