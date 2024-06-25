import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:payt/subscribe/subscribe_model.dart';
import 'package:payt/subscribe/validator.dart';
import 'package:payt/views/HomePage.dart';

class SubscribeController extends GetxController {
  final SubscribeModel _subscribeModel = SubscribeModel();
  final cardNumber = TextEditingController();
  final expMonth = TextEditingController();
  final expYear = TextEditingController();
  final cvc = TextEditingController();
  var cardNumberErrorMessage = ''.obs;
  var expMonthErrorMessage = ''.obs;
  var expYearErrorMessage = ''.obs;
  var cvcErrorMessage = ''.obs;
  final _validator = Validator();
  var errorMessage = ''.obs;
  var isSubscribed = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkSubscriptionStatus();
  }

  Future<void> checkSubscriptionStatus() async {
    isSubscribed.value = await _subscribeModel.checkSubscriptionStatus();
  }

  void subscribe() async {
    clearErrorMessages();
    final cardNumberValue = cardNumber.text.trim();
    final expMonthValue = expMonth.text.trim();
    final expYearValue = expYear.text.trim();
    final cvcValue = cvc.text.trim();

    if (cardNumberValue.isEmpty ||
        expMonthValue.isEmpty ||
        expYearValue.isEmpty ||
        cvcValue.isEmpty) {
      Get.defaultDialog(
        title: 'Incomplete Information',
        content: Text('Please fill in all the fields.'),
        confirm: TextButton(
          child: Text('OK'),
          onPressed: () {
            Get.back();
          },
        ),
      );
      return;
    }

    final validationMessage = _validator.validateSubscribeFields(
      cardNumber: cardNumberValue,
      expMonth: expMonthValue,
      expYear: expYearValue,
      cvc: cvcValue,
    );

    if (validationMessage != null) {
      setErrorMessages(validationMessage);
      return;
    }

    try {
      await _subscribeModel.subscribeUser();
      isSubscribed.value = true; // Update isSubscribed to true
      Get.defaultDialog(
        title: 'Subscription Successful!',
        content: Icon(Icons.check_circle, color: Colors.green, size: 100),
        barrierDismissible: false,
        confirm: TextButton(
          child: Text(
            'Proceed to Home Page',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green),
          ),
          onPressed: () {
            Get.offAll(() => HomePageUser());
          },
        ),
      );
    } catch (e) {}
  }

  void unsubscribe() async {
    try {
      await _subscribeModel.unsubscribeUser();
      isSubscribed.value = false; // Update isSubscribed to false
      Get.defaultDialog(
        title: 'Unsubscribed',
        content: Text('You have been unsubscribed.'),
        barrierDismissible: false,
        confirm: TextButton(
          child: Text(
            'OK',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Get.back();
          },
        ),
      );
    } catch (e) {}
  }

  void clearErrorMessages() {
    errorMessage.value = '';
    cardNumberErrorMessage.value = '';
    expMonthErrorMessage.value = '';
    expYearErrorMessage.value = '';
    cvcErrorMessage.value = '';
  }

  void setErrorMessages(String validationMessage) {
    switch (validationMessage) {
      case 'Please fill in the Card Number field.':
        cardNumberErrorMessage.value = validationMessage;
        break;
      case 'Please fill in the Expiry Month field.':
        expMonthErrorMessage.value = validationMessage;
        break;
      case 'Please fill in the Expiry Year field.':
        expYearErrorMessage.value = validationMessage;
        break;
      case 'Please fill in the CVC field.':
        cvcErrorMessage.value = validationMessage;
        break;
    }
  }
}
