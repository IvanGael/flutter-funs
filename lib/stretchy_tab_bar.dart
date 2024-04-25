import 'package:flutter/material.dart';

class StretchyTabBar extends StatefulWidget {
  const StretchyTabBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<StretchyTabBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 5,
                  width: MediaQuery.of(context).size.width / 4,
                  margin: EdgeInsets.only(
                      left: selectedIndex *
                          (MediaQuery.of(context).size.width / 4)),
                  color: Colors.blue,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTab(0, Icons.home),
                  _buildTab(1, Icons.search),
                  _buildTab(2, Icons.favorite),
                  _buildTab(3, Icons.person),
                ],
              ),
            ],
          ),
        ),
        // Add your tab content here
        // IndexedStack(
        //   index: selectedIndex,
        //   children: [
        //     Container(color: Colors.red),
        //     Container(color: Colors.green),
        //     Container(color: Colors.blue),
        //     Container(color: Colors.yellow),
        //   ],
        // ),
      ],
    );
  }

  Widget _buildTab(int index, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Icon(
          icon,
          size: 30,
          color: index == selectedIndex ? Colors.blue : Colors.white,
        ),
      ),
    );
  }
}
