// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellnow/Helper/widthHeight.dart';
import '../Provider/bottomNavProvider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final cartProvider = Provider.of<BottomBarProvider>(context);
    final WidthHeight _widthHeight = WidthHeight();

    return Scaffold(
      body: cartProvider.screens[cartProvider.bottomIndex],
      bottomNavigationBar: NavigationBar(
          selectedIndex: cartProvider.bottomIndex,
          onDestinationSelected: (index) {
            cartProvider.changeIndex(index);
          },
          elevation: 1,
          destinations: [
            NavigationDestination(
                icon: Image.asset("assets/images/home.png",
                    width: _widthHeight.screenWidth(context, 0.035),
                    height: _widthHeight.screenHeight(context, 0.035)),
                label: "Home"),
            NavigationDestination(
                icon: Image.asset(
                  "assets/images/open-book.png",
                  width: _widthHeight.screenWidth(context, 0.035),
                  height: _widthHeight.screenHeight(context, 0.035),
                ),
                label: "Tips"),
            NavigationDestination(
                icon: Image.asset(
                  "assets/images/maps-and-flags.png",
                  width: _widthHeight.screenWidth(context, 0.035),
                  height: _widthHeight.screenHeight(context, 0.035),
                ),
                label: "Search"),
            NavigationDestination(
                icon: Image.asset("assets/images/settings.png",
                    width: _widthHeight.screenWidth(context, 0.035),
                    height: _widthHeight.screenHeight(context, 0.035)),
                label: "Settings")
          ]),
    );
  }
}
