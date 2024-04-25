
import 'package:flutter/material.dart';

class OnboardingScreen4 extends StatefulWidget {
  const OnboardingScreen4({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen4> {
  final PageController _pageController = PageController();
  int _currentPage = 2; // Set the index for the third screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _buildOnboardingPage(
                "Welcome to My App",
                "This is a sample onboarding screen.",
                "assets/call_illustration.jpg",
              ),
              _buildOnboardingPage(
                "Explore Features",
                "Discover amazing features with our app.",
                "assets/make_or_join.jpg",
              ),
              _buildOnboardingPage(
                "Custom Style",
                "This is the third onboarding screen with a different style.",
                "assets/call_illustration.jpg",
              ),
            ],
          ),
          Positioned(
            bottom: 50.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3, // Set the total number of onboarding screens
                (index) => _buildDot(index),
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: ElevatedButton(
              onPressed: () {
                // Handle the onboarding completion
                // Typically navigate to the home screen
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => HomeScreen(),
                //   ),
                // );
              },
              child: Text(_currentPage == 2 ? "Done" : "Next"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(String title, String body, String imagePath) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0),
          Text(
            body,
            style: const TextStyle(fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30.0),
          Image.asset(
            imagePath,
            height: 200.0,
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: 12.0,
      height: 12.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.blue : Colors.grey,
      ),
    );
  }
}