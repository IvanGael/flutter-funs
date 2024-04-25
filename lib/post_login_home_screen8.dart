
import 'package:flutter/material.dart';

class PostLoginHomeScreen8 extends StatelessWidget {
  const PostLoginHomeScreen8({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Sheet Home Screen'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            elevation: 4.0,
            child: InkWell(
              onTap: () {
                // Add functionality for the main action
                _showBottomSheet(context);
              },
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.handshake,
                    size: 48.0,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 8.0),
                  Text('Main Action'),
                ],
              ),
            ),
          ),
          // Add more cards or content as needed
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Bottom Sheet Menu',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
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
              // Add more list items as needed
            ],
          ),
        );
      },
    );
  }
}