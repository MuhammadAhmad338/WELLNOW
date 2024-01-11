import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wellnow/LocalStorage/localStorage.dart';
import 'package:wellnow/Provider/obsecureText.dart';
import 'package:wellnow/Provider/themeProvider.dart';
import 'package:wellnow/Widgets/profileButton.dart';
import '../Helper/widthHeight.dart';
import '../Provider/imageProvider.dart';
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
    final switchProvider = Provider.of<ObsecureProvider>(context);
    final imageProvider = Provider.of<ImagePickerProvider>(context);

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
                SizedBox(
                  height: _widthHeight.screenHeight(context, 0.021),
                ),
                Row(
                  children: [
                    imageProvider.image != null
                        ? Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black, // Specify border color
                                width: 1.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), // Specify shadow color
                                  spreadRadius: 3, // Specify spread radius
                                  blurRadius: 3, // Specify blur radius
                                  offset: Offset(0, 3), // Specify offset
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: _widthHeight.screenWidth(context, 0.09),
                              backgroundImage: FileImage(imageProvider.image!),
                            ))
                        : CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                              'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                            ),
                          ),
                    SizedBox(
                      width: _widthHeight.screenWidth(context, 0.02),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<String>(
                          future: locaStorage.getUsername(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: _widthHeight.screenHeight(
                                        context, 0.016)),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          },
                        ),
                        SizedBox(
                          height: _widthHeight.screenHeight(context, 0.005),
                        ),
                        FutureBuilder<String>(
                          future: locaStorage.getEmail(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: _widthHeight.screenHeight(
                                        context, 0.016)),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          },
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Switch to Dark Mode',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: _widthHeight.screenHeight(context, 0.018)),
                    ),
                    //Make a switch in flutter
                    Switch(
                      value: switchProvider.isSwitched,
                      onChanged: (value) {
                        // Add your dark mode enabling code here
                        themeData.toggleTheme();
                        switchProvider.toggleSwitch(value);
                      },
                      activeTrackColor: Colors.redAccent,
                      activeColor: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  height: _widthHeight.screenHeight(context, 0.002),
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
                      GoRouter.of(context).push('/editprofile');
                    },
                    child: ProfileButton(text: "Edit Profile")),
                SizedBox(
                  height: _widthHeight.screenHeight(context, 0.015),
                ),
                GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push('/changepassword');
                    },
                    child: ProfileButton(text: "Change Password")),
                SizedBox(
                  height: _widthHeight.screenHeight(context, 0.015),
                ),
                GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push('/medicalrecord');
                    },
                    child: ProfileButton(text: "Medical Record")),
                SizedBox(
                  height: _widthHeight.screenHeight(context, 0.015),
                ),
                GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push('/emergencyContacts');
                    },
                    child: ProfileButton(text: "Emergency Contacts")),
                //    Elevated Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          signingOut(context);
                        },
                        child: Text(
                          "Log Out",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
