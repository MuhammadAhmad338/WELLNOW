// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wellnow/Provider/obsecureText.dart';
import '../Helper/widthHeight.dart';
import '../Services/userServices.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final WidthHeight _widthHeight = WidthHeight();
 
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signingUp(context) async {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    await UserServices().signUp(username, email, password, context);
  }

  @override
  Widget build(BuildContext context) {
    final obsecureTextt = Provider.of<ObsecureProvider>(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SizedBox(height: _widthHeight.screenHeight(context, 0.16)),
                Image.asset('assets/images/bandage.png',
                    width: _widthHeight.screenWidth(context, 0.40),
                    height: _widthHeight.screenHeight(context, 0.14)),
                SizedBox(height: _widthHeight.screenHeight(context, 0.016)),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: _widthHeight.screenHeight(context, 0.0001)),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address.';
                    }
                    if (!RegExp(r'[a-zA-Z0-9_\.]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: _widthHeight.screenHeight(context, 0.0001)),
                TextFormField(
                  controller: _passwordController,
                  obscureText: obsecureTextt.obsecureText,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                          onPressed: () {
                            obsecureTextt.toggleObsecureText();
                          },
                          icon: Icon(obsecureTextt.obsecureText
                              ? Icons.visibility
                              : Icons.visibility_off))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password.';
                    }
                    if (value.length < 6) {
                      return 'Your password must be at least 6 characters long.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: _widthHeight.screenHeight(context, 0.025)),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Create the user
                      signingUp(context);
                      _usernameController.clear();
                      _emailController.clear();
                      _passwordController.clear();
                    }
                  },
                  child: const Text('REGISTER',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, letterSpacing: 1)),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      Size(double.infinity,
                          45), // You can adjust the height (48) as needed
                    ),
                  ),
                ),
                SizedBox(height: _widthHeight.screenHeight(context, 0.025)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? '),
                    GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push('/login');
                        },
                        child: Text('Log In'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
