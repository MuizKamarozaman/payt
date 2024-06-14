// lib/controllers/staff_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:payt/models/staff_Profile_model.dart';

class StaffController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var staff = Staff(username: '', email: '', fullName: '').obs;
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

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      errorMessage.value = 'Error signing out: $e';
    }
  }
}
