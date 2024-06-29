import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:payt/subscribe/subscribe_controller.dart';
import 'package:payt/views/HomePage.dart';

class SubscribePage extends StatelessWidget {
  final SubscribeController controller = Get.put(SubscribeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Subscribe',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Obx(() {
        return controller.isSubscribed.value
            ? buildSubscribedScreen(context)
            : buildSubscribeForm(context);
      }),
    );
  }

  Widget buildSubscribeForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Subscribe to our Premium Plan',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Enjoy exclusive features such as:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5.0),
            Text(
              '• Request Pickup\n• Priority Support\n• Exclusive Offers',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: controller.cardNumber,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Card Number',
                prefixIcon: Icon(Icons.credit_card),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 15.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.expMonth,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Expiry Month',
                      prefixIcon: Icon(Icons.date_range),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: TextField(
                    controller: controller.expYear,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Expiry Year',
                      prefixIcon: Icon(Icons.date_range),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            TextField(
              controller: controller.cvc,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'CVC',
                prefixIcon: Icon(Icons.lock),
              ),
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                ),
                child: Text('Subscribe Now'),
                onPressed: controller.subscribe,
              ),
            ),
            if (controller.errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  controller.errorMessage.value,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildSubscribedScreen(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 100,
          ),
          SizedBox(height: 20.0),
          Text(
            'You are already subscribed!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            child: Text('Unsubscribe', style: TextStyle(color: Colors.white)),
            onPressed: controller.unsubscribe,
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              textStyle: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
