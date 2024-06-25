import 'package:flutter/material.dart';

import 'package:payt/views/HomePage.dart';
import 'package:payt/pickup/pickup_controller.dart';

class PickupView extends StatefulWidget {
  @override
  _PickupViewState createState() => _PickupViewState();
}

class _PickupViewState extends State<PickupView> {
  final PickupController _controller = PickupController();
  List<Map<String, dynamic>> dataFromDatabase = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<Map<String, dynamic>> pickupData = await _controller.getPickupData();
    setState(() {
      dataFromDatabase = pickupData;
    });
  }

  Future<void> showConfirmationDialog(String username, String requestId) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Update'),
          content: Text('Are you sure you want to update the approval status?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: Text('Update'),
              onPressed: () async {
                await _controller.updateStatus(username, requestId);
                Navigator.of(context).pop();
                fetchData();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> pendingApprovalData =
        dataFromDatabase.where((data) => data['status'] == false).toList();
    List<Map<String, dynamic>> approvedData =
        dataFromDatabase.where((data) => data['status'] == true).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Manage Request',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSectionTitle('Pending Approval'),
                _buildRequestTable(pendingApprovalData, isPending: true),
                SizedBox(height: 32),
                _buildSectionTitle('Approved Request'),
                _buildRequestTable(approvedData),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildRequestTable(List<Map<String, dynamic>> data,
      {bool isPending = false}) {
    return Container(
      width: double.infinity,
      child: data.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTableHeader(),
                Divider(),
                ...data.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> requestData = entry.value;
                  return Column(
                    children: [
                      Container(
                        color: index % 2 == 0 ? Colors.white : Colors.grey[200],
                        child:
                            _buildTableRow(requestData, isPending: isPending),
                      ),
                      Divider(),
                    ],
                  );
                }).toList(),
              ],
            )
          : Container(
              width: double.infinity,
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isPending ? 'No pending approval' : 'No approved requests',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text('Username',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              child:
                  Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              child:
                  Text('Time', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              child: Text('Location',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          SizedBox(width: 50), // for the button or phone number
        ],
      ),
    );
  }

  Widget _buildTableRow(Map<String, dynamic> requestData,
      {bool isPending = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(requestData['username'])),
          Expanded(child: Text(requestData['date'])),
          Expanded(child: Text(requestData['time'])),
          Expanded(child: Text(requestData['location'])),
          isPending
              ? IconButton(
                  icon: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 30,
                  ),
                  onPressed: () {
                    showConfirmationDialog(
                        requestData['username'], requestData['id']);
                  },
                )
              : Text('0${requestData['telno']}'),
        ],
      ),
    );
  }
}
