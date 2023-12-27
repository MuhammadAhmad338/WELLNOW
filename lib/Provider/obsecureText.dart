import 'package:flutter/material.dart';

class ObsecureProvider with ChangeNotifier {
  
  bool _obsecureText = true;
  bool _isSwitched = false;
  bool get isSwitched => _isSwitched;
  bool get obsecureText => _obsecureText;

  void toggleObsecureText() {
    _obsecureText  = !_obsecureText;
    notifyListeners();
  }

  void toggleSwitch(value) {
     _isSwitched = value;
    notifyListeners();
  }
}