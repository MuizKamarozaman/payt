import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payt/controllers/user_Request_contorller.dart';
import 'package:payt/views/HomePage.dart';

class UserRequestPage extends StatelessWidget {
  final UserRequestController controller = Get.put(UserRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Request Pickup',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomePageUser()),
              (route) => false,
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: controller.dateController,
                  decoration: InputDecoration(labelText: 'Date'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a date';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.timeController,
                  decoration: InputDecoration(labelText: 'Time'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a time';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.locationController,
                  decoration: InputDecoration(labelText: 'Location'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a location';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.telNoController,
                  decoration: InputDecoration(labelText: 'Telephone Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a telephone number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: controller.submitRequest,
                  child: Text('Submit Request'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
