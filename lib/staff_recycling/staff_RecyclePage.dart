import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:payt/staff_recycling/staff_Inventory_controller.dart';
import 'package:payt/views/HomePage.dart';

class StaffRecyclePage extends StatelessWidget {
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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Recycle',
          style: textTheme.headline6?.copyWith(color: Colors.green[800]),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green[800],
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Username'),
              SizedBox(height: 8),
              _buildTextField(
                controller: usernameController,
                hintText: "Enter customer's username",
              ),
              SizedBox(height: 16),
              _buildSectionTitle('Total Weight (kg)'),
              SizedBox(height: 8),
              _buildTextField(
                controller: weightController,
                hintText: 'Total Weight',
                readOnly: true,
              ),
              SizedBox(height: 16),
              _buildSectionTitle('Item'),
              SizedBox(height: 8),
              _buildDataTable(context),
              SizedBox(height: 16),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.green[800],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool readOnly = false,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green[800]!),
        ),
      ),
    );
  }

  Widget _buildDataTable(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green[800]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DataTable(
        columns: [
          DataColumn(
            label: Text(
              '',
              style: textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'Type',
              style: textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'Quantity (kg)',
              style: textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
        rows: [
          _buildDataRow(
              'Plastic', 'assets/images/Plastic.png', plasticController),
          _buildDataRow('Glass', 'assets/images/Glass.png', glassController),
          _buildDataRow('Paper', 'assets/images/Paper.png', paperController),
          _buildDataRow('Rubber', 'assets/images/Rubber.png', rubberController),
          _buildDataRow('Metal', 'assets/images/Metal.png', metalController),
        ],
      ),
    );
  }

  DataRow _buildDataRow(
      String type, String assetPath, TextEditingController controller) {
    return DataRow(
      cells: [
        DataCell(Image.asset(assetPath, height: 40, width: 40)),
        DataCell(Text(type)),
        DataCell(TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          onChanged: (value) {
            calculateTotalWeight();
          },
        )),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePageStaff()),
            );
          },
          style: TextButton.styleFrom(
            primary: Colors.green[800],
          ),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Retrieve the user input values
            String username = usernameController.text;
            double weight = double.tryParse(weightController.text) ?? 0.0;
            double paymentTotal = calculateTotalPayment();
            double point = calculateTotalPoint(weight);
            double plastic = double.tryParse(plasticController.text) ?? 0.0;
            double glass = double.tryParse(glassController.text) ?? 0.0;
            double paper = double.tryParse(paperController.text) ?? 0.0;
            double rubber = double.tryParse(rubberController.text) ?? 0.0;
            double metal = double.tryParse(metalController.text) ?? 0.0;
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
            primary: Colors.green[800],
          ),
          child: Text('Submit'),
        ),
      ],
    );
  }
}
