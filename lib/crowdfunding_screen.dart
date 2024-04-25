
import 'package:flutter/material.dart';

class CrowdfundingScreen extends StatelessWidget {
  const CrowdfundingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crowdfunding'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCampaignImage(),
            const SizedBox(height: 16.0),
            _buildCampaignDetails(),
            const SizedBox(height: 16.0),
            _buildStats(),
            const SizedBox(height: 16.0),
            _buildDonateButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCampaignImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        'https://picsum.photos/250?image=9',
        height: 200.0,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildCampaignDetails() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Campaign Title',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          'Short and compelling campaign description goes here. Highlight the purpose and impact.',
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem('Contributors', '500+'),
        _buildStatItem('Amount Raised', '\$50,000'),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16.0, color: Colors.grey),
        ),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildDonateButton() {
    return ElevatedButton(
      onPressed: () {
        // Add functionality for donation button
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
      ),
      child: const Text('Donate Now'),
    );
  }
}