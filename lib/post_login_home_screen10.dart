
import 'package:flutter/material.dart';

class PostLoginHomeScreen10 extends StatelessWidget {
  const PostLoginHomeScreen10({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Background Home Screen'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/call_illustration.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Option 1'),
              onTap: () {
                // Handle option 1
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Option 2'),
              onTap: () {
                // Handle option 2
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            elevation: 4.0,
            child: InkWell(
              onTap: () {
                // Add functionality for Card 1
              },
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 48.0,
                    color: Colors.amber,
                  ),
                  SizedBox(height: 8.0),
                  Text('Card 1'),
                ],
              ),
            ),
          ),
          Card(
            elevation: 4.0,
            child: InkWell(
              onTap: () {
                // Add functionality for Card 2
              },
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 48.0,
                    color: Colors.amber,
                  ),
                  SizedBox(height: 8.0),
                  Text('Card 2'),
                ],
              ),
            ),
          ),
          // Add more cards as needed
        ],
      ),
    );
  }
}