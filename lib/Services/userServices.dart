import 'dart:convert';
import '../Models/user.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wellnow/Api/api.dart';
import 'package:wellnow/Helper/const.dart';
import 'package:wellnow/LocalStorage/localStorage.dart';

class UserServices {
  signIn(String email, String password, BuildContext context) async {
    // Show a loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      Map<String, String> body = {'email': email, 'password': password};
      Response response = await client.post(
          Uri.parse('${APIURL}/api/users/login'),
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
       // Decode the response body into a JSON object.
        Map<String, dynamic> json = jsonDecode(response.body);

        // Create a User object from the JSON object.
        User user = User.fromJson(json);

        LocalStorage().setUsername(user.username);
        LocalStorage().setEmail(user.email);

        LocalStorage().saveSignInData(true);
        GoRouter.of(context).pop();
        GoRouter.of(context).pushReplacement('/main');
      }
    } catch (error) {
      print(error);
    }
  }

  signUp(String username, String email, String password,
      BuildContext context) async {
    // Show a loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      Map<String, String> body = {
        'username': username,
        'email': email,
        'password': password
      };
      Response response = await client.post(
          Uri.parse('${APIURL}/api/users/register'),
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        // Decode the response body into a JSON object.
        Map<String, dynamic> json = jsonDecode(response.body);

        // Create a User object from the JSON object.
        User user = User.fromJson(json);
        LocalStorage().setUsername(user.username);
        LocalStorage().setEmail(user.email);
        
        LocalStorage().saveSignInData(true);
        GoRouter.of(context).pop();
        GoRouter.of(context).pushReplacement('/main');
      }
    } catch (error) {
      print("Some error occured ${error}");
      GoRouter.of(context).pop();
    }
  }

  signOut(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      Response response = await client.delete(
          Uri.parse('${APIURL}/api/users/logout'),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {

        LocalStorage().saveSignInData(false);
        GoRouter.of(context).pop();
        GoRouter.of(context).pushReplacement('/register');
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
                child: Text('User is already signed out',
                    style: TextStyle(fontWeight: FontWeight.bold))));
        LocalStorage().setUsername('');
        LocalStorage().saveSignInData(false);
        GoRouter.of(context).pop();
        GoRouter.of(context).pushReplacement('/register');
      }
    } catch (error) {
      print("Some error occured ${error}");
      GoRouter.of(context).pop();
    }
  }

  resetPassword(String email, BuildContext context) async {
    // Show a loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      Map<String, String> body = {'email': email};
      Response response = await client.post(
          Uri.parse('${APIURL}/api/users/resetpassword'),
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        print(response.body);

        GoRouter.of(context).pop();
        GoRouter.of(context).pushReplacement('/login');
      }
    } catch (error) {
      print(error);
      GoRouter.of(context).pop();
    }
  }
}
