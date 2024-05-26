// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_user/component/mapRouteBuilder.dart';
import 'package:ride_user/utility/ui_styles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/locationController.dart';

class DriverAcceptReq extends StatefulWidget {
  const DriverAcceptReq({super.key});

  @override
  State<DriverAcceptReq> createState() => _DriverAcceptReqState();
}

class _DriverAcceptReqState extends State<DriverAcceptReq> {
  LocationController locationController = LocationController();
  Map data = {};
  bool userAcceptRide = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationController
        .getpolyFromMapbox(LatLng(23.662054146069945, 90.09469393087565),
            LatLng(23.656433068468537, 90.11838320014645))
        .then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: data.length == 0
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    DriverInfo(),
                    SizedBox(
                      height: 10,
                    ),
                    // map container
                    Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 10,
                              ),
                            ]),
                        child: MapRouteBuilder(
                            pickup: LatLng(0.0, 0.0), destination: LatLng(0.0, 0.0), points: [])),

                    SizedBox(
                      height: 10,
                    ),
                    // Driver away from user
                    Text(data['distance'] + ' km away from you',
                        style: kHeadLine1(fontSize: 18.0, fontWeight: FontWeight.normal)),
                    Text('Estimated arrival time: ' + data['duration'],
                        style: kHeadLine1(fontSize: 18.0, fontWeight: FontWeight.normal)),
                    SizedBox(
                      height: 20,
                    ),
                    // Accept and Reject button
                    userAcceptRide
                        ? Center(
                            child: Column(
                              children: [
                                Text(
                                  'Waiting For Pickup!',
                                  style: kHeadLine1(),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                //btn
                                Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red,
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) => SizedBox(
                                          height: 250,
                                          child: Padding(
                                            padding: const EdgeInsets.all(13.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Are you sure you want to \ncancel  the ride?',
                                                  style: kHeadLine1(),
                                                ),
                                                Text(
                                                  'By canceling a Ride, it will cost you 1 star point',
                                                  style: kHeadLine1(
                                                      fontSize: 16.0,
                                                      fontWeight: FontWeight.normal),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Container(
                                                      height: 50,
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Colors.red,
                                                      ),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text(
                                                          'No',
                                                          style: kHeadLine1(
                                                            color: Colors.white,
                                                            fontSize: 20.0,
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 50,
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Colors.green,
                                                      ),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text(
                                                          'Yes',
                                                          style: kHeadLine1(
                                                            color: Colors.white,
                                                            fontSize: 20.0,
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Cancel Ride',
                                      style: kHeadLine1(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, '/rideNow', (route) => false);
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: kHeadLine1(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    // Navigator.pushNamed(context, '/driverOnTheWay');
                                    setState(() {
                                      userAcceptRide = true;
                                    });
                                    Duration duration = Duration(seconds: 5);
                                    Future.delayed(duration, () {
                                      Navigator.pushNamed(context, '/driverOnTheWay');
                                    });
                                  },
                                  child: Text(
                                    'Accept',
                                    style: kHeadLine1(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
        ),
      ),
    ));
  }
}

class DriverInfo extends StatefulWidget {
  const DriverInfo({super.key});

  @override
  State<DriverInfo> createState() => _DriverInfoState();
}

class _DriverInfoState extends State<DriverInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xff02ADAB),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: 10,
            ),
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage('assets/DriverBidded/DriverBidded.png'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ryan Gomes',
                      style: kHeadLine1(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '⭐⭐⭐⭐',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '01791705555',
                      style: kTextStyle3,
                    ),
                    Text(
                      '12 trips completed',
                      style: kTextStyle3,
                    ),
                    Text(
                      'Member since 2021',
                      style: kTextStyle3,
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  final Uri phoneLaunchUri = Uri(
                    scheme: 'tel',
                    path: '01791705555',
                  );

                  if (await canLaunchUrl(phoneLaunchUri)) {
                    await launchUrl(phoneLaunchUri);
                  }
                },
                icon: Icon(
                  Icons.phone,
                  color: Colors.white,
                  size: 30,
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vehicle Information',
                    style: kHeadLine1(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Name: Honda Civic',
                    style: kTextStyle3,
                  ),
                  Text(
                    'Color: Black',
                    style: kTextStyle3,
                  ),
                  Text(
                    'Plate: Dhaka Metro Ga 11-1111',
                    style: kTextStyle3,
                  ),
                  Text(
                    'Model: 2019',
                    style: kTextStyle3,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
