// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_Driver/Models/Intercity.model.dart';
import 'package:ride_Driver/Models/User.model.dart';
import 'package:ride_Driver/component/button.dart';
import 'package:ride_Driver/controller/locationController.dart';
import 'package:ride_Driver/controller/rideController.dart';
import 'package:ride_Driver/controller/utilsController.dart';

import '../utility/ui_styles.dart';

class ScheduleRideDetails extends StatefulWidget {
  final String id;
  const ScheduleRideDetails({super.key, required this.id});

  @override
  State<ScheduleRideDetails> createState() => _ScheduleRideDetailsState();
}

class _ScheduleRideDetailsState extends State<ScheduleRideDetails> {
  RideController rideController = RideController();
  LocationController locationController = LocationController();
  UtilsController ut = UtilsController();
  CarRent carRent = CarRent();
  User user = User();
  bool isLoading = true;
  List<LatLng> points = [];
  LatLng pickup = const LatLng(0, 0);
  LatLng destination = const LatLng(0, 0);
  TextEditingController priceController = TextEditingController();

  Map adminShareInfo = {};

  @override
  void initState() {
    super.initState();
    getRentInfo();
    getAdminShare();
  }

  getRentInfo() async {
    var result = await rideController.driverGetRentInfo(widget.id);

    if (result['status'] == 'success') {
      setState(() {
        carRent = CarRent.fromJson(result['data']);
        user = User.fromJson(result['data']['customer']);

        pickup = LatLng(carRent.pickupLocationGeoCode!.coordinates![1],
            carRent.pickupLocationGeoCode!.coordinates![0]);
        destination = LatLng(carRent.destinationGeoCode!.coordinates![1],
            carRent.destinationGeoCode!.coordinates![0]);
      });

      var polyPoints = await locationController.getpolyFromMapbox(pickup, destination);
      setState(() {
        points = polyPoints['polylineCoordinates'];
        isLoading = false;
      });
    }
  }

  getAdminShare() async {
    var result = await rideController.getAdminShare();
    setState(() {
      adminShareInfo = result['data'];
    });
  }

  driverBid() async {
    var driverId = await ut.getLocalStorage('id');
    var body = {
      'rentId': widget.id,
      'driverId': driverId,
      'bidAmount': priceController.text,
      'commisionPercentage': adminShareInfo['commisionPercentage'].toString(),
      'taxPercentage': adminShareInfo['taxPercentage'].toString(),
      'vatPercentage': adminShareInfo['vatPercentage'].toString()
    };
    var result = await rideController.driverBidPrice(body);
    if (result['status'] == 'success') {
      Navigator.pop(context);
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      ut.showSnackBar(context, 'Bid Successful.', Colors.green);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intercity Rides Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    //map
                    Container(
                      height: 250,
                      // child: MapRouteBuilder(
                      //   pickup: pickup,
                      //   destination: destination,
                      //   points: points,
                      // ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    //details
                    userInfo(context, user: user),
                    //rent details
                    rentInfo(context, carRent: carRent),

                    //button
                    MyButton(
                        text: 'Bid Price',
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SizedBox(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: Container(
                                  height: MediaQuery.of(context).size.height / 2.5,
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Offer Your price',
                                        style: kHeadLine1(fontSize: 20.0),
                                      ),
                                      Text(
                                        textAlign: TextAlign.center,
                                        'Remember don’t offer any odd prices. \nOffer good price.',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextField(
                                        keyboardType: TextInputType.number,
                                        controller: priceController,
                                        decoration: InputDecoration(
                                          hintText: 'Enter your price',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      MyButton(
                                        text: 'Bid',
                                        onPressed: driverBid,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                  ],
                ),
        ),
      ),
    );
  }
}

Widget userInfo(BuildContext context, {required User user}) {
  return Container(
    height: 140,
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
                const CircleAvatar(radius: 40),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name.toString(),
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
                      user.mobileNumber.toString(),
                      style: kTextStyle3,
                    ),
                    Text(
                      '200 trips completed',
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
      ],
    ),
  );
}

Widget rentInfo(BuildContext context, {required CarRent carRent}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Rent info
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Car Rent Info',
              style: kHeadLine1(fontSize: 26.0),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    carRent.pickupLocationEn.toString(),
                    style:
                        TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SvgPicture.asset(
                    'assets/svgIcons/route-line.svg',
                    height: 50,
                    width: 50,
                  ),
                  Text(
                    carRent.destinationEn.toString(),
                    style:
                        TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),

        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'Schedule Date: ',
                style: kHeadLine1(fontSize: 17.0, fontWeight: FontWeight.w500)),
            TextSpan(
              text: carRent.scheduledTime.toString(),
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
          ]),
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'Total Distance: ',
              style: kHeadLine1(fontSize: 17.0, fontWeight: FontWeight.w500),
            ),
            TextSpan(
              text: '${carRent.distance} KM',
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
          ]),
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'Estimated Time: ',
              style: kHeadLine1(fontSize: 17.0, fontWeight: FontWeight.w500),
            ),
            TextSpan(
              text: carRent.eta.toString(),
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
          ]),
        ),

        SizedBox(
          height: 40,
        ),
      ],
    ),
  );
}
