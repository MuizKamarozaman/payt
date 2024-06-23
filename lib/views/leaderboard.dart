// lib/views/leaderboard_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payt/controllers/leaderboard_controller.dart';

class LeaderboardPage extends StatelessWidget {
  final LeaderboardController controller = Get.put(LeaderboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Leaderboard",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.green,
      ),
      body: Obx(() {
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 48, 160, 85),
                      Color.fromARGB(40, 81, 255, 0)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Top 3 Leaderboard
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (controller.usernames.length > 1)
                          _buildTopThreeUser(
                            2,
                            controller.usernames[1],
                            'assets/images/2.jpg',
                            controller.points[1],
                          ),
                        if (controller.usernames.length > 0)
                          _buildTopThreeUser(
                            1,
                            controller.usernames[0],
                            'assets/images/1.jpg',
                            controller.points[0],
                            isCenter: true,
                          ),
                        if (controller.usernames.length > 2)
                          _buildTopThreeUser(
                            3,
                            controller.usernames[2],
                            'assets/images/3.jpg',
                            controller.points[2],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Rankings",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.all(20),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.usernames.length,
                  itemBuilder: (context, index) {
                    // Skipping top 3 as they are already shown
                    if (index < 3) return Container();
                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/4.png'),
                        ),
                        title: Text(controller.usernames[index]),
                        subtitle: Text("Points: ${controller.points[index]}"),
                        trailing: Text("#${index + 1}"),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTopThreeUser(
    int rank,
    String name,
    String imagePath,
    int points, {
    bool isCenter = false,
  }) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: isCenter ? 50 : 40,
            ),
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.white,
              child: Text(
                rank.toString(),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            fontSize: isCenter ? 20 : 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          points.toString(),
          style: TextStyle(
            fontSize: isCenter ? 18 : 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
