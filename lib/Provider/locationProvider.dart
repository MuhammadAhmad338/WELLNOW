import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationProvider with ChangeNotifier {
  GoogleMapsPlaces? _places;

  search() {
    _places = GoogleMapsPlaces(apiKey: "Your Google API Key");
  }

  void getNearbyPharmacies() async {
    PermissionStatus permission = await Permission.locationWhenInUse.request();

    if (permission.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(" Latitude ${position.latitude}");
      print(" Longitude ${position.longitude}");

      PlacesSearchResponse response = await _places!.searchNearbyWithRadius(
        Location(lat: position.latitude, lng: position.longitude),
        1500,
        type: "pharmacy",
      );

      for (var result in response.results) {
        print(result.name);
      }
      // Handle the response
    } else {
      // Handle the case where the user did not grant location permissions
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);
    print(position.longitude);
  }
}
