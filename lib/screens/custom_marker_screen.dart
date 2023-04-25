import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarker extends StatefulWidget {
  const CustomMarker({super.key});

  @override
  State<CustomMarker> createState() => _CustomMarkerState();
}

class _CustomMarkerState extends State<CustomMarker> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<String> images = [
    'assets/images.bike.png',
    'assets/images.car.png',
    'assets/images.marker.png',
  ];
  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latLng = <LatLng>[
    const LatLng(33.6941, 72.9734),
    const LatLng(33.7008, 72.9682),
    const LatLng(33.6992, 72.9744)
  ];
  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(33.6910, 72.98072),zoom: 14);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          }),
    ));
  }
}
