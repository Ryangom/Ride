import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../component/mapRouteBuilder.dart';
import '../controller/locationController.dart';
import '../utility/ui_styles.dart';

class RideAcceptedInfo extends StatefulWidget {
  final Map<String, dynamic> data;

  const RideAcceptedInfo({
    super.key,
    required this.data,
  });

  @override
  State<RideAcceptedInfo> createState() => _RentCarAcceptedInfoState();
}

class _RentCarAcceptedInfoState extends State<RideAcceptedInfo> {
  bool _isLoading = false;
  LatLng _pickup = const LatLng(0, 0);
  LatLng _destination = const LatLng(0, 0);
  Map<String, dynamic> _locationDatas = {};

  String userId = '';

  final LocationController _locationController = LocationController();

  @override
  void initState() {
    super.initState();

    _pickup = widget.data['pickUpLatLng'] as LatLng;
    _destination = widget.data['destinationLatLng'] as LatLng;
    getRoutes();
  }

  @override
  void dispose() {
    super.dispose();
    _destination = const LatLng(0, 0);
    _pickup = const LatLng(0, 0);
    _locationDatas = {};
  }

  getRoutes() async {
    setState(() {
      _isLoading = true;
    });

    _locationDatas = await _locationController.getpolyFromMapbox(_pickup, _destination);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
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
                            pickup: widget.data['pickUpLatLng'],
                            destination: widget.data['destinationLatLng'],
                            points: _locationDatas['polylineCoordinates']),
                      ),
                      const SizedBox(
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
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SvgPicture.asset(
                                        'assets/svgIcons/route-line.svg',
                                        height: 50,
                                        width: 50,
                                      ),
                                      Text(
                                        widget.data['destinationAddress'],
                                        style: const TextStyle(
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
                                  text: widget.data['scheduledTime'],
                                  style: const TextStyle(color: Colors.black, fontSize: 16),
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
                                  text: widget.data['distance'] != null
                                      ? widget.data['distance'] + ' km'
                                      : '0' + ' km',
                                  style: const TextStyle(color: Colors.black, fontSize: 16),
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
                                  text: widget.data['eta'] ?? '0' + ' min',
                                  style: const TextStyle(color: Colors.black, fontSize: 16),
                                ),
                              ]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'Total Cost: ',
                                  style: kHeadLine1(fontSize: 20.0, fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: widget.data['price'] + ' BDT' ?? '0 BDT',
                                  style: const TextStyle(color: Colors.black, fontSize: 18),
                                ),
                              ]),
                            ),
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
