// lib/controllers/leaderboard_controller.dart
import 'package:get/get.dart';
import 'package:payt/leaderboard/leaderboard_model.dart';

class LeaderboardController extends GetxController {
  final LeaderboardModel _model = LeaderboardModel();

  var usernames = <String>[].obs;
  var points = <int>[].obs;
  var errorMessage = ''.obs;
  var userId = ''.obs;
  var userProfileUsername = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
    getUserId();
    updateProfilePoints();
  }

  Future<void> fetchData() async {
    try {
      List<String> fetchedUsernames = await _model.getUsernames();
      List<int> fetchedPoints = await _model.getTotalPoints();

      // Combine usernames and points
      List<MapEntry<String, int>> data = List.generate(
        fetchedUsernames.length,
        (index) => MapEntry(fetchedUsernames[index], fetchedPoints[index]),
      );

      // Sort data by points in descending order
      data.sort((a, b) => b.value.compareTo(a.value));

      usernames.value = data.map((entry) => entry.key).toList();
      points.value = data.map((entry) => entry.value).toList();
      errorMessage.value = '';
    } catch (error) {
      errorMessage.value = 'Error fetching data: $error';
    }
  }

  Future<void> getUserId() async {
    String? id = await _model.getUserId();
    if (id != null) {
      userId.value = id;
      userProfileUsername.value = await _model.getUserProfileUsername(id) ?? '';
    }
  }

  Future<void> updateProfilePoints() async {
    if (userId.value.isNotEmpty) {
      int userPoints = await _model.getUserProfilePoints(userId.value);
      points.value = [userPoints];
    }
  }
}
