import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellnow/Provider/obsecureText.dart';
import 'Provider/bottomNavProvider.dart';
import 'Provider/themeProvider.dart';
import './Routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<BottomBarProvider>(
      create: (context) => BottomBarProvider(),
    ),
    ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
    ),
    ChangeNotifierProvider<ObsecureProvider>(
      create: (context) => ObsecureProvider(),
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
        theme:  themeData ? ThemeData(
          colorScheme: ColorScheme.dark().copyWith(
            primary: Colors.white
          ),
          fontFamily: 'Comfortaa',
          useMaterial3: true
        ) : 
        ThemeData(
          fontFamily: 'Comfortaa',
          useMaterial3: true,
          colorScheme: ColorScheme.light().copyWith(
            primary: Colors.red
          ),
        ));
  }
}
