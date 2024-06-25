// lib/controllers/location_controller.dart
import 'package:get/get.dart';
import 'package:payt/location/location_model.dart';

class LocationController extends GetxController {
  final LocationModel _model = LocationModel();

  var locations = <String>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLocations();
  }

  Future<void> fetchLocations() async {
    try {
      isLoading.value = true;
      List<String> fetchedLocations = await _model.getLocations();
      locations.value = fetchedLocations;
    } catch (error) {
      errorMessage.value = 'Error fetching locations: $error';
    } finally {
      isLoading.value = false;
    }
  }
}
