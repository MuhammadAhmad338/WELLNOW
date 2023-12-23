import 'package:flutter/material.dart';

class ObsecureProvider with ChangeNotifier {
  bool _obsecureText = true;
  bool get obsecureText => _obsecureText;
  void toggleObsecureText() {
    _obsecureText  = !_obsecureText;
    notifyListeners();
  }
}