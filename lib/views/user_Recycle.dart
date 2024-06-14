// lib/views/recycle_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payt/controllers/user_Recycle_controller.dart';
import 'package:payt/controllers/location_controller.dart';
import 'package:payt/views/HomePage.dart';

class RecyclePage extends StatelessWidget {
  final RecycleController recycleController = Get.put(RecycleController());
  final LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Recycle',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomePageUser()),
              (route) => false,
            );
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Item List Descriptions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: recycleController.itemNames.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    recycleController.showDescription(
                        context, recycleController.itemNames[index], index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          recycleController
                              .getIcon(recycleController.itemNames[index]),
                          size: 30,
                        ),
                        SizedBox(height: 10),
                        Text(
                          recycleController.itemNames[index],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
