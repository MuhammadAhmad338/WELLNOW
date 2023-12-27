import 'package:flutter/material.dart';
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Location Page"),
      ),
    );
  }
}