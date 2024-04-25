import 'package:flutter/material.dart';

class PressScreen extends StatelessWidget {
  const PressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TechWorld Inc. Press Page'),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://picsum.photos/250?image=22',
              height: 100,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Latest News',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const PressCard(
              title: 'TechWorld Unveils Revolutionary Product X',
              date: 'Feb 29, 2024',
              imageUrl: 'https://picsum.photos/250?image=25',
            ),
            const PressCard(
              title: 'TechWorld Partners with Global Innovators',
              date: 'Feb 28, 2024',
              imageUrl: 'https://picsum.photos/250?image=36',
            ),
            // Add more PressCards as needed
          ],
        ),
      ),
    );
  }
}

class PressCard extends StatelessWidget {
  final String title;
  final String date;
  final String imageUrl;

  const PressCard({super.key, 
    required this.title,
    required this.date,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageUrl,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
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
                  'Published on $date',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}