// lib/views/location_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payt/location/location_controller.dart';
import 'package:payt/views/HomePage.dart';

class LocationPage extends StatelessWidget {
  final LocationController controller = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(101, 145, 87, 1),
        elevation: 0,
        title: Text(
          'Recycling Location',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomePageUser()),
              (route) => false,
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.errorMessage.isNotEmpty) {
            return Center(
                child: Text('Error: ${controller.errorMessage.value}'));
          } else if (controller.locations.isEmpty) {
            return Center(child: Text('No locations found'));
          } else {
            return Column(
              children: controller.locations.map((location) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(32),
                      child: Text(
                        location,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }
        }),
      ),
    );
  }
}
