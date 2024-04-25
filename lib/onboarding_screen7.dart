
import 'package:flutter/material.dart';

class OnboardingScreen7 extends StatelessWidget {
  final List<OnboardingPage> onboardingPages = [
    OnboardingPage(
      title: 'Welcome',
      description: 'Explore the amazing features',
      gradientColors: [Colors.indigo, Colors.green],
      icon: Icons.explore,
    ),
    OnboardingPage(
      title: 'Discover New Things',
      description: 'Find exciting content with ease',
      gradientColors: [Colors.orange, Colors.purple],
      icon: Icons.search,
    ),
    OnboardingPage(
      title: 'Get Started Now',
      description: 'Join us and experience the magic!',
      gradientColors: [Colors.red, Colors.cyan],
      icon: Icons.play_arrow,
    ),
  ];

  OnboardingScreen7({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: onboardingPages.length,
        itemBuilder: (context, index) {
          return OnboardingPageWidget(onboardingPage: onboardingPages[index]);
        },
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final List<Color> gradientColors;
  final IconData icon;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.gradientColors,
    required this.icon,
  });
}

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage onboardingPage;

  const OnboardingPageWidget({super.key, required this.onboardingPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: onboardingPage.gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            onboardingPage.icon,
            size: 150.0,
            color: Colors.white,
          ),
          const SizedBox(height: 30.0),
          Text(
            onboardingPage.title,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            onboardingPage.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}