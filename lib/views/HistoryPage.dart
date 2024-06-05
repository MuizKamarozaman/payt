// lib/views/history_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payt/controllers/History_controller.dart';
import 'package:payt/views/HomePage.dart';

class HistoryPage extends StatelessWidget {
  final RecycleHistoryController controller =
      Get.put(RecycleHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Recycle History',
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
                  child: Align(
                    alignment: Alignment.center,
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
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.recycleHistory.length,
                  itemBuilder: (context, index) {
                    var historyEntry = controller.recycleHistory[index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Entry ${index + 1}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
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
                                    padding: EdgeInsets.only(
                                        bottom:
                                            8), // Adjust the padding value as needed
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
                                    padding: EdgeInsets.only(
                                        bottom:
                                            8), // Adjust the padding value as needed
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
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Text('Plastic'),
                                  ),
                                  TableCell(
                                    child: Text(historyEntry.plastic
                                        .toStringAsFixed(2)),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Text('Glass'),
                                  ),
                                  TableCell(
                                    child: Text(
                                        historyEntry.glass.toStringAsFixed(2)),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Text('Paper'),
                                  ),
                                  TableCell(
                                    child: Text(
                                        historyEntry.paper.toStringAsFixed(2)),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Text('Rubber'),
                                  ),
                                  TableCell(
                                    child: Text(
                                        historyEntry.rubber.toStringAsFixed(2)),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Text('Metal'),
                                  ),
                                  TableCell(
                                    child: Text(
                                        historyEntry.metal.toStringAsFixed(2)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
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
}
