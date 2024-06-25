// lib/controllers/staff_controller.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:payt/profile_page/staff_Profile_model.dart';

class StaffController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var staff =
      Staff(username: '', email: '', fullName: '', location: "", contact_no: "")
          .obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStaffData();
  }

  Future<void> fetchStaffData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(user.uid).get();
        staff.value = Staff.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      errorMessage.value = 'Error fetching staff data: $e';
    }
  }

  Future<void> updateProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'username': staff.value.username,
          'email': staff.value.email,
          'full_name': staff.value.fullName,
          'location': staff.value.location,
          'contact_no': staff.value.contact_no,
        });
        // Fetch the updated data
        await fetchStaffData();
      }
    } catch (e) {
      errorMessage.value = 'Error updating profile: $e';
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      errorMessage.value = 'Error signing out: $e';
    }
  }
}
