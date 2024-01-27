import 'package:wellnow/Provider/emergencyContactsProvider.dart';
import 'package:wellnow/Services/healthArticleServices.dart';
import 'package:wellnow/Services/notificationServices.dart';
import 'package:wellnow/Provider/imageProvider.dart';
import 'package:wellnow/Provider/obsecureText.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wellnow/firebase_options.dart';
import 'Provider/bottomNavProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'Provider/themeProvider.dart';
import './Routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationServicesProvider().initializeNotifications();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<BottomBarProvider>(
      create: (context) => BottomBarProvider(),
    ),
    ChangeNotifierProvider<ImagePickerProvider>(
      create: (context) => ImagePickerProvider(),
    ),
    ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
    ),
    ChangeNotifierProvider<ObsecureProvider>(
      create: (context) => ObsecureProvider(),
    ),
    ChangeNotifierProvider<HealthArticleServices>(
      create: (context) => HealthArticleServices(),
    ),
    ChangeNotifierProvider<EmergencyContactsProvider>(
      create: (context) => EmergencyContactsProvider(),
    ),
    ChangeNotifierProvider<NotificationServicesProvider>(
      create: (context) => NotificationServicesProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeProvider>(context).isDarkMode;

    return MaterialApp.router(
        routerConfig: WellRoutes.router,
        title: 'Well Now',
        debugShowCheckedModeBanner: false,
        theme: themeData
            ? ThemeData(
                primarySwatch: Colors.blueGrey,
                brightness: Brightness.dark,
                primaryColor: Color(0xff263238),
                colorScheme: ColorScheme.dark().copyWith(
                  primary: Color(0xff263238),
                  secondary: Colors.purple[600],
                ),
                fontFamily: 'Comfortaa',
              )
            : ThemeData(
                primarySwatch: Colors.blue,
                brightness: Brightness.light,
                primaryColor: Colors.lightBlue[700],
                colorScheme: ColorScheme.light().copyWith(
                  primary: Colors.lightBlue[700],
                  secondary: Colors.teal[700],
                ),
                fontFamily: 'Comfortaa',
              ));
  }
}
