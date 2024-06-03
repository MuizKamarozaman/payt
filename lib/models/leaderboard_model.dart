// lib/models/leaderboard_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LeaderboardModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getUsernames() async {
    CollectionReference collectionReference = _firestore.collection('recycle');
    QuerySnapshot querySnapshot = await collectionReference.get();

    return querySnapshot.docs
        .map((doc) => doc.get('username').toString())
        .toList();
  }

  Future<List<int>> getTotalPoints() async {
    CollectionReference collectionReference = _firestore.collection('recycle');
    QuerySnapshot querySnapshot = await collectionReference.get();

    List<int> totalPoints = [];

    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      String userId = docSnapshot.id;
      QuerySnapshot subCollectionSnapshot =
          await collectionReference.doc(userId).collection('data').get();

      int points = 0;
      for (QueryDocumentSnapshot subDocSnapshot in subCollectionSnapshot.docs) {
        double point = subDocSnapshot.get('point') as double;
        points += point.toInt();
      }

      totalPoints.add(points);
    }

    return totalPoints;
  }

  Future<String?> getUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  Future<String?> getUserProfileUsername(String userId) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(userId).get();

    return documentSnapshot.get('username');
  }

  Future<int> getUserProfilePoints(String userId) async {
    CollectionReference recycleCollection = _firestore.collection('recycle');
    DocumentSnapshot documentSnapshot =
        await recycleCollection.doc(userId).get();

    if (documentSnapshot.exists) {
      QuerySnapshot subCollectionSnapshot =
          await documentSnapshot.reference.collection('data').get();

      int totalPoints = 0;
      for (QueryDocumentSnapshot subDocSnapshot in subCollectionSnapshot.docs) {
        double point = subDocSnapshot.get('point') as double;
        totalPoints += point.toInt();
      }

      return totalPoints;
    }
    return 0;
  }
}
