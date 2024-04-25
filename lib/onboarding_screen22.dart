
import 'package:flutter/material.dart';

class OnboardingScreen22 extends StatefulWidget {
  const OnboardingScreen22({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen22> {
  int currentPage = 0;
  PageController pageController = PageController();
  bool fabVisible = true;

  final List<OnboardingPage> onboardingPages = [
    OnboardingPage(
      title: 'Welcome to Our App!',
      content: 'Discover amazing features that make your experience unique.',
    ),
    OnboardingPage(
      title: 'Customization Options',
      content: 'Personalize your app with themes, colors, and much more.',
    ),
    OnboardingPage(
      title: 'Connect and Share',
      content: 'Connect with friends, share experiences, and make memories.',
    ),
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void toggleFabVisibility(int page) {
    setState(() {
      fabVisible = page < onboardingPages.length - 1;
    });
  }

  void onFabTap() {
    if (currentPage < onboardingPages.length - 1) {
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      // Handle FAB tap on the last page (e.g., navigate to the next screen)
    }
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
            toggleFabVisibility(index);
          });
        },
        itemBuilder: (context, index) {
          return OnboardingPageWidget(onboardingPage: onboardingPages[index]);
        },
      ),
      floatingActionButton: fabVisible
          ? FloatingActionButton(
              onPressed: onFabTap,
              child: const Icon(Icons.arrow_forward),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class OnboardingPage {
  final String title;
  final String content;

  OnboardingPage({
    required this.title,
    required this.content,
  });
}

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage onboardingPage;

  const OnboardingPageWidget({super.key, required this.onboardingPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            onboardingPage.title,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            onboardingPage.content,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}