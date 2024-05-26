import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_user/component/mapRouteBuilder.dart';

import '../utility/ui_styles.dart';

class DriverBiddedInfo extends StatefulWidget {
  String rideId;
  DriverBiddedInfo({super.key, required this.rideId});

  @override
  State<DriverBiddedInfo> createState() => _DriverBiddedInfoState();
}

class _DriverBiddedInfoState extends State<DriverBiddedInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Driver Details'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // Card
              Container(
                height: 300,
                margin: const EdgeInsets.only(bottom: 12),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage('assets/DriverBidded/DriverBidded.png'),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ryan Gomes',
                                  style: TextStyle(
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    fontSize: 23,
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                Text(
                                  '⭐⭐⭐⭐⭐',
                                  style: kTextStyle2,
                                ),
                                Text(
                                  '01791676868',
                                  style: kTextStyle3,
                                ),
                                Text(
                                  '200 trips completed',
                                  style: kTextStyle3,
                                ),
                                Text(
                                  '(Honda Civic 2019)',
                                  style: kTextStyle3,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 350,
                            ),
                            Icon(
                              Icons.call,
                              color: Colors.white,
                              size: 35,
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vehicle Info:',
                              style: kHeadLine1(fontSize: 23.0, color: Colors.white),
                            ),
                            Text(
                              'Name: Honda Civic 2019',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Registration: 2020',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Plate: DHK-1234',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Color: Black',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Offered Price',
                              style: kHeadLine1(fontSize: 23.0, color: Colors.white),
                            ),
                            Text('৳10000', style: kHeadLine1(fontSize: 32.0, color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //Route Map
              Container(
                height: 300,
                child: MapRouteBuilder(
                  pickup: LatLng(0.0, 0.0),
                  destination: LatLng(0.0, 0.0),
                  points: [],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //Button Group
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => {Navigator.pop(context)},
                    child: Text('Back'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: TextStyle(fontSize: 20),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Accept'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
