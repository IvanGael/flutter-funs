
import 'package:flutter/material.dart';

class PostLoginHomeScreen7 extends StatefulWidget {
  const PostLoginHomeScreen7({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<PostLoginHomeScreen7> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(200.0),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.indigo],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            bottom: const TabBar(
              indicatorColor: Colors.orange,
              tabs: [
                Tab(text: 'Section 1'),
                Tab(text: 'Section 2'),
                Tab(text: 'Section 3'),
              ],
            ),
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
      ),
    );
  }
}