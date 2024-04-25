
import 'package:flutter/material.dart';

class CreditCardCheckoutScreen extends StatefulWidget {
  const CreditCardCheckoutScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreditCardCheckoutScreenState createState() => _CreditCardCheckoutScreenState();
}

class _CreditCardCheckoutScreenState extends State<CreditCardCheckoutScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credit Card Checkout'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCardNumberField(),
            const SizedBox(height: 16.0),
            _buildExpiryDateField(),
            const SizedBox(height: 16.0),
            _buildCVVField(),
            const SizedBox(height: 24.0),
            _buildCheckoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCardNumberField() {
    return TextFormField(
      controller: _cardNumberController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Card Number',
        hintText: 'XXXX XXXX XXXX XXXX',
        prefixIcon: Icon(Icons.credit_card),
      ),
    );
  }

  Widget _buildExpiryDateField() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _expiryDateController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Expiry Date',
              hintText: 'MM/YY',
              prefixIcon: Icon(Icons.calendar_today),
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: TextFormField(
            controller: _cvvController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'CVV',
              hintText: 'XXX',
              prefixIcon: Icon(Icons.lock),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCVVField() {
    return TextFormField(
      controller: _cvvController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'CVV',
        hintText: 'XXX',
        prefixIcon: Icon(Icons.lock),
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return ElevatedButton(
      onPressed: () {
        // Implement payment logic here
        _showPaymentConfirmation();
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
      child: const Text('Checkout'),
    );
  }

  void _showPaymentConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Successful'),
          content: const Text('Thank you for your purchase!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}