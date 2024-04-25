
import 'package:flutter/material.dart';

class LandingPageScreen extends StatelessWidget {
  const LandingPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product X'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProductImage(),
            const SizedBox(height: 24.0),
            _buildHeadline(),
            const SizedBox(height: 16.0),
            _buildSubheadline(),
            const SizedBox(height: 32.0),
            _buildCTAButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Image.network(
      'https://picsum.photos/250?image=9',
      height: 200.0,
    );
  }

  Widget _buildHeadline() {
    return const Text(
      'Welcome to Product X',
      style: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubheadline() {
    return const Text(
      'Discover the amazing features of Product X and how it can make your life better.',
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.grey,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildCTAButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Implement action for the call-to-action button
        _showSignupDialog(context);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      ),
      child: const Text('Get Started'),
    );
  }

  void _showSignupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign Up for Product X'),
          content: const Text('Sign up now to explore all the features of Product X.'),
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