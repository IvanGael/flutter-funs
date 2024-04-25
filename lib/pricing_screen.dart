
import 'package:flutter/material.dart';

class PricingScreen extends StatelessWidget {
  const PricingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pricing'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPricingCard('Basic', '\$9.99/month', 'Perfect for startups'),
            const SizedBox(height: 16.0),
            _buildPricingCard('Pro', '\$19.99/month', 'Great for growing businesses'),
            const SizedBox(height: 16.0),
            _buildPricingCard('Enterprise', 'Contact us', 'Custom solutions for large enterprises'),
          ],
        ),
      ),
    );
  }

  Widget _buildPricingCard(String title, String price, String description) {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              price,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(description),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                // Implement subscription logic based on the selected plan
              },
              child: const Text('Select Plan'),
            ),
          ],
        ),
      ),
    );
  }
}