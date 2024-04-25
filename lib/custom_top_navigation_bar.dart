
import 'package:flutter/material.dart';


class CustomTopNavigationBarTestScreen extends StatelessWidget {
  const CustomTopNavigationBarTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
        child: CustomTopNavigationBar(
          tabTitles: const ['Tab 1', 'Tab 2', 'Tab 3'],
          tabViews: [
            Container(color: Colors.blue),
            Container(color: Colors.green),
            Container(color: Colors.orange),
          ],
        ),
      ),
      )
    );
  }
}

class CustomTopNavigationBar extends StatefulWidget {
  final List<String> tabTitles;
  final List<Widget> tabViews;

  const CustomTopNavigationBar({
    Key? key,
    required this.tabTitles,
    required this.tabViews,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomTopNavigationBarState createState() => _CustomTopNavigationBarState();
}

class _CustomTopNavigationBarState extends State<CustomTopNavigationBar> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.tabTitles.length,
            itemBuilder: (context, index) {
              return buildNavItem(index, widget.tabTitles[index]);
            },
          ),
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: widget.tabViews,
          ),
        ),
      ],
    );
  }

  Widget buildNavItem(int index, String title) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: _currentIndex == index ? Colors.blue : Colors.transparent,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: _currentIndex == index ? Colors.white : Colors.blue,
          ),
        ),
      ),
    );
  }
}
