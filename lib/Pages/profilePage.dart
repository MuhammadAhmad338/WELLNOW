import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wellnow/LocalStorage/localStorage.dart';
import 'package:wellnow/Provider/obsecureText.dart';
import 'package:wellnow/Provider/themeProvider.dart';
import 'package:wellnow/Widgets/profileButton.dart';
import '../Helper/widthHeight.dart';
import '../Provider/imageProvider.dart';
import '../Services/userServices.dart';
import 'package:timezone/timezone.dart' as tz;

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
  bool _enabled = false;
  int _interval = 2;
 
 void scheduleNotification(int id, String title, String body, DateTime scheduledDate) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();  

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'channel id', 'channel name',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    tz.TZDateTime.from(scheduledDate, tz.local),
    platformChannelSpecifics,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}

  void scheduleNotifications() {
    // Cancel all existing notifications
    cancelNotifications();

    // Schedule a notification every _interval hours
    for (int i = 1; i <= 24 ~/ _interval; i++) {
      scheduleNotification(
        i,
        'Drink Water',
        'It\'s time to drink some water!',
        DateTime.now().add(Duration(hours: i * _interval)),
      );
    }
  }

  void cancelNotifications() {
    // Cancel all notifications
//    import 'package:flutter_local_notifications/flutter_local_notifications.dart';

    // Create an instance of FlutterLocalNotificationsPlugin
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.cancelAll();
  }

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
                      activeColor: Colors.red,
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
                Column(
                  children: [
                    SwitchListTile(
                      title: Text('Enable Water Reminder'),
                      value: _enabled,
                      onChanged: (bool value) {
                        setState(() {
                          _enabled = value;
                        });
                        if (value) {
                           scheduleNotifications();
                        } else {
                           cancelNotifications();
                        }
                      },
                    ),
                    DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: 'Interval (hours)',
                      ),
                      value: _interval,
                      items: <int>[1, 2, 3, 4].map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value hours'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _interval = value!;
                        });
                        if (_enabled) {
                          scheduleNotifications();
                        }
                      },
                    ),
                  ],
                ),
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
