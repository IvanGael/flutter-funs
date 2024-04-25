
import 'package:flutter/material.dart';

class OnboardingScreen17 extends StatefulWidget {
  const OnboardingScreen17({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen17> {
  int currentPage = 0;
  PageController pageController = PageController();

  final List<OnboardingPage> onboardingPages = [
    OnboardingPage(
      title: 'Futuristic Design',
      description: 'Experience the future with neon lights and dark mode.',
      imagePath: 'assets/call_illustration.jpg',
    ),
    OnboardingPage(
      title: 'Dark Mode Enabled',
      description: 'Switch to dark mode for a comfortable viewing experience.',
      imagePath: 'assets/make_or_join.jpg',
    ),
    OnboardingPage(
      title: 'Vibrant Neon Colors',
      description: 'Explore vibrant neon colors that highlight key features.',
      imagePath: 'assets/call_illustration.jpg',
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
      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (currentPage > 0) {
                      pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    }
                  },
                  child: const Text('Back'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (currentPage < onboardingPages.length - 1) {
                      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    } else {
                      // Handle button click (e.g., navigate to the next screen)
                    }
                  },
                  child: Text(currentPage == onboardingPages.length - 1 ? 'Get Started' : 'Next'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String imagePath;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.imagePath,
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
              color: Colors.cyanAccent,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            onboardingPage.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20.0),
          Image.asset(
            onboardingPage.imagePath,
            height: 200.0,
            width: 200.0,
          ),
        ],
      ),
    );
  }
}