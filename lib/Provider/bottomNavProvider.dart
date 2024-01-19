// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:wellnow/Pages/healthArticles.dart';
import 'package:wellnow/Pages/homePage.dart';
import '../Pages/profilePage.dart';
import '../Pages/tipsPage.dart';

class BottomBarProvider with ChangeNotifier {
  int _bottomIndex = 0;
  int get bottomIndex => _bottomIndex;
  final _screens =  [HomePage(), TipsPage(), HealthArticlesPage(), ProfilePage()];

  List<Widget> get screens => _screens; 
  void changeIndex(int index) {
    _bottomIndex = index;
    notifyListeners();
  }

}