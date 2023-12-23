import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellnow/LocalStorage/localStorage.dart';
import 'package:wellnow/Provider/themeProvider.dart';
import 'package:wellnow/Widgets/profileButton.dart';
import '../Helper/widthHeight.dart';
import '../Services/userServices.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void signingOut(context) async {
    await UserServices().signOut(context);
  }

  LocalStorage locaStorage = LocalStorage();
  final WidthHeight _widthHeight = WidthHeight();

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: _widthHeight.screenWidth(context, 0.035),
                vertical: _widthHeight.screenHeight(context, 0.035)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<String>(
                  future: locaStorage.getUsername(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data!);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
                SizedBox(
                  height: _widthHeight.screenHeight(context, 0.002),
                ),
                FutureBuilder<String>(
                  future: locaStorage.getEmail(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data!);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
                SizedBox(
                  height: _widthHeight.screenHeight(context, 0.021),
                ),
                Container(
                  color: Colors.blueGrey,
                  height: _widthHeight.screenHeight(context, 0.001),
                ),
                SizedBox(
                  height: _widthHeight.screenHeight(context, 0.021),
                ),
                GestureDetector(
                    onTap: () {
                      signingOut(context);
                    },
                    child: ProfileButton(text: "Log Out")),
                SizedBox(
                  height: _widthHeight.screenHeight(context, 0.015),
                ),
                GestureDetector(
                    onTap: () {
                      themeData.toggleTheme();
                    },
                    child: ProfileButton(text: "Change Theme"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
