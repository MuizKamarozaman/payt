// lib/models/location_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getLocations() async {
    QuerySnapshot querySnapshot = await _firestore.collection('location').get();

    List<String> locations = [];

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data.containsKey('locationId')) {
        locations.add(data['locationId'].toString());
      }
    });

    return locations;
  }
}
