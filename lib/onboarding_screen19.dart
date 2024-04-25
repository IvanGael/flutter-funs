
import 'package:flutter/material.dart';

class OnboardingScreen19 extends StatefulWidget {
  const OnboardingScreen19({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen19> {
  int currentPage = 0;
  PageController pageController = PageController();

  final List<OnboardingPage> onboardingPages = [
    OnboardingPage(
      title: 'Welcome to Time-Triggered Animations',
      description: 'Explore dynamic animations triggered by the time you spend on each screen.',
    ),
    OnboardingPage(
      title: 'Engaging Experience',
      description: 'Discover a more personalized onboarding with time-driven animations.',
    ),
    OnboardingPage(
      title: 'Get Started Now',
      description: 'Join us and experience the magic of time-triggered animations.',
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
          return OnboardingPageWidget(onboardingPage: onboardingPages[index], pageController: pageController,);
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

  OnboardingPage({
    required this.title,
    required this.description,
  });
}

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage onboardingPage;
  final PageController pageController;

  const OnboardingPageWidget({super.key, required this.onboardingPage, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        double value = 1.0;
        if (pageController.position.haveDimensions) {
          value = pageController.page! - onboardingPage.title.length / 3.0;
          value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
        }
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                onboardingPage.title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(value),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                onboardingPage.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey.withOpacity(value),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}