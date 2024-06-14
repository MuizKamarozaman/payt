import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payt/controllers/subscribe_controller.dart';
import 'package:payt/views/HomePage.dart';

class SubscribePage extends StatelessWidget {
  final SubscribeController controller = Get.put(SubscribeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(0, 110, 109, 109),
        elevation: 0,
        title: Text(
          'Subscribe',
          style: TextStyle(color: Colors.black),
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
      child: Column(
        children: <Widget>[
          TextField(
            controller: controller.cardNumber,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Card Number',
            ),
          ),
          SizedBox(height: 10.0),
          TextField(
            controller: controller.expMonth,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Expiry Month',
            ),
          ),
          SizedBox(height: 10.0),
          TextField(
            controller: controller.expYear,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Expiry Year',
            ),
          ),
          SizedBox(height: 10.0),
          TextField(
            controller: controller.cvc,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'CVC',
            ),
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              onPrimary: Colors.white,
            ),
            child: Text('Subscribe'),
            onPressed: controller.subscribe,
          ),
          if (controller.errorMessage.isNotEmpty)
            Text(
              controller.errorMessage.value,
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
        ],
      ),
    );
  }

  Widget buildSubscribedScreen(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You are already subscribed!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
              child: Text('Unsubscribe', style: TextStyle(color: Colors.white)),
              onPressed: controller.unsubscribe,
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              )),
        ],
      ),
    );
  }
}
