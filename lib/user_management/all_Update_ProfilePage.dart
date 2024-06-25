// lib/views/userProfilePage.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:payt/user_management/user_controller.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          'Update Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        final user = _userController.userProfile.value;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildProfilePicture(),
              SizedBox(height: 24.0),
              _buildTextField(
                label: 'Full Name',
                initialValue: user.fullName,
                enabled: false,
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                label: 'Username',
                initialValue: user.username,
                onChanged: (value) {
                  _userController.userProfile.update((userProfile) {
                    userProfile?.username = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                label: 'Contact No.',
                initialValue: user.contactNo,
                onChanged: (value) {
                  _userController.userProfile.update((userProfile) {
                    userProfile?.contactNo = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                label: 'Location',
                initialValue: user.location,
                onChanged: (value) {
                  _userController.userProfile.update((userProfile) {
                    userProfile?.location = value;
                  });
                },
              ),
              SizedBox(height: 24.0),
              _buildUpdateButton(context),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProfilePicture() {
    return Center(
      child: CircleAvatar(
        radius: 50.0,
        backgroundImage: NetworkImage(
            'https://via.placeholder.com/150'), // Placeholder for user profile picture
        backgroundColor: Colors.grey.shade200,
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    ValueChanged<String>? onChanged,
    bool enabled = true,
  }) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade700),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.green),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
      style: TextStyle(color: Colors.black),
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await _userController.updateUserProfile();
        Navigator.pop(context, true); // Pass true as the result
      },
      child: Text('Update'),
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
      ),
    );
  }
}
