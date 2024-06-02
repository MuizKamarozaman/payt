// lib/controllers/pickup_controller.dart

import 'package:payt/models/pickup_model.dart';

class PickupController {
  final PickupModel _pickupModel = PickupModel();

  Future<List<Map<String, dynamic>>> getPickupData() async {
    return await _pickupModel.getPickupData();
  }

  Future<void> updateStatus(String id) async {
    await _pickupModel.updateStatus(id);
  }
}