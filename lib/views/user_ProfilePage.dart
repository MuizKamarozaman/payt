
// lib/views/userProfilePage.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payt/controllers/user_controller.dart';

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
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Obx(() {
        final user = _userController.userProfile.value;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: user.fullName,
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                ),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: user.username,
                onChanged: (value) {
                  _userController.userProfile.update((userProfile) {
                    userProfile?.username = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: TextEditingController(text: user.contactNo),
                onChanged: (value) {
                  _userController.userProfile.update((userProfile) {
                    userProfile?.contactNo = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Contact No.',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: user.location,
                onChanged: (value) {
                  _userController.userProfile.update((userProfile) {
                    userProfile?.location = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Location',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  await _userController.updateUserProfile();
                  Navigator.pop(
                      context); // Return to the previous page after updating
                },
                child: Text('Update'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
