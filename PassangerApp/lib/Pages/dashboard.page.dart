import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../component/appBar.dart';
import '../component/drawer.dart';
import '../component/historyCard.dart';
import '../controller/locationController.dart';
import '../controller/utilsController.dart';
import '../utility/ui_styles.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isLoading = true;
  LatLng _userCurentLocation = const LatLng(20.5937, 78.9629);
  final LocationController _locationController = LocationController();
  final UtilsController _utilsController = UtilsController();

  @override
  void initState() {
    super.initState();

    _utilsController.getLocalStorage('curentLoaction').then((value) => {
          print(value),
          if (value != null)
            {
              setState(() {
                _userCurentLocation = LatLng(double.parse(value.split('(')[1].split(',')[0]),
                    double.parse(value.split(',')[1].split(')')[0]));
                isLoading = false;
              })
            }
          else
            {
              _locationController.getUserCurrentLocation().then((value) => {
                    setState(() {
                      _userCurentLocation = LatLng(value.latitude, value.longitude);
                      isLoading = false;
                      _utilsController.setLocalStorage(
                          'curentLoaction', _userCurentLocation.toString());
                    })
                  })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(title: 'Dashboard'),
      drawer: CustomDrawer(),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Text('Tap back again to leave'),
          backgroundColor: Colors.red.withOpacity(0.8),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // current user location
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
                  height: MediaQuery.of(context).size.height * 0.3 + 20,
                  width: MediaQuery.of(context).size.width - 20,
                  // overflow: Overflow.visible,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Current Location', style: kHeadLine1()),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : GoogleMap(
                                  zoomControlsEnabled: false,
                                  zoomGesturesEnabled: true,
                                  circles: {
                                    Circle(
                                      circleId: const CircleId('1'),
                                      center: _userCurentLocation,
                                      radius: 80,
                                      fillColor: Colors.cyan.withOpacity(0.2),
                                      visible: true,
                                      strokeWidth: 1,
                                    )
                                  },
                                  initialCameraPosition: CameraPosition(
                                    target: _userCurentLocation,
                                    zoom: 17.00,
                                  ),
                                  markers: {
                                    Marker(
                                        markerId: const MarkerId('1'),
                                        position: _userCurentLocation,
                                        infoWindow: const InfoWindow(title: 'Marker 1'))
                                  },
                                ),
                        ),
                      ),
                    ],
                  ),
                ),

                // services list
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Services', style: kHeadLine1()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => {
                              Navigator.pushNamed(context, '/rideNow'),
                            },
                            child: SizedBox(
                              height: 120,
                              width: MediaQuery.of(context).size.width / 2 - 20,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: const Image(
                                      repeat: ImageRepeat.noRepeat,
                                      alignment: Alignment.center,
                                      fit: BoxFit.fitHeight,
                                      height: 100,
                                      image: AssetImage('assets/test.png'),
                                    ),
                                  ),
                                  const Text(
                                    'Ride Now',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/rentCar');
                            },
                            child: SizedBox(
                              height: 120,
                              width: MediaQuery.of(context).size.width / 2 - 20,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: const Image(
                                      repeat: ImageRepeat.noRepeat,
                                      alignment: Alignment.center,
                                      fit: BoxFit.cover,
                                      height: 100,
                                      image: AssetImage('assets/rent_cars.png'),
                                    ),
                                  ),
                                  const Text(
                                    'Rent a Car',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // user previous ride history

                Container(
                  margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Previous Rides', style: kHeadLine1()),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.37,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return HistoryCard(
                              id: index,
                              pickupPlace: 'Framgate, ',
                              destinationPlace: 'Gulisthan, .',
                              date: '21-09-2021',
                              fare: '100',
                            );
                          },
                        ),
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
