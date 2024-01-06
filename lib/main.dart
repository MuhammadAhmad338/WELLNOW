import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellnow/Provider/imageProvider.dart';
import 'package:wellnow/Provider/obsecureText.dart';
import 'package:wellnow/Services/healthArticleServices.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wellnow/firebase_options.dart';
import 'Provider/bottomNavProvider.dart';
import 'Provider/themeProvider.dart';
import './Routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  print(initializationSettingsAndroid.defaultIcon);
  print(initializationSettings);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
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
                colorScheme: ColorScheme.dark().copyWith(primary: Colors.white),
                fontFamily: 'Comfortaa',
                useMaterial3: true)
            : ThemeData(
                fontFamily: 'Comfortaa',
                useMaterial3: true,
                colorScheme: ColorScheme.light().copyWith(primary: Colors.red),
              ));
  }
}
