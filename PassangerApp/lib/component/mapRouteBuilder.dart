import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapRouteBuilder extends StatefulWidget {
  final LatLng pickup;
  final LatLng destination;
  final List<LatLng> points;
  MapRouteBuilder({
    super.key,
    required this.pickup,
    required this.destination,
    required this.points,
  });

  @override
  State<MapRouteBuilder> createState() => _MapRouteBuilderState();
}

class _MapRouteBuilderState extends State<MapRouteBuilder> {
  final Set<Marker> markers = {};
  final Set<Polyline> polyline = {};

  @override
  void initState() {
    super.initState();
    makeRoute();
  }

  void makeRoute() {
    polyline.add(Polyline(
      polylineId: PolylineId('route1'),
      color: Colors.red,
      width: 3,
      points: widget.points,
    ));

    markers.add(Marker(
      markerId: MarkerId('pickup'),
      position: widget.pickup,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ));
    markers.add(Marker(
      markerId: MarkerId('destination'),
      position: widget.destination,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ));
  }

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GoogleMap(
          zoomControlsEnabled: false,
          markers: markers,
          initialCameraPosition: CameraPosition(target: widget.pickup, zoom: 12.5),
          mapType: MapType.normal,
          polylines: polyline,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          }),
    );
  }
}
