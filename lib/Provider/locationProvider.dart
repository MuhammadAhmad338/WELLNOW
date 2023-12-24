import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_google_maps_webservices/places.dart';

class LocationProvider with ChangeNotifier {
  GoogleMapsPlaces? _places;

  search() {
    _places = GoogleMapsPlaces(apiKey: "Your Google API Key");
  }

  void getNearbyPharmacies() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    PlacesSearchResponse response = await _places!.searchNearbyWithRadius(
      Location(lat: position.latitude, lng: position.longitude),
      1500,
      type: "pharmacy",
    );

    for (var result in response.results) {
      print(result.name);
    }
  }

  void getNearbyHospitals() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    PlacesSearchResponse response = await _places!.searchNearbyWithRadius(
      Location(lat: position.latitude, lng: position.longitude),
      1500,
      type: "hospitals",
    );

    for (var result in response.results) {
      print(result.name);
    }
  }
}
