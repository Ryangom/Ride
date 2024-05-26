import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_Driver/utility/ui_styles.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  LatLng currentLocation = const LatLng(23.6850, 90.3563);
  LatLng _selectedPosition = const LatLng(23.6850, 90.3563);
  LatLng cameraPosition = const LatLng(23.6850, 90.3563);
  String address = '';

  Uint8List bytes = Uint8List(0);

  @override
  void initState() {
    super.initState();
    test();
  }

  Future test() async {
    bytes = (await getBytesFromAsset(path: 'assets/auth/location-pin.png', width: 120))!;
    setState(() {});
  }

  Future<Uint8List?> getBytesFromAsset({required String path, required int width}) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  // @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select Location'),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            bytes.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: cameraPosition, // San Francisco
                      zoom: 12,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('selected-location'),
                        position: _selectedPosition,
                        draggable: true,
                        icon: BitmapDescriptor.fromBytes(bytes),
                        onDragEnd: (newPosition) async {
                          setState(() {
                            _selectedPosition = newPosition;
                          });
                          List<Placemark> placemarks = await placemarkFromCoordinates(
                              _selectedPosition.latitude, _selectedPosition.longitude);
                          Placemark place = placemarks[0];

                          setState(() {
                            address = "${place.street},${place.locality}";
                          });
                        },
                      ),
                    },
                  ),
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    address,
                    style: kHeadLine1(fontWeight: FontWeight.normal, fontSize: 16.0),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              left: 70,
              right: 80,
              child: address == ''
                  ? Container()
                  : ElevatedButton(
                      onPressed: () async {
                        var data = {'latlng': _selectedPosition, 'address': address};
                        Navigator.of(context).pop(data);
                      },
                      child: const Text('Select Location', style: TextStyle(fontSize: 18)),
                    ),
            ),
          ],
        ));
  }
}
