import 'package:flutter/material.dart';

class PostLoginHomeScreen12 extends StatefulWidget {
  const PostLoginHomeScreen12({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<PostLoginHomeScreen12> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Profile Home Screen'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  // Add functionality for settings
                },
              ),
            ],
          ),
          body: const TabBarView(
            children: [
              // Content for Tab 1
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/call_illustration.jpg'),
                ),
              ),
              // Content for Tab 2
              Center(
                child: Text('Explore and enjoy!'),
              ),
            ],
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
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Explore',
              ),
            ],
          ),
        ));
  }
}
