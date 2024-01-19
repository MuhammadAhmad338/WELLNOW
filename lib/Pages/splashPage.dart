// ignore_for_file: file_names, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wellnow/Helper/widthHeight.dart';
import 'package:wellnow/LocalStorage/localStorage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final WidthHeight _widthHeight = WidthHeight();
  final LocalStorage _localStorage = LocalStorage();
  
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) async {
      final isSignedIn = await _localStorage.isSignedIn();
      if (isSignedIn) {
        GoRouter.of(context).pushReplacement('/main');
      } else {
        GoRouter.of(context).pushReplacement('/register');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Well Now",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: _widthHeight.screenHeight(context, 0.026))),
            SizedBox(height: _widthHeight.screenHeight(context, 0.00001)),
            Image.asset('assets/images/bandage.png',
                width: _widthHeight.screenWidth(context, 0.40),
                height: _widthHeight.screenHeight(context, 0.14))
          ]),
        ),
      ),
    );
  }
}
