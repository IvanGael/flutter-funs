
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class OnboardingScreen26 extends StatefulWidget {
  const OnboardingScreen26({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreen26State createState() => _OnboardingScreen26State();
}

class _OnboardingScreen26State extends State<OnboardingScreen26>
    with AutomaticKeepAliveClientMixin {
  final PageController _pageController = PageController();
  final List<String> images = [
    "assets/cinema1.jpg",
    "assets/cinema2.jpg",
    "assets/cinema3.jpg",
  ];

  final List<String> titles = [
    "Explore the latest movies",
    "Discover upcoming releases",
    "Enjoy a cinematic experience",
  ];

  int _currentPage = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // Set up a timer for automatic image swiping
    const Duration duration = Duration(seconds: 2);
    // Timer.periodic(duration, (Timer timer) {
    //   if (_currentPage < images.length - 1) {
    //     _currentPage++;
    //   } else {
    //     _currentPage = 0;
    //   }
    //   _pageController.animateToPage(
    //     _currentPage,
    //     duration: const Duration(milliseconds: 500),
    //     curve: Curves.easeInOut,
    //   );
    // });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // To keep the state alive during rebuilds

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
              controller: _pageController,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                );
              },
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: Marquee(
                      text: titles.join('   •   '),
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      blankSpace: 50.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the next screen or perform any action
                    },
                    child: const Text("Get Started"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}