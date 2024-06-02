// lib/models/pickup_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class PickupModel {
  // Collection reference
  final CollectionReference pickupCollection =
      FirebaseFirestore.instance.collection('pickup');

  Future<List<Map<String, dynamic>>> getPickupData() async {
    List<Map<String, dynamic>> pickupData = [];

    try {
      QuerySnapshot snapshot = await pickupCollection.get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = snapshot
          .docs
          .map((doc) => doc as QueryDocumentSnapshot<Map<String, dynamic>>)
          .toList();
      print(documents);

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in documents) {
        Map<String, dynamic>? data = doc.data();

        String id = doc.id;
        int telno = data['telno'];
        String location = data['location'] ?? '';
        String date = data['date'] ?? '';
        String time = data['time'] ?? '';
        bool status = data['status'];

        pickupData.add({
          'id': id,
          'telno': telno,
          'location': location,
          'date': date,
          'time': time,
          'status': status,
        });
      }
    } catch (error) {
      print('Error getting pickup data: $error');
    }

    return pickupData;
  }

  Future<void> updateStatus(String id) async {
    try {
      DocumentReference documentRef = pickupCollection.doc(id);
      await documentRef.update({
        'status': true,
      });
    } catch (error) {
      print('Error updating pickup data: $error');
    }
  }
}
