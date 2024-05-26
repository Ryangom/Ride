import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_user/component/button.dart';
import 'package:ride_user/component/mapRouteBuilder.dart';
import 'package:ride_user/controller/locationController.dart';
import 'package:ride_user/utility/ui_styles.dart';

class RentCarInfo extends StatefulWidget {
  final Map<String, dynamic> data;

  RentCarInfo({
    super.key,
    required this.data,
  });

  @override
  State<RentCarInfo> createState() => _RentCarInfoState();
}

class _RentCarInfoState extends State<RentCarInfo> {
  bool _isLoading = true;
  LocationController _locationController = LocationController();

  Map<String, dynamic> _locationDatas = {};

  @override
  void initState() {
    super.initState();

    LatLng _pickup = widget.data['pickUpLatLng'] as LatLng;
    LatLng _destination = widget.data['destinationLatLng'] as LatLng;

    _locationController
        .getpolyFromMapbox(_pickup, _destination)
        .then((value) => {
              _locationDatas = value,
              setState(() {
                _isLoading = false;
              })
            })
        .catchError((e) {
      SnackBar(content: Text('Something went wrong'));
      setState(() {
        _isLoading = false;
      });
      return e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // map
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      ),
                      child: MapRouteBuilder(
                          pickup: widget.data['pickUpLatLng'] as LatLng,
                          destination: widget.data['destinationLatLng'] as LatLng,
                          points: _locationDatas['polylineCoordinates']),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Rent info
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Car Rent Info',
                                style: kHeadLine1(fontSize: 32.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.data['pickUpAddress'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SvgPicture.asset(
                                      'assets/Dashboard/route-line.svg',
                                      height: 50,
                                      width: 50,
                                    ),
                                    Text(
                                      widget.data['destinationAddress'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
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
                                  style: kHeadLine1(fontSize: 18.0, fontWeight: FontWeight.w500)),
                              TextSpan(
                                text: widget.data['scheduleDate'],
                                style: TextStyle(color: Colors.black, fontSize: 16),
                              ),
                            ]),
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Total Distance: ',
                                style: kHeadLine1(fontSize: 18.0, fontWeight: FontWeight.w500),
                              ),
                              TextSpan(
                                text: _locationDatas['distance'],
                                style: TextStyle(color: Colors.black, fontSize: 16),
                              ),
                            ]),
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Estimated Time: ',
                                style: kHeadLine1(fontSize: 18.0, fontWeight: FontWeight.w500),
                              ),
                              TextSpan(
                                text: _locationDatas['duration'],
                                style: TextStyle(color: Colors.black, fontSize: 16),
                              ),
                            ]),
                          ),

                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                    Center(
                        child: MyButton(
                            text: 'Confirm',
                            onPressed: () {
                              Navigator.pushNamed(context, '/driverBidded');
                            }))
                  ],
                ),
        ),
      ),
    );
  }
}
