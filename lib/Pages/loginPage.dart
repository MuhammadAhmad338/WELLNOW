// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wellnow/Helper/widthHeight.dart';
import 'package:wellnow/Services/userServices.dart';
import '../Provider/obsecureText.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final WidthHeight _widthHeight = WidthHeight();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signingIn(context) async {
    final email = _emailController.text;
    final password = _passwordController.text;

    await UserServices().signIn(email, password, context);
  }

  @override
  Widget build(BuildContext context) {
    final obsecureTextt = Provider.of<ObsecureProvider>(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: _widthHeight.screenHeight(context, 0.20)),
                Image.asset('assets/images/bandage.png',
                    width: _widthHeight.screenWidth(context, 0.40),
                    height: _widthHeight.screenHeight(context, 0.14)),
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
                SizedBox(height: _widthHeight.screenHeight(context, 0.012)),
                TextFormField(
                  controller: _passwordController,
                  obscureText: obsecureTextt.obsecureText,
                  decoration: InputDecoration(
                     labelText: 'Password',
                     suffixIcon: IconButton(onPressed: () {
                      obsecureTextt.toggleObsecureText();
                     }, 
                     icon: Icon(obsecureTextt.obsecureText ?  Icons.visibility: Icons.visibility_off))
                  ),
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
                SizedBox(height: _widthHeight.screenHeight(context, 0.020)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push("/resetpassword");
                      },
                      child: Text("Forgot Password?",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                      
                            wordSpacing: 1,
                            fontSize: _widthHeight.screenHeight(context, 0.02),
                            decoration: TextDecoration.underline,
                          )),
                    )
                  ],
                ),
                SizedBox(height: _widthHeight.screenHeight(context, 0.030)),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Create the user
                      signingIn(context);
                      _emailController.clear();
                      _passwordController.clear();
                    }
                  },
                  child: const Text('LOGIN',
                      style: TextStyle(fontWeight: FontWeight.bold)),
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
                    Text("Don't have an account? "),
                    GestureDetector(
                        onTap: () {
                          GoRouter.of(context).pushReplacement('/register');
                        },
                        child: Text(
                          'CreateOne',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ))
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
