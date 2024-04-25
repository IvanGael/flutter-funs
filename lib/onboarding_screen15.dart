
import 'package:flutter/material.dart';

class OnboardingScreen15 extends StatefulWidget {
  const OnboardingScreen15({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen15> {
  int currentPage = 0;

  final List<OnboardingPage> onboardingPages = [
    OnboardingPage(
      title: 'Swipe to Navigate',
      description: 'Swipe left or right to navigate through the tutorial.',
    ),
    OnboardingPage(
      title: 'Tap to Interact',
      description: 'Tap on elements to interact and learn more.',
    ),
    OnboardingPage(
      title: 'Explore Features',
      description: 'Explore different features of the app interactively.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            // Swipe right
            if (currentPage > 0) {
              setState(() {
                currentPage--;
              });
            }
          } else if (details.primaryVelocity! < 0) {
            // Swipe left
            if (currentPage < onboardingPages.length - 1) {
              setState(() {
                currentPage++;
              });
            }
          }
        },
        child: Stack(
          children: [
            PageView.builder(
              itemCount: onboardingPages.length,
              itemBuilder: (context, index) {
                return OnboardingPageWidget(onboardingPage: onboardingPages[index]);
              },
              physics: const AlwaysScrollableScrollPhysics(),
              controller: PageController(initialPage: currentPage),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button click (e.g., navigate to the next screen)
                  },
                  child: Text(currentPage == onboardingPages.length - 1 ? 'Get Started' : 'Next'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;

  OnboardingPage({
    required this.title,
    required this.description,
  });
}

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage onboardingPage;

  const OnboardingPageWidget({super.key, required this.onboardingPage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          onboardingPage.title,
          style: const TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20.0),
        Text(
          onboardingPage.description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}