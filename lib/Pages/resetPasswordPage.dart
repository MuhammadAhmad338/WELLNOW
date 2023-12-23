import 'package:flutter/material.dart';
import 'package:wellnow/Services/userServices.dart';
import '../Helper/widthHeight.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});

  final TextEditingController _resetEmailController = TextEditingController();
  final WidthHeight _widthHeight = WidthHeight();
  final _formKey = GlobalKey<FormState>();

  void pleaseResetPassword(BuildContext context) async {
    final email = _resetEmailController.text;
    await UserServices().resetPassword(email, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text("Forgot Password",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _widthHeight.screenHeight(context, 0.03)))),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: _widthHeight.screenHeight(context, 0.2)),
                    Text("Mail Address Here",
                        style: TextStyle(
                          fontSize: _widthHeight.screenHeight(context, 0.032),
                          fontWeight: FontWeight.w900,
                        )),
                    SizedBox(height: _widthHeight.screenHeight(context, 0.012)),
                    Text("Enter the email address associated with your account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w800,
                          fontSize: _widthHeight.screenHeight(context, 0.022),
                        )),
                    SizedBox(height: _widthHeight.screenHeight(context, 0.025)),
                    TextFormField(
                      controller: _resetEmailController,
                      decoration: const InputDecoration(
                        labelText: 'Enter your email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        if (!RegExp(
                                r'[a-zA-Z0-9_\.]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: _widthHeight.screenHeight(context, 0.025)),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Create the user
                          pleaseResetPassword(context);
                          _resetEmailController.clear();
                        }
                      },
                      child: const Text('RESET PASSWORD',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 1)),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          Size(double.infinity, 45), // You can adjust the height (48) as needed
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
