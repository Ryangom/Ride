// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utility/ui_styles.dart';

class RideHistoryDetails extends StatefulWidget {
  final String rideId;
  const RideHistoryDetails({
    super.key,
    required this.rideId,
  });

  @override
  State<RideHistoryDetails> createState() => _RideHistoryDetailsState();
}

class _RideHistoryDetailsState extends State<RideHistoryDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.rideId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ride History Details'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Column(
              children: [
                //Map container
                Container(
                  height: 250,
                  color: Colors.blue,
                  child: Center(
                    child: Text('Map'),
                  ),
                ),
                //ride details 1 point to another infos
                Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('10/2/2023  3:23pm'),
                        SizedBox(
                          height: 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Framgate, dhaka 1340',
                                style: kTextStyle2,
                              ),
                              SvgPicture.asset(
                                'assets/svgIcons/route-line.svg',
                                height: 50,
                                width: 50,
                              ),
                              Text(
                                'Gulisthan, Dhaka 1206',
                                style: kTextStyle2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                //Driver info, car and rating
                Divider(
                  height: 1.2,
                  color: Colors.grey,
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Driver',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontFamily: GoogleFonts.poppins().fontFamily,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text('Ryan Gomes',
                                      style: TextStyle(
                                        fontFamily: GoogleFonts.poppins().fontFamily,
                                        fontSize: 16,
                                      )),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Honda Civic',
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontFamily: GoogleFonts.poppins().fontFamily,
                                        fontSize: 15,
                                      )),
                                  Text('KAA-4589 Black',
                                      style: TextStyle(
                                        fontFamily: GoogleFonts.poppins().fontFamily,
                                        fontSize: 16,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        height: 50,
                        width: MediaQuery.of(context).size.width - 80,
                        // color: Colors.grey[100],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Your Rating'),
                            Text('⭐⭐⭐⭐ (4.0)'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 0.5,
                  color: Colors.grey,
                  // thickness: 1,
                ),

                //payment method or payment info
                Container(
                  height: 200,
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fare Details',
                        style: kHeadLine1(fontSize: 17.0),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Base Fare'),
                          Text('৳ 300.00'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Vat & Tax'),
                          Text('৳ 90.00'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Other Charges'),
                          Text('৳ 50.00'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: kHeadLine1(fontSize: 18.0),
                          ),
                          Text(
                            '৳ 440.00',
                            style: kHeadLine1(fontSize: 18.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
