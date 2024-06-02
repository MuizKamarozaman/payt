// lib/controllers/user_controller.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:payt/models/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:payt/views/HomePage.dart';

class UserController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to check if email is already registered
  Future<bool> isEmailAlreadyRegistered(String email) async {
    return await FirebaseHelper.isEmailAlreadyRegistered(email);
  }

  // Method to create a new user
  Future<void> createUser({
    required String fullName,
    required String email,
    required String contactNo,
    required String location,
    required String username,
    required String password,
  }) async {
    final userCollection = FirebaseFirestore.instance.collection('users');

    UserCredential newUser = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (newUser.user != null) {
      await userCollection.doc(newUser.user!.uid).set({
        'uid': newUser.user!.uid,
        'full_name': fullName,
        'email': email,
        'contact_no': contactNo,
        'location': location,
        'username': username,
        'role': 'user',
      });
    }
  }

  // Method to log in a user
  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        final userCollection = FirebaseFirestore.instance.collection('users');
        DocumentSnapshot snapshot = await userCollection.doc(user.uid).get();

        if (snapshot.exists) {
          String role = snapshot.get('role') ?? '';

          if (role.isNotEmpty) {
            // Redirect to appropriate home page based on user role
            if (role == 'user') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePageUser(),
                ),
              );
            } else if (role == 'staff') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePageStaff(),
                ),
              );
            }
          } else {
            throw Exception('User role not found.');
          }
        } else {
          throw Exception('User not found in database.');
        }
      }
    } catch (e) {
      throw Exception('Error logging in user: $e');
    }
  }
}
