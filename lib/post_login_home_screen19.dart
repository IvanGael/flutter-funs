import 'package:flutter/material.dart';

class PostLoginHomeScreen19 extends StatefulWidget {
  const PostLoginHomeScreen19({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<PostLoginHomeScreen19> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Gradient Tab Home Screen'),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo, Colors.deepPurple],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const TabBarView(
              physics:
                  NeverScrollableScrollPhysics(), // Disable swipe between tabs
              children: [
                // Content for Tab 1
                Center(
                  child: Text('Tab 1 Content',
                      style: TextStyle(color: Colors.white)),
                ),
                // Content for Tab 2
                Center(
                  child: Text('Tab 2 Content',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Explore',
              ),
            ],
            backgroundColor: Colors.transparent,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Add functionality for the main action
            },
            backgroundColor: Colors.deepOrange,
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ));
  }
}
