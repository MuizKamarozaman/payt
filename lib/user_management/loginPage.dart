import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:payt/user_management/SignupPage.dart';
import 'package:payt/user_management/user_controller.dart';

class LoginDemo extends StatefulWidget {
  const LoginDemo({Key? key}) : super(key: key);

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserController userController = Get.put(UserController());
  String errorMessage = '';
  final _formKey = GlobalKey<FormState>();

  Future<void> _loginWithEmailAndPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      final String email = emailController.text;
      final String password = passwordController.text;

      setState(() {
        errorMessage = '';
      });

      try {
        await userController.loginUser(email, password, context);
      } catch (e) {
        setState(() {
          errorMessage = e.toString().replaceAll('Exception: ', '');
        });
      }
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(101, 145, 87, 1),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/loginPageBackground.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 260.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Montserrat',
                            letterSpacing: 5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(250, 250, 250, 1),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                          labelText: "Email",
                          hintText: 'Enter your email',
                        ),
                        validator: _validateEmail,
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(250, 250, 250, 1),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter password',
                        ),
                        validator: _validatePassword,
                      ),
                      SizedBox(height: 30.0),
                      Align(
                        child: Container(
                          width: 130,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(101, 145, 87, 1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: TextButton(
                            onPressed: _loginWithEmailAndPassword,
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                letterSpacing: 7,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      if (errorMessage.isNotEmpty)
                        Text(
                          errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      SizedBox(height: 144.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupPage(),
                                ),
                              );
                            },
                            child: Text(
                              " Create Account",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
