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
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/leaderboard.png'),
                      radius: 40,
                    ),
                    SizedBox(height: 10),
                    Text(
                      controller.userProfileUsername.value,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    Divider(
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Text(
                          "My Points",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          controller.points.isNotEmpty
                              ? controller.points[0].toString()
                              : '0',
                          style: TextStyle(
                            fontSize: 46,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "No",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Username",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Points",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.usernames.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(controller.usernames[index]),
                          leading: Text("#${index + 1}"),
                          trailing: Text(controller.points[index].toString()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
