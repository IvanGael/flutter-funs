
import 'package:flutter/material.dart';

class PostLoginHomeScreen5 extends StatelessWidget {
  const PostLoginHomeScreen5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Colorful Home Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              // Add logout functionality here
              // You may want to navigate back to the login screen or show a confirmation dialog
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.amberAccent, // Set custom background color
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: const [
            Text(
              'Welcome to Your Colorful App!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('Feature 1'),
              subtitle: Text('Description of feature 1.'),
            ),
            ListTile(
              title: Text('Feature 2'),
              subtitle: Text('Description of feature 2.'),
            ),
            // Add more list items as needed
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality for the main action of your home screen
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Custom shape for FAB
        ),
        child: const Icon(Icons.star),
      ),
    );
  }
}