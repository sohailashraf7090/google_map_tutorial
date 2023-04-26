import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DrawPolygon extends StatefulWidget {
  const DrawPolygon({super.key});

  @override
  State<DrawPolygon> createState() => _DrawPolygonState();
}

class _DrawPolygonState extends State<DrawPolygon> {
  final Completer<GoogleMapController> _controller = Completer();
  final CameraPosition _kGooglePlex =
      const CameraPosition(target: LatLng(30.791988, 73.458956), zoom: 14);

  final Set<Polygon> _polygon = HashSet<Polygon>();
  final List<LatLng> _points = [
    const LatLng(30.791988, 73.458956),
    const LatLng(30.792467, 73.452412),
    const LatLng(30.792762, 73.452648),
    const LatLng(30.793038, 73.450910),
    const LatLng(30.791398, 73.448893),
    const LatLng(30.793600, 73.452111),
    const LatLng(30.791988, 73.458956)
  ];
  @override
  void initState() {
    super.initState();
    _polygon.add(Polygon(
        polygonId: const PolygonId("1"),
        points: _points,
        fillColor: Colors.red,
        geodesic: true,
        strokeWidth: 4,
        strokeColor: Colors.deepOrange));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Polygon")),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        myLocationEnabled: false,
        polygons: _polygon,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
