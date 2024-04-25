
import 'package:flutter/material.dart';

class OnboardingScreen11 extends StatefulWidget {
  const OnboardingScreen11({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen11> {
  final List<OnboardingPage> onboardingPages = [
    OnboardingPage(
      title: 'Welcome',
      description: 'Explore the amazing features',
    ),
    OnboardingPage(
      title: 'Discover New Things',
      description: 'Find exciting content with ease',
    ),
    OnboardingPage(
      title: 'Get Started Now',
      description: 'Join us and experience the magic!',
    ),
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: onboardingPages.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPageWidget(onboardingPage: onboardingPages[index]);
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingPages.length,
                  (index) => buildDot(index: index),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: buildProgressBar(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot({required int index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: currentPage == index ? 15.0 : 10.0,
        height: currentPage == index ? 15.0 : 10.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: currentPage == index ? Colors.indigo : Colors.grey,
        ),
      ),
    );
  }

  Widget buildProgressBar() {
    double progress = (currentPage + 1) / onboardingPages.length;

    return SizedBox(
      width: 200.0,
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: Colors.grey,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.indigo),
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
            color: Colors.white,
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