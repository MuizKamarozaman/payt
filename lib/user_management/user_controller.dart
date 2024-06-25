// lib/controllers/user_controller.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:payt/models/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:payt/views/HomePage.dart';
import 'package:payt/user_management/user_Profile_model.dart';

class UserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var userProfile = UserProfile(
    fullName: '',
    username: '',
    location: '',
    contactNo: '',
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  // Clear user profile
  void clearUserProfile() {
    userProfile.value = UserProfile(
      fullName: '',
      username: '',
      location: '',
      contactNo: '',
    );
  }

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
    final userCollection = _firestore.collection('users');

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
        await fetchUserProfile(); // Fetch the user profile for the logged-in user

        final userCollection = _firestore.collection('users');
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

  // Fetch user profile
  Future<void> fetchUserProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(user.uid).get();
        userProfile.value =
            UserProfile.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  // Update user profile
  Future<void> updateUserProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .update(userProfile.value.toMap());
      }
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }

  // Method to log out a user
  Future<void> logoutUser(BuildContext context) async {
    try {
      await _auth.signOut();
      clearUserProfile();
      // Navigate to the login page or perform other logout actions
      Navigator.pushReplacementNamed(
          context, '/login'); // Assuming you have a named route for login
    } catch (e) {
      print('Error logging out user: $e');
    }
  }
}
