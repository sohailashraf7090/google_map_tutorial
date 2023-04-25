import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(30.80291813741266, 73.45882695366647), zoom: 14.4746);
  @override
  final List<Marker> _marker = [];
  final List<Marker> _markerList = [
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(30.80291813741266, 73.45882695366647),
        infoWindow: InfoWindow(title: 'This is My current Position')),
    const Marker(
        markerId: MarkerId('2'),
        position: LatLng(30.79962142013043, 73.45648655956228),
        infoWindow: InfoWindow(title: 'Davoo Bus')),
    const Marker(
        markerId: MarkerId('3'),
        position: LatLng(30.80508549072157, 73.45086056429354),
        infoWindow: InfoWindow(title: 'samad pura road')),
    const Marker(
        markerId: MarkerId('4'),
        position: LatLng(20.5937, 78.9629),
        infoWindow: InfoWindow(title: 'India Country'))
  ];
  @override
  void initState() {
    super.initState();
    _marker.addAll(_markerList);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          compassEnabled: false,
          mapType: MapType.hybrid,
          myLocationButtonEnabled: true,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set<Marker>.of(_marker),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.location_disabled_outlined),
          onPressed: () async {
            GoogleMapController controller = await _controller.future;
            controller.animateCamera(
                CameraUpdate.newCameraPosition(const CameraPosition(
              target: LatLng(30.80291813741266, 73.45882695366647),
              zoom: 14,
            )));
          },
        ),
      ),
    );
  }
}
