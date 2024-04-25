
import 'package:flutter/material.dart';

class PostLoginHomeScreen16 extends StatelessWidget {
  const PostLoginHomeScreen16({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          title: const Text('Curved AppBar Home Screen'),
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: 6, // Number of grid items
        itemBuilder: (context, index) {
          return Card(
            elevation: 4.0,
            child: InkWell(
              onTap: () {
                // Add functionality for each grid item
              },
              child: Image.network(
                'https://picsum.photos/250?image=$index', 
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality for the main action
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomSheet: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
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
    );
  }
}