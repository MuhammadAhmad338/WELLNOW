import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wellnow/Pages/editPage.dart';
import 'package:wellnow/Pages/loginPage.dart';
import 'package:wellnow/Pages/medicalrecord.dart';
import 'package:wellnow/Pages/resetPasswordPage.dart';
import 'package:wellnow/Pages/signupPage.dart';
import 'package:wellnow/Pages/splashPage.dart';
import '../Pages/mainPage.dart';

class WellRoutes {
  /// The route configuration.
  static final GoRouter router = GoRouter(
    initialLocation: "/",
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return SplashPage();
        },
      ),
      GoRoute(
        path: '/medicalrecord',
        builder: (BuildContext context, GoRouterState state) {
          return MedicalRecords();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return LoginPage();
        },
      ),
      GoRoute(
        path: '/register',
        builder: (BuildContext context, GoRouterState state) {
          return SignupPage();
        },
      ),
       GoRoute(
        path: '/resetpassword',
        builder: (BuildContext context, GoRouterState state) {
          return ResetPassword(text: 'Reset Password',);
        },
      ),
      GoRoute(
        path: '/changepassword',
        builder: (BuildContext context, GoRouterState state) {
          return ResetPassword(text: 'Change Password',);
        },
      ),
      GoRoute(path: '/editprofile',
      builder:(context, state) {
        return EditPage();
      },
      ),
      GoRoute(path: '/main',
      builder: (BuildContext context, GoRouterState state) {
        return MainPage();
      }
      )
    ],
  );
}
