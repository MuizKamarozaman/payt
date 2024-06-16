// lib/models/pickup_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class PickupModel {
  final CollectionReference pickupCollection =
      FirebaseFirestore.instance.collection('pickup');

  Future<List<Map<String, dynamic>>> getPickupData() async {
    List<Map<String, dynamic>> pickupData = [];

    try {
      QuerySnapshot pickupSnapshot = await pickupCollection.get();
      for (QueryDocumentSnapshot pickupDoc in pickupSnapshot.docs) {
        String username = pickupDoc.id;
        CollectionReference requestsCollection =
            pickupCollection.doc(username).collection('requests');
        QuerySnapshot requestsSnapshot = await requestsCollection.get();

        for (QueryDocumentSnapshot requestDoc in requestsSnapshot.docs) {
          Map<String, dynamic> data = requestDoc.data() as Map<String, dynamic>;

          pickupData.add({
            'id': requestDoc.id,
            'username': username,
            'telno': data['telno'],
            'location': data['location'] ?? '',
            'date': data['date'] ?? '',
            'time': data['time'] ?? '',
            'status': data['status'],
          });
        }
      }
    } catch (error) {
      print('Error getting pickup data: $error');
    }

    return pickupData;
  }

  Future<void> updateStatus(String username, String requestId) async {
    try {
      DocumentReference requestDoc =
          pickupCollection.doc(username).collection('requests').doc(requestId);
      await requestDoc.update({
        'status': true,
      });
    } catch (error) {
      print('Error updating pickup data: $error');
    }
  }
}
