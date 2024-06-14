
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payt/controllers/staff_recycle_controller.dart';
import 'package:payt/views/HomePage.dart';
import 'package:payt/views/HomePage.dart';

class WMSPRecyclePage extends StatelessWidget {
  final StaffRecycleController controller = Get.put(StaffRecycleController());

  // Input controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController plasticController = TextEditingController();
  final TextEditingController glassController = TextEditingController();
  final TextEditingController paperController = TextEditingController();
  final TextEditingController rubberController = TextEditingController();
  final TextEditingController metalController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Calculate the total weight
  void calculateTotalWeight() {
    double plasticWeight = double.tryParse(plasticController.text) ?? 0.0;
    double glassWeight = double.tryParse(glassController.text) ?? 0.0;
    double paperWeight = double.tryParse(paperController.text) ?? 0.0;
    double rubberWeight = double.tryParse(rubberController.text) ?? 0.0;
    double metalWeight = double.tryParse(metalController.text) ?? 0.0;

    double totalWeight =
        plasticWeight + glassWeight + paperWeight + rubberWeight + metalWeight;
    weightController.text = totalWeight.toStringAsFixed(2);
  }

  // Calculate the total payment
  double calculateTotalPayment() {
    double plasticWeight = double.tryParse(plasticController.text) ?? 0.0;
    double glassWeight = double.tryParse(glassController.text) ?? 0.0;
    double paperWeight = double.tryParse(paperController.text) ?? 0.0;
    double rubberWeight = double.tryParse(rubberController.text) ?? 0.0;
    double metalWeight = double.tryParse(metalController.text) ?? 0.0;

    return plasticWeight * 0.2 +
        glassWeight * 0.3 +
        paperWeight * 0.1 +
        rubberWeight * 0.4 +
        metalWeight * 0.5;
  }

  // Calculate the total point
  double calculateTotalPoint(double weight) {
    return weight * 2;
  }

  // Function to show confirmation dialog
  Future<void> showConfirmationDialog(
      BuildContext context,
      String username,
      double weight,
      double plastic,
      double glass,
      double paper,
      double rubber,
      double metal,
      double paymentTotal,
      double point) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Submission'),
          content: Text('Are you sure you want to submit the recycle items?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Update'),
              onPressed: () {
                controller.addRecycleData(
                  username,
                  weight,
                  plastic,
                  glass,
                  paper,
                  rubber,
                  metal,
                  paymentTotal,
                  point,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageStaff()),
                );
              },
            ),
          ],
        );
      },
    );
  }

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
              MaterialPageRoute(builder: (context) => HomePageStaff()),
              (route) => false,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                key: _formKey,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter customer's username",
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Weight (kg)',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: weightController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Total Weight',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Text(
                      'Item',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: Flexible(
                        child: Text('Type'),
                        fit: FlexFit.tight,
                      ),
                    ),
                    DataColumn(
                      label: Flexible(
                        child: Text('Quantity (kg)'),
                        fit: FlexFit.tight,
                      ),
                    ),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('Plastic')),
                      DataCell(TextFormField(
                        controller: plasticController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          calculateTotalWeight();
                        },
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Glass')),
                      DataCell(TextFormField(
                        controller: glassController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          calculateTotalWeight();
                        },
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Paper')),
                      DataCell(TextFormField(
                        controller: paperController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          calculateTotalWeight();
                        },
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Rubber')),
                      DataCell(TextFormField(
                        controller: rubberController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          calculateTotalWeight();
                        },
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Metal')),
                      DataCell(TextFormField(
                        controller: metalController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          calculateTotalWeight();
                        },
                      )),
                    ]),
                  ],
                ),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePageStaff()),
                          );
                        },
                        child: Text('Cancel'),
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                        )),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Retrieve the user input values
                        String username = usernameController.text;
                        double weight =
                            double.tryParse(weightController.text) ?? 0.0;
                        double paymentTotal = calculateTotalPayment();
                        double point = calculateTotalPoint(weight);
                        double plastic =
                            double.tryParse(plasticController.text) ?? 0.0;
                        double glass =
                            double.tryParse(glassController.text) ?? 0.0;
                        double paper =
                            double.tryParse(paperController.text) ?? 0.0;
                        double rubber =
                            double.tryParse(rubberController.text) ?? 0.0;
                        double metal =
                            double.tryParse(metalController.text) ?? 0.0;
                        showConfirmationDialog(
                          context,
                          username,
                          weight,
                          plastic,
                          glass,
                          paper,
                          rubber,
                          metal,
                          paymentTotal,
                          point,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(101, 145, 87, 1),
                      ),
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
