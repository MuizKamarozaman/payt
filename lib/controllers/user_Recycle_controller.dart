// lib/controllers/recycle_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payt/models/user_Recycle_model.dart';

class Category {
  final int id;
  final String name;

  Category(this.id, this.name);
}

List<Category> categories = [
  Category(0, 'All'),
  Category(1, 'Glass'),
  Category(2, 'Metal'),
  Category(3, 'Paper'),
  Category(4, 'Plastic'),
  Category(5, 'Rubber'),
];

class RecycleController extends GetxController {
  final RecycleModel _model = RecycleModel();

  var itemNames = ['Rubber', 'Plastic', 'Metal', 'Glass', 'Paper'];
  var itemPrices = [0.2, 0.2, 0.2, 0.2, 0.2];
  var itemQuantities = <double>[0, 0, 0, 0, 0].obs;
  var selectedOption = 0.obs;
  var showLocations = false.obs;

  var locations = <String>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  IconData getIcon(String itemName) {
    switch (itemName) {
      case 'Rubber':
        return Icons.extension;
      case 'Plastic':
        return Icons.ac_unit;
      case 'Metal':
        return Icons.build;
      case 'Glass':
        return Icons.wine_bar;
      case 'Paper':
        return Icons.description;
      default:
        return Icons.extension;
    }
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

  void showDescription(BuildContext context, String itemName, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Item Description'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('$itemName Description'),
                  SizedBox(height: 10),
                  Text(
                      'Weight: ${itemQuantities[index].toStringAsFixed(2)} kg'),
                  Text(
                      'Points: ${(itemQuantities[index] * 2).toStringAsFixed(2)}'),
                  Text(
                      'Payment: RM ${(itemQuantities[index] * itemPrices[index]).toStringAsFixed(2)}'),
                  SizedBox(height: 10),
                  Text('Enter Quantity (kg)'),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (itemQuantities[index] > 0) {
                              itemQuantities[index]--;
                            }
                          });
                        },
                      ),
                      Text(itemQuantities[index].toStringAsFixed(2)),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            itemQuantities[index]++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
