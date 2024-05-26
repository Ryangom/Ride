// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ride_Driver/Models/Intercity.model.dart';
import 'package:ride_Driver/controller/rideController.dart';
import 'package:ride_Driver/controller/utilsController.dart';

import '../utility/ui_styles.dart';

class ScheduleRides extends StatefulWidget {
  const ScheduleRides({super.key});

  @override
  State<ScheduleRides> createState() => _ScheduleRidesState();
}

class _ScheduleRidesState extends State<ScheduleRides> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Intercity Rides'),
            bottom: const TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: 'Avaliable Rides',
                ),
                Tab(
                  text: 'My Rides',
                ),
              ],
            ),
          ),
          body: const Padding(
            padding: EdgeInsets.all(15.0),
            child: TabBarView(
              children: [
                AvaliablePickups(),
                MyIntercityRides(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AvaliablePickups extends StatefulWidget {
  const AvaliablePickups({super.key});

  @override
  State<AvaliablePickups> createState() => _AvaliablePickupsState();
}

class _AvaliablePickupsState extends State<AvaliablePickups> {
  RideController rideController = RideController();
  List<CarRent> avaliablePickups = [];
  UtilsController utilsController = UtilsController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAvaliablePickups();
  }

  getAvaliablePickups() async {
    var getDriverId = await utilsController.getLocalStorage('id');

    var result = await rideController.driverGetsScheduleRides();

    if (result['status'] == 'success') {
      for (var item in result['data']) {
        if (item['bided'].length > 0) {
          for (var i in item['bided']) {
            if (i['driver'].toString() != getDriverId) {
              setState(() {
                avaliablePickups.add(CarRent.fromJson(item));
              });
            }
          }
        } else {
          setState(() {
            avaliablePickups.add(CarRent.fromJson(item));
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      height: MediaQuery.of(context).size.height,
      child: avaliablePickups.length == 0
          ? Center(child: Text('No schedule rides found right now!'))
          : RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  avaliablePickups = [];
                });
                getAvaliablePickups();
              },
              child: ListView.builder(
                  itemCount: avaliablePickups.length,
                  itemBuilder: (BuildContext context, int index) {
                    return card(
                      context,
                      avaliablePickups[index].sId.toString(),
                      avaliablePickups[index].pickupLocationEn,
                      avaliablePickups[index].destinationEn,
                      avaliablePickups[index].distance,
                      avaliablePickups[index].eta,
                      avaliablePickups[index].createdAt.toString(),
                    );
                  }),
            ),
    );
  }
}

Widget card(
  BuildContext context,
  String? id,
  String? pickupLocationEn,
  String? dropLocationEn,
  String? distance,
  String? eta,
  String time,
) {
  // format time like 20-09-2021 12:00
  UtilsController utilsController = UtilsController();
  var tim = DateTime.parse(time);

  //UTC to local time
  var format = tim.toLocal();

  var date = format.toString().split(' ')[0];

  var times = format.toString().split(' ')[1].split('.')[0];

  var timeIn12Hour = utilsController.convert24To12(times);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        date + " " + timeIn12Hour.toString(),
        style: kHeadLine1(fontSize: 18.0),
      ),
      Container(
          height: 300,
          padding: EdgeInsets.all(16.0),
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color.fromARGB(255, 232, 232, 232),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 230, 230, 230),
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pickupLocationEn!,
                    overflow: TextOverflow.ellipsis,
                    style: kTextStyle2,
                  ),
                  SvgPicture.asset(
                    'assets/svgIcons/route-line.svg',
                    height: 50,
                    width: 50,
                  ),
                  Text(
                    dropLocationEn!,
                    style: kTextStyle2,
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        '${distance!} KM',
                        style: kHeadLine1(fontWeight: FontWeight.w600, fontSize: 22.0),
                      ),
                      const Text(
                        'Distance',
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        eta!,
                        style: kHeadLine1(fontWeight: FontWeight.w600, fontSize: 22.0),
                      ),
                      const Text(
                        'ETA',
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 25.0),
              // button

              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/scheduleRideDetails', arguments: id);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 170,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Color(0xFF313D7C),
                    ),
                    child: Center(
                      child: Text(
                        'See Details',
                        style: kHeadLine1(
                            fontWeight: FontWeight.w400, fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ))
    ],
  );
}

class MyIntercityRides extends StatefulWidget {
  const MyIntercityRides({super.key});

  @override
  State<MyIntercityRides> createState() => _MyIntercityRidesState();
}

class _MyIntercityRidesState extends State<MyIntercityRides> {
  RideController rideController = RideController();
  UtilsController utilsController = UtilsController();
  List<CarRent> acceptedRents = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchBookedIntercity();
  }

  fetchBookedIntercity() async {
    var getDriverId = await utilsController.getLocalStorage('id');
    var result = await rideController.driverGetsAcceptedRents(getDriverId);
    if (result['status'] == 'success') {
      print(result['data']);
      for (var item in result['data']) {
        setState(() {
          acceptedRents.add(CarRent.fromJson(item));
        });
      }
    }
  }

  remainingHours(time) {
    DateFormat inputFormat = DateFormat("dd-MM-yyyy hh:mm a");
    DateFormat outputFormat = DateFormat("yyyy-MM-dd HH:mm:ss.S");
    DateTime dateTime = inputFormat.parse(time);

    String rentTime = outputFormat.format(dateTime);

    var timeNow = DateTime.now();
    var rentTime2 = DateTime.parse(rentTime);

    var difference = rentTime2.difference(timeNow);

    if (difference.inSeconds > 0) {
      int hours = difference.inMinutes ~/ 60;
      int remainingMinutes = difference.inMinutes % 60;

      String formattedTime = '${hours}h : ${remainingMinutes.toString().padLeft(2, '0')} mins';

      return formattedTime;
    } else {
      return 'Late...!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        height: MediaQuery.of(context).size.height,
        child: RefreshIndicator(
          onRefresh: () async {
            acceptedRents = [];
            fetchBookedIntercity();
          },
          child: acceptedRents.isEmpty
              ? Center(child: Text('No data Found!'))
              : ListView.builder(
                  itemCount: acceptedRents.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      height: 340,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color.fromARGB(255, 232, 232, 232),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 230, 230, 230),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                acceptedRents[index].pickupLocationEn!,
                                overflow: TextOverflow.ellipsis,
                                style: kTextStyle2,
                              ),
                              SvgPicture.asset(
                                'assets/svgIcons/route-line.svg',
                                height: 50,
                                width: 50,
                              ),
                              Text(
                                acceptedRents[index].destinationEn!,
                                style: kTextStyle2,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'DateTime:',
                                    style:
                                        kHeadLine1(fontSize: 16.0, fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    acceptedRents[index].scheduledTime!,
                                    style:
                                        kHeadLine1(fontSize: 16.0, fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Remaining: ',
                                    style:
                                        kHeadLine1(fontSize: 16.0, fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    remainingHours(acceptedRents[index].scheduledTime),
                                    // remainingHours().toString(),
                                    style: kHeadLine1(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.red),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '${acceptedRents[index].distance} KM',
                                    style: kHeadLine1(fontWeight: FontWeight.w600, fontSize: 22.0),
                                  ),
                                  const Text(
                                    'Distance',
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    acceptedRents[index].eta!,
                                    style: kHeadLine1(fontWeight: FontWeight.w600, fontSize: 22.0),
                                  ),
                                  const Text(
                                    'ETA',
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 25.0),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/map',
                                        arguments: acceptedRents[index].sId);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 170,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      color: Color.fromARGB(255, 8, 153, 59),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Go for Pickup',
                                        style: kHeadLine1(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    LatLng pickUpLatLng = LatLng(
                                        acceptedRents[index].pickupLocationGeoCode!.coordinates![1],
                                        acceptedRents[index]
                                            .pickupLocationGeoCode!
                                            .coordinates![0]);

                                    var destinationLatLng = LatLng(
                                        acceptedRents[index].destinationGeoCode!.coordinates![1],
                                        acceptedRents[index].destinationGeoCode!.coordinates![0]);

                                    Navigator.pushNamed(context, '/rentCarInfo', arguments: {
                                      'pickUpAddress': acceptedRents[index].pickupLocationEn,
                                      'destinationAddress': acceptedRents[index].destinationEn,
                                      'scheduledTime': acceptedRents[index].scheduledTime,
                                      'pickUpLatLng': pickUpLatLng,
                                      'destinationLatLng': destinationLatLng,
                                      'eta': acceptedRents[index].eta,
                                      'distance': acceptedRents[index].distance,
                                      'price': acceptedRents[index].totalPrice,
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 170,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      color: Color(0xFF313D7C),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'See Detail',
                                        style: kHeadLine1(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
