
import 'package:flutter/material.dart';

class PostLoginHomeScreen4 extends StatefulWidget {
  const PostLoginHomeScreen4({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<PostLoginHomeScreen4> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gradient Home Screen'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Section 1'),
              Tab(text: 'Section 2'),
              Tab(text: 'Section 3'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            // Content for Section 1
            Center(
              child: Text('Section 1 Content'),
            ),
            // Content for Section 2
            Center(
              child: Text('Section 2 Content'),
            ),
            // Content for Section 3
            Center(
              child: Text('Section 3 Content'),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add functionality for the main action of your home screen
          },
          child: const Icon(Icons.add),
        ),
        backgroundColor: Colors.transparent, // Set background color to transparent
        extendBodyBehindAppBar: true, // Extend background behind the app bar
      ),
    );
  }
}