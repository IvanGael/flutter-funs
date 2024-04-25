import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        title: const Text('Invoice'),
        backgroundColor: const Color(0xFF3498DB),
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const InvoiceWidget(),
            const SizedBox(height: 20),
            Center(
            child: ElevatedButton(
              onPressed: () {
                // Handle payment button click
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3498DB),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                  'Pay Now',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          ],
        ),
      ),
      ),
    );
  }
}

class InvoiceWidget extends StatelessWidget {
  const InvoiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Invoice #12345',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3498DB)),
          ),
          const SizedBox(height: 10),
          const Text(
                'Due Date: March 10, 2024',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
          const SizedBox(height: 20),
          const Text(
            'Bill To:',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3498DB)),
          ),
          const Text('Client Name', style: TextStyle(fontSize: 18)),
          const Text('Client Company', style: TextStyle(fontSize: 18)),
          const Text('123 Client Street, City', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
          const Text(
            'Services:',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3498DB)),
          ),
          const Text('1. Web Design', style: TextStyle(fontSize: 18)),
          const Text('2. Software Development', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
          const Text(
            'Total Amount:',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3498DB)),
          ),
          const Text('\$5000',
              style: TextStyle(fontSize: 24, color: Colors.green)),
          const SizedBox(height: 20),
          SizedBox(
            width: 100,
            height: 100,
            child: QrImageView(
              data: 'This is a simple QR code',
              version: QrVersions.auto,
              size: 320,
              gapless: false,
            ),
          ),
        ],
      ),
    );
  }
}
