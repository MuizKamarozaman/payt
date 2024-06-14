import 'package:get/get.dart';
import 'package:payt/models/staff_recycle_model.dart';

class StaffRecycleController extends GetxController {
  final StaffRecycleModel recycleModel = StaffRecycleModel();
  var cumulativeWeights = <Map<String, dynamic>>[].obs;
  var userTotalWeight = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCumulativeWeights();
  }

  Future<void> fetchCumulativeWeights() async {
    cumulativeWeights.value = await recycleModel.getCumulativeWeights();
  }

  Future<void> fetchUserTotalWeight(String userId) async {
    var weights = await recycleModel.getUserTotalWeight(userId);
    if (weights.isNotEmpty) {
      userTotalWeight.value = weights[0]['totalWeight'];
    }
  }

  Future<void> addRecycleData(
    String userEmail,
    double weight,
    double plastic,
    double glass,
    double paper,
    double rubber,
    double metal,
    double paymentTotal,
    double point,
  ) async {
    await recycleModel.addRecycleData(
      userEmail,
      weight,
      plastic,
      glass,
      paper,
      rubber,
      metal,
      paymentTotal,
      point,
    );
    fetchCumulativeWeights(); // Refresh data after adding new entry
  }
}
