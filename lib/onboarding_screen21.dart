
import 'package:flutter/material.dart';

class OnboardingScreen21 extends StatefulWidget {
  const OnboardingScreen21({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen21> {
  int currentPage = 0;
  PageController pageController = PageController();

  final List<OnboardingPage> onboardingPages = [
    OnboardingPage(
      title: 'Welcome to Our App!',
      content: 'Discover amazing features that make your experience unique.',
      leftColor: Colors.blue,
      rightColor: Colors.yellow,
    ),
    OnboardingPage(
      title: 'Customization Options',
      content: 'Personalize your app with themes, colors, and much more.',
      leftColor: Colors.green,
      rightColor: Colors.purple,
    ),
    OnboardingPage(
      title: 'Connect and Share',
      content: 'Connect with friends, share experiences, and make memories.',
      leftColor: Colors.orange,
      rightColor: Colors.red,
    ),
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
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
    );
  }
}

class OnboardingPage {
  final String title;
  final String content;
  final Color leftColor;
  final Color rightColor;

  OnboardingPage({
    required this.title,
    required this.content,
    required this.leftColor,
    required this.rightColor,
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
          colors: [onboardingPage.leftColor, onboardingPage.rightColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
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
          const SizedBox(height: 20.0),
          Text(
            onboardingPage.content,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}