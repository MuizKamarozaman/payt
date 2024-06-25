import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payt/history/History_controller.dart';
import 'package:payt/views/HomePage.dart';

class HistoryPage extends StatelessWidget {
  final RecycleHistoryController controller =
      Get.put(RecycleHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
        title: Text(
          'Recycle History',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomePageUser()),
              (route) => false,
            );
          },
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          );
        } else if (controller.recycleHistory.isEmpty) {
          return Center(
            child: Text(
              'No recycle history available.',
              style: TextStyle(fontSize: 16),
            ),
          );
        } else {
          double totalWeights = controller.calculateTotalWeight();
          double totalMoney = controller.calculateTotalMoney();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 8,
                child: Container(
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  color: Colors.green,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total Weight: ' +
                            totalWeights.toStringAsFixed(2) +
                            ' kg',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Total Earned: RM ' + totalMoney.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.recycleHistory.length,
                  itemBuilder: (context, index) {
                    var historyEntry = controller.recycleHistory[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      elevation: 4,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Recycle ${index + 1}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Total Earned: RM ${historyEntry.money.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 16),
                            Table(
                              columnWidths: {
                                0: FlexColumnWidth(2),
                                1: FlexColumnWidth(1),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: TableCell(
                                        child: Text(
                                          'Type',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: TableCell(
                                        child: Text(
                                          'Weight (kg)',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                _buildTableRow('Plastic', historyEntry.plastic),
                                _buildTableRow('Glass', historyEntry.glass),
                                _buildTableRow('Paper', historyEntry.paper),
                                _buildTableRow('Rubber', historyEntry.rubber),
                                _buildTableRow('Metal', historyEntry.metal),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  TableRow _buildTableRow(String type, double weight) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Text(type, style: TextStyle(fontSize: 16)),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child:
                Text(weight.toStringAsFixed(2), style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
