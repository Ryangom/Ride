// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ride_user/component/button.dart';
import 'package:ride_user/component/drawer.dart';
import 'package:ride_user/controller/locationController.dart';

import '../component/appBar.dart';
import '../utility/location_picker.dart';
import '../utility/ui_styles.dart';

class RentCar extends StatefulWidget {
  const RentCar({super.key});

  @override
  State<RentCar> createState() => _RentCarState();
}

class _RentCarState extends State<RentCar> {
  String pickUpAddress = '';
  String destinationAddress = '';
  LatLng pickUpLatLng = const LatLng(0.0, 0.0);
  LatLng destinationLatLng = const LatLng(0.0, 0.0);
  String pickUpDateTime = '';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Rent Car',
      ),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // booking area
                Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  height: 450,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Bidding',
                        style: kHeadLine1(fontSize: 28.0),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Pickup Location',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
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
                                    Text(
                                      pickUpAddress == ''
                                          ? 'Pick location from map'
                                          : pickUpAddress,
                                      style:
                                          kHeadLine1(fontSize: 16.0, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _navigateToLocationPicker().then((value) {
                                    setState(() {
                                      pickUpAddress = value['address'];
                                      pickUpLatLng = value['latlng'];
                                    });
                                  });
                                },
                                child: Icon(
                                  Icons.my_location_rounded,
                                  size: 30,
                                  color: Colors.blue.shade500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.flag,
                                color: Colors.green,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Destination',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
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
                                    Text(
                                      destinationAddress == ''
                                          ? 'Pick location from map'
                                          : destinationAddress,
                                      style:
                                          kHeadLine1(fontSize: 16.0, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _navigateToLocationPicker().then((value) {
                                    setState(() {
                                      destinationAddress = value['address'];
                                      destinationLatLng = value['latlng'];
                                    });
                                  });
                                },
                                child: Icon(
                                  Icons.my_location_rounded,
                                  size: 30,
                                  color: Colors.blue.shade500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.date_range,
                                color: Colors.indigo,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Select Pickup Date And Time',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
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
                                    Text(
                                      pickUpDateTime,
                                      style:
                                          kHeadLine1(fontSize: 16.0, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // add cupertino date picker here
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) => SizedBox(
                                            height: 300,
                                            child: CupertinoDatePicker(
                                                // initialDateTime: DateTime.now(),
                                                minimumDate: DateTime.now(),
                                                maximumDate: DateTime.now().add(const Duration(
                                                    days: 30)), // add 30 days from now
                                                mode: CupertinoDatePickerMode.dateAndTime,
                                                onDateTimeChanged: (DateTime newDate) {
                                                  // 12-12-2021 12:12:12 AM format
                                                  setState(() {
                                                    pickUpDateTime =
                                                        DateFormat('dd-MM-yyyy hh:mm a')
                                                            .format(newDate)
                                                            .toString();
                                                  });
                                                }),
                                          ));
                                },
                                child: Icon(
                                  Icons.date_range_rounded,
                                  size: 30,
                                  color: Colors.blue.shade500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          MyButton(
                              text: 'Next',
                              onPressed: () {
                                // check if all fields are filled
                                // if (pickUpAddress == '' ||
                                //     destinationAddress == '' ||
                                //     pickUpDateTime == '') {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(
                                //       backgroundColor: Colors.red,
                                //       content: Text(
                                //         'Please fill all fields',
                                //         style: TextStyle(fontSize: 18),
                                //       ),
                                //     ),
                                //   );
                                //   return;
                                // }

                                Navigator.pushNamed(context, '/rentCarInfo', arguments: {
                                  'pickUpAddress': pickUpAddress,
                                  'destinationAddress': destinationAddress,
                                  'pickUpDateTime': pickUpDateTime,
                                  'pickUpLatLng': pickUpLatLng,
                                  'destinationLatLng': destinationLatLng,
                                  'scheduleDate': pickUpDateTime,
                                });
                              })
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
