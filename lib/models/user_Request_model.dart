import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class UserRequestModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<String> getUsername(String userID) async {
    final userDoc = await _firestore.collection('users').doc(userID).get();
    return userDoc.data()?['username'] ?? 'No username';
  }

  Future<void> submitPickupRequest({
    required String userID,
    required String date,
    required String time,
    required String location,
    required int telNo,
  }) async {
    final username = await getUsername(userID);

    // Add request to the user's subcollection 'requests'
    final userRequestsCollection =
        _firestore.collection('pickup').doc(username).collection('requests');
    await userRequestsCollection.add({
      'date': date,
      'time': time,
      'location': location,
      'status': false,
      'telno': telNo,
      'username': username,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
