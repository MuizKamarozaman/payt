// lib/controllers/recycle_history_controller.dart
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:payt/history/history_model.dart';

class RecycleHistoryController extends GetxController {
  var recycleHistory = <RecycleHistory>[].obs;
  var errorMessage = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecycleHistory();
  }

  Future<void> fetchRecycleHistory() async {
    try {
      isLoading.value = true;
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        CollectionReference recycleCollection =
            FirebaseFirestore.instance.collection('recycle');

        QuerySnapshot querySnapshot =
            await recycleCollection.doc(user.email).collection('data').get();

        List<RecycleHistory> history = querySnapshot.docs
            .map((doc) =>
                RecycleHistory.fromMap(doc.data() as Map<String, dynamic>))
            .toList();

        recycleHistory.value = history;
        errorMessage.value = '';
      }
    } catch (error) {
      errorMessage.value = 'Error fetching recycle history: $error';
    } finally {
      isLoading.value = false;
    }
  }

  double calculateTotalWeight() {
    double totalWeight = 0;
    for (RecycleHistory historyEntry in recycleHistory) {
      totalWeight += historyEntry.weight;
    }
    return totalWeight;
  }

  double calculateTotalMoney() {
    double totalMoney = 0;
    for (RecycleHistory historyEntry in recycleHistory) {
      totalMoney += historyEntry.money;
    }
    return totalMoney;
  }
}
