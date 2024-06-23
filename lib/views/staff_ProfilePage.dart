// lib/views/staffProfilePage.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payt/controllers/staff_Profile_controller.dart';
import 'package:payt/views/HomePage.dart';
import 'package:payt/views/loginPage.dart';
import 'package:payt/views/all_Update_ProfilePage.dart';

class StaffProfilePage extends StatelessWidget {
  final StaffController _staffController = Get.put(StaffController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Staff Profile',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomePageStaff()),
              (route) => false,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() {
                if (_staffController.errorMessage.isNotEmpty) {
                  return Text(
                    _staffController.errorMessage.value,
                    style: TextStyle(color: Colors.red),
                  );
                }

                final user = _staffController.staff.value;
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildProfileRow('Username', user.username),
                          SizedBox(height: 10),
                          buildProfileRow('Email', user.email),
                          SizedBox(height: 10),
                          buildProfileRow('Location', user.location),
                          SizedBox(height: 10),
                          buildProfileRow('Contact No', user.contact_no),
                          SizedBox(height: 10),
                          Center(
                            child: ElevatedButton(
                              child: Text('Log out'),
                              onPressed: () async {
                                await _staffController.signOut();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginDemo()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: 30),
              ElevatedButton(
                child: Text('Update Profile'),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateProfilePage()),
                  );
                  if (result == true) {
                    _staffController
                        .fetchStaffData(); // Re-fetch the staff data if result is true
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
