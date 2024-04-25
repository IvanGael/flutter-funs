
import 'package:flutter/material.dart';

class OnboardingScreen8 extends StatelessWidget {
  final List<OnboardingPage> onboardingPages = [
    OnboardingPage(
      title: 'Welcome to MyApp',
      description: 'Explore the amazing features',
      imageUrl: 'assets/call_illustration.jpg',
    ),
    OnboardingPage(
      title: 'Discover New Things',
      description: 'Find exciting content with ease',
      imageUrl: 'assets/make_or_join.jpg',
    ),
    OnboardingPage(
      title: 'Get Started Now',
      description: 'Join us and experience the magic!',
      imageUrl: 'assets/call_illustration.jpg',
    ),
  ];

  OnboardingScreen8({super.key});

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
  final String imageUrl;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage onboardingPage;

  const OnboardingPageWidget({super.key, required this.onboardingPage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          onboardingPage.imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Container(
          color: Colors.black.withOpacity(0.5),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
        ),
      ],
    );
  }
}