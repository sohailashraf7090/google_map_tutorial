import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomInfoWindowMarker extends StatefulWidget {
  const CustomInfoWindowMarker({super.key});

  @override
  State<CustomInfoWindowMarker> createState() => _CustomInfoWindowMarkerState();
}

class _CustomInfoWindowMarkerState extends State<CustomInfoWindowMarker> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latLng = <LatLng>[
    const LatLng(33.6941, 72.9734),
    const LatLng(33.7008, 72.9682),
    const LatLng(33.6992, 72.9744),
    const LatLng(33.6939, 72.9771),
    const LatLng(33.6910, 72.9807),
    const LatLng(33.7036, 72.9785)
  ];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    for (int i = 0; i < _latLng.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        icon: BitmapDescriptor.defaultMarker,
        position: _latLng[i],
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
              Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 300,
                      width: 100,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/bike.png"),
                              fit: BoxFit.fitWidth,
                              filterQuality: FilterQuality.high),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ],
                ),
              ),
              _latLng[i]);
        },
      ));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Marker"),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(
                  33.6941,
                  72.9734,
                ),
                zoom: 14,
              ),
              markers: Set.of(_markers),
              onMapCreated: (GoogleMapController controller) {
                _customInfoWindowController.googleMapController = controller;
              },
              onTap: (position) {
                _customInfoWindowController.hideInfoWindow!();
              },
              onCameraMove: (position) {
                _customInfoWindowController.onCameraMove!();
              }),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 300,
            width: 300,
            offset: 40,
          )
        ],
      ),
    );
  }
}
