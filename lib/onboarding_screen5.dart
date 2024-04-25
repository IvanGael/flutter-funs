
import 'package:flutter/material.dart';

class OnboardingScreen5 extends StatefulWidget {
  const OnboardingScreen5({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen5> {
  final PageController _pageController = PageController();
  int _currentPage = 3; // Set the index for the fourth screen

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
              _buildDifferentStyleOnboardingPage(),
            ],
          ),
          Positioned(
            bottom: 50.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4, // Set the total number of onboarding screens
                (index) => _buildDot(index),
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: ElevatedButton(
              onPressed: () {
                if (_currentPage == 3) {
                  // Handle the onboarding completion
                  // Typically navigate to the home screen
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => HomeScreen(),
                  //   ),
                  // );
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                }
              },
              child: Text(_currentPage == 3 ? "Done" : "Next"),
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

  Widget _buildDifferentStyleOnboardingPage() {
    return Container(
      color: Colors.green, // Set a different background color
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "New Features",
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 20.0),
          const Text(
            "Discover exciting new features in our latest update.",
            style: TextStyle(fontSize: 18.0, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30.0),
          Image.asset(
            "assets/make_or_join.jpg", // Use a different image
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