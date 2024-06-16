import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payt/models/user_request_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRequestController extends GetxController {
  final UserRequestModel _userRequestModel = UserRequestModel();
  final formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final locationController = TextEditingController();
  final telNoController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _userRequestModel.initializeFirebase();
  }

  Future<void> submitRequest() async {
    if (formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          await _userRequestModel.submitPickupRequest(
            userID: user.uid,
            date: dateController.text,
            time: timeController.text,
            location: locationController.text,
            telNo: int.parse(telNoController.text),
          );
          Get.snackbar(
            'Success',
            'Pickup request submitted',
            snackPosition: SnackPosition.BOTTOM,
          );
          formKey.currentState!.reset();
        } catch (error) {
          Get.snackbar(
            'Error',
            'Failed to submit pickup request',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    }
  }
}
