// lib/views/signUpPage.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:payt/user_management/user_controller.dart';
import 'package:payt/user_management/loginPage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final UserController _userController = UserController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController contactNo = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _createUserWithEmailAndPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        showSpinner = true;
      });

      try {
        await _userController.createUser(
          fullName: fullName.text,
          email: email.text,
          contactNo: contactNo.text,
          location: location.text,
          username: username.text,
          password: password.text,
        );

        Navigator.pushNamed(context, 'login_screen');
      } catch (e) {
        print(e);
      }

      setState(() {
        showSpinner = false;
      });
    }
  }

  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full Name is required';
    }
    return null;
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

  String? _validateContactNo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Contact Number is required';
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Enter a valid contact number';
    }
    return null;
  }

  String? _validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Location is required';
    }
    return null;
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/SignUpBackground.png',
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 60),
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginDemo()),
                        );
                      },
                    ),
                    SizedBox(height: 45.0),
                    Center(
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Montserrat',
                          letterSpacing: 4,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    TextFormField(
                      controller: fullName,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        labelText: "Full Name",
                        hintText: 'Enter your full name',
                      ),
                      validator: _validateFullName,
                    ),
                    SizedBox(height: 17.0),
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        labelText: "Email",
                        hintText: 'Enter your Email',
                      ),
                      validator: _validateEmail,
                    ),
                    SizedBox(height: 17.0),
                    TextFormField(
                      controller: contactNo,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        labelText: "Contact No.",
                        hintText: 'Enter your Contact Number',
                      ),
                      validator: _validateContactNo,
                    ),
                    SizedBox(height: 17.0),
                    TextFormField(
                      controller: location,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        labelText: "Location",
                        hintText: 'Enter your location',
                      ),
                      validator: _validateLocation,
                    ),
                    SizedBox(height: 17.0),
                    TextFormField(
                      controller: username,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        labelText: "Username",
                        hintText: 'Enter your username',
                      ),
                      validator: _validateUsername,
                    ),
                    SizedBox(height: 17.0),
                    TextFormField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
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
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(101, 145, 87, 1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextButton(
                        onPressed: _createUserWithEmailAndPassword,
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            letterSpacing: 4,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already have an account?"),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginDemo(),
                              ),
                            );
                          },
                          child: Text(
                            " Sign In",
                            style: TextStyle(
                              color: Colors.green,
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
        ],
      ),
    );
  }
}
