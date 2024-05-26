// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ride_user/Pages/driverBiddedInfo.dart';
import 'package:ride_user/utility/ui_styles.dart';

class DriverBidded extends StatefulWidget {
  const DriverBidded({super.key});

  @override
  State<DriverBidded> createState() => _DriverBiddedState();
}

class _DriverBiddedState extends State<DriverBidded> {
  String time = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rent Informations'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      // drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rent info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'From: Dhaka, bangladesh ',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SvgPicture.asset(
                              'assets/Dashboard/route-line.svg',
                              height: 50,
                              width: 50,
                            ),
                            Text(
                              'To: Dhaka, bangladesh',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  CustomText('Schedule Date:', ' 19-09-2021'),
                  CustomText('Total Distance:', ' 10km'),
                  CustomText('Estimated Time:', ' 10min'),
                ],
              ),
            ),

            //Timer
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       'Timer',
            //       style: kHeadLine1(),
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Countdown(
            //           seconds: 10,
            //           build: (BuildContext context, double time) => Text(
            //             //seconds to menutes and seconds
            //             (time ~/ 60).toString() + 'min :' + (time % 60).toInt().toString() + 's',

            //             style: kHeadLine1(),
            //           ),
            //           interval: Duration(seconds: 1),
            //           onFinished: () {
            //             // setState(() {
            //             //   Navigator.popAndPushNamed(context, '/dashboard');
            //             // });
            //           },
            //         ),
            //         Image.asset(
            //           'assets/DriverBidded/DriverBidded.png',
            //           scale: 1,
            //         ),
            //       ],
            //     )
            //   ],
            // ),
            //Driver Bidded List
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Driver bidded',
                    style: kHeadLine1(),
                  ),

                  // ignore: sized_box_for_whitespace
                  Container(
                    height: MediaQuery.of(context).size.height - 330,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return DriverBiddedList(id: index.toString());
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DriverBiddedList extends StatefulWidget {
  String id;
  DriverBiddedList({super.key, required this.id});

  @override
  State<DriverBiddedList> createState() => _DriverBiddedListState();
}

class _DriverBiddedListState extends State<DriverBiddedList> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DriverBiddedInfo(
              rideId: widget.id,
            ),
          ),
        );
      },
      child: Container(
        height: 200,
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  '৳20000',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget CustomText(
  String text,
  String secondText,
) {
  return RichText(
    text: TextSpan(children: [
      TextSpan(text: text, style: kHeadLine1(fontSize: 17.0, fontWeight: FontWeight.w500)),
      TextSpan(
        text: secondText,
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    ]),
  );
}
