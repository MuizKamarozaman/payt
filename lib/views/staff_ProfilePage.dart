// lib/views/staffProfilePage.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payt/controllers/staff_Profile_controller.dart';
import 'package:payt/views/HomePage.dart';
import 'package:payt/views/loginPage.dart';
import 'package:payt/views/user_ProfilePage.dart';

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
      body: Container(
        color: Colors.grey[200],
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Obx(() {
                    if (_staffController.errorMessage.isNotEmpty) {
                      return Text(_staffController.errorMessage.value,
                          style: TextStyle(color: Colors.red));
                    }

                    final user = _staffController.staff.value;
                    return Container(
                      width: 400,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15),
                            width: 280,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Username  : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 10),
                                    Flexible(
                                      child: Text(
                                        '${user.username}',
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Email           : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 10),
                                    Flexible(
                                      child: Text(
                                        '${user.email}',
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Full Name   : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 10),
                                    Flexible(
                                      child: Text(
                                        '${user.fullName}',
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                          Container(
                            child: Center(
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
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: ElevatedButton(
                    child: Text('Update Profile'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateProfilePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
