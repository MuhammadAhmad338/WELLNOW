import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wellnow/Provider/locationProvider.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  
  @override
  void initState() {
    super.initState();
    LocationProvider().getNearbyPharmacies();
  }

  final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: GoogleMap(
      initialCameraPosition: _initialCameraPosition,
    )));
  }
}
