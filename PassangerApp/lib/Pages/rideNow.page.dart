// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_user/component/button.dart';
import 'package:ride_user/component/drawer.dart';
import 'package:ride_user/component/mapRouteBuilder.dart';
import 'package:ride_user/controller/locationController.dart';

import '../component/appBar.dart';
import '../utility/location_picker.dart';
import '../utility/ui_styles.dart';

class RideNow extends StatefulWidget {
  const RideNow({super.key});

  @override
  State<RideNow> createState() => _RideNowState();
}

class _RideNowState extends State<RideNow> {
  String pickUpAddress = '';
  String destinationAddress = '';
  LatLng pickUpLatLng = const LatLng(0.0, 0.0);
  LatLng destinationLatLng = const LatLng(0.0, 0.0);

  List<LatLng> points = [];
  String totalDistance = '';
  String totalDuration = '';
  String ETA = '';
  String fair = '';

  bool isMapDataLoaded = false;
  Uint8List picupMarker = Uint8List(0);
  Uint8List destinationMarker = Uint8List(0);
  LocationController locationController = LocationController();

  @override
  void initState() {
    super.initState();
  }

  _navigateToLocationPicker() async {
    Map<String, dynamic> result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LocationPickerScreen(),
        ));
    return result;
  }

  void checkPickandDestinonLatLng() {
    if (pickUpLatLng == LatLng(0.0, 0.0) || destinationLatLng == LatLng(0.0, 0.0)) {
      debugPrint('Pickup and Destination is null');
    } else {
      locationController.getpolyFromMapbox(pickUpLatLng, destinationLatLng).then((value) {
        if (value != null) {
          setState(() {
            points = value['polylineCoordinates'];
            totalDistance = value['distance'].toString();
            totalDuration = value['duration'].toString();
            ETA = value['ETA'].toString();
            isMapDataLoaded = true;
          });
        } else {
          debugPrint('Value is null');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Ride Now',
      ),
      drawer: CustomDrawer(),
      body: Scaffold(
        body: Center(
          child: Column(
            // ignore: duplicate_ignore
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: 370,
                height: 290,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Where to Go?',
                        style: kHeadLine1(fontSize: 28.0),
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        _label(
                          'Pickup Location',
                          Icons.location_on,
                          Colors.red,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _field(
                          pickUpAddress == '' ? 'Pick location from map' : pickUpAddress,
                          () {
                            _navigateToLocationPicker().then((value) {
                              setState(() {
                                pickUpAddress = value['address'];
                                pickUpLatLng = value['latlng'];
                              });
                              checkPickandDestinonLatLng();
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _label(
                          'Destination Location',
                          Icons.flag,
                          Colors.green,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _field(
                          destinationAddress == '' ? 'Pick location from map' : destinationAddress,
                          () {
                            _navigateToLocationPicker().then((value) {
                              setState(() {
                                destinationAddress = value['address'];
                                destinationLatLng = value['latlng'];
                              });
                              checkPickandDestinonLatLng();
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                  text: 'test',
                  onPressed: () {
                    Navigator.pushNamed(context, '/userSearchRiderLoading');
                  }),
              isMapDataLoaded == false
                  ? Container()
                  : Column(
                      children: [
                        Container(
                          height: 260,
                          width: 370,
                          child: MapRouteBuilder(
                            pickup: pickUpLatLng,
                            destination: destinationLatLng,
                            points: points,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Distance: $totalDistance km',
                                        style: kHeadLine1(
                                            fontSize: 16.0, fontWeight: FontWeight.w600)),
                                    Text('ETA: $totalDuration',
                                        style: kHeadLine1(
                                            fontSize: 16.0, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                Text('10000 BDT', style: kHeadLine1(fontSize: 26.0))
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyButton(
                            text: 'Continue',
                            onPressed: () {
                              Navigator.pushNamed(context, '/userSearchRiderLoading');
                            }),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _label(
  String label,
  IconData icon,
  Color iconColor,
) {
  return Row(
    children: [
      Icon(
        icon,
        color: iconColor,
      ),
      const SizedBox(
        width: 5,
      ),
      Text(
        label,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w800,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
      ),
    ],
  );
}

Widget _field(
  String placeholder,
  void Function() onTap,
) {
  return Row(
    children: [
      Container(
        width: 290,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                placeholder,
                style: kHeadLine1(fontSize: 16.0, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        width: 5,
      ),
      GestureDetector(
        onTap: onTap,
        child: Icon(
          Icons.my_location_rounded,
          size: 30,
          color: Colors.blue.shade500,
        ),
      ),
    ],
  );
}
