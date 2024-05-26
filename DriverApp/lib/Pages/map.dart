// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_Driver/controller/locationController.dart';
import 'package:ride_Driver/controller/rideController.dart';
import 'package:ride_Driver/utility/ui_styles.dart';

import '../component/button.dart';

class MyMap extends StatefulWidget {
  final id;
  const MyMap({super.key, this.id});

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  LatLng startPoint = const LatLng(0, 0);
  LatLng destination = const LatLng(23.653661748855953, 90.13245943369773);
  List<LatLng> points = [];
  bool isLoading = false;
  bool isDropoff = false;

  LocationController locationController = LocationController();
  RideController rideController = RideController();
  Map carRent = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getLocation();
    getRideInfo();
  }

  // getLocation() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   // current location of driver
  //   var driverLocation = await locationController.getUserCurrentLocation();
  //   setState(() {
  //     startPoint = LatLng(driverLocation.latitude, driverLocation.longitude);
  //   });
  //   var polyCoordinates = await locationController.getpolyFromMapbox(startPoint, destination);

  //   setState(() {
  //     isLoading = false;
  //     points = polyCoordinates['polylineCoordinates'];
  //   });
  // }

  getRideInfo() async {
    // get ride info from server
    var result = await rideController.userGetRideInfo(widget.id, 'intercity');
    if (result['status'] == 'success') {
      setState(() {
        carRent = result['data'];
      });
    }
  }

  pickUp() async {
    //set pickup point and destination point
    setState(() {
      isLoading = true;
      startPoint = LatLng(23.653661748855953, 90.13245943369773); // majirkanda
      destination = LatLng(23.6604621869569, 90.15696409452914); // cha bari
    });

    var polyCoordinates = await locationController.getpolyFromMapbox(startPoint, destination);

    setState(() {
      isLoading = false;
      points = polyCoordinates['polylineCoordinates'];
      isDropoff = true;
    });
  }

  dropOf() async {
    var result = await rideController.driverCompleteIntercityRide(widget.id);
    if (result['status'] == 'success') {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Stack(
                    children: [
                      // MapRouteBuilder(
                      //   pickup: startPoint,
                      //   destination: destination,
                      //   points: points,
                      //   mylocation: true,
                      // ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        right: 10,
                        child: Container(
                          height: 200,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              interCityRideInfo(
                                pickup: carRent['pickupLocationEn'],
                                destination: carRent['destinationEn'],
                                eta: carRent['eta'],
                                fair: carRent['totalPrice'],
                              ),
                              Center(
                                child: isDropoff
                                    ? MyButton(text: 'Drop Off', onPressed: dropOf)
                                    : MyButton(text: 'Pick Up', onPressed: pickUp),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

Widget interCityRideInfo({
  required String pickup,
  required String destination,
  required String eta,
  required String fair,
}) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pickup: $pickup',
                style: kHeadLine1(fontSize: 17.0, fontWeight: FontWeight.normal),
              ),
              Text(
                'Destination: $destination',
                style: kHeadLine1(fontSize: 17.0, fontWeight: FontWeight.normal),
              ),
              Text(
                'Eta: $eta',
                style: kHeadLine1(fontSize: 17.0, fontWeight: FontWeight.normal),
              ),
              Text(
                'Fair: $fair BDT',
                style: kHeadLine1(fontSize: 19.0),
              )
            ],
          ),
        ],
      ));
}
