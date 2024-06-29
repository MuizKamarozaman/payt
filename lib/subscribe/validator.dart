class Validator {
  String? validateSubscribeFields({
    required String cardNumber,
    required String expMonth,
    required String expYear,
    required String cvc,
  }) {
    if (cardNumber.isEmpty) {
      return 'Please fill in the Card Number field.';
    } else if (expMonth.isEmpty) {
      return 'Please fill in the Expiry Month field.';
    } else if (expYear.isEmpty) {
      return 'Please fill in the Expiry Year field.';
    } else if (cvc.isEmpty) {
      return 'Please fill in the CVC field.';
    }
    // Add more validations as needed
    return null;
  }
}
