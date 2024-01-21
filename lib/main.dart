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
                primaryColor: Colors.blueAccent,
                fontFamily: 'Comfortaa',
              )
            : ThemeData(
                primarySwatch: Colors.teal,
                brightness: Brightness.light,
                primaryColor: Colors.tealAccent,
                fontFamily: 'Comfortaa',
              ));
  }
}
