
import 'package:flutter/material.dart';

class OnboardingScreen20 extends StatefulWidget {
  const OnboardingScreen20({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen20> {
  int currentPage = 0;
  PageController pageController = PageController();

  final List<OnboardingPage> onboardingPages = [
    OnboardingPage(
      emoji: '😊',
      title: 'Welcome to the Fun Zone!',
      content: 'Get ready to explore a world of joy and excitement.',
    ),
    OnboardingPage(
      emoji: '🚀',
      title: 'Launch Your Adventures',
      content: 'Embark on thrilling journeys with just a tap!',
    ),
    OnboardingPage(
      emoji: '🌟',
      title: 'Discover New Horizons',
      content: 'Uncover amazing features and surprises along the way.',
    ),
    OnboardingPage(
      emoji: '🎉',
      title: 'Let the Fun Begin!',
      content: 'Join us now and start the party. It\'s time to play!',
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
  final String emoji;
  final String title;
  final String content;

  OnboardingPage({
    required this.emoji,
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
            onboardingPage.emoji,
            style: const TextStyle(
              fontSize: 48.0,
            ),
          ),
          const SizedBox(height: 20.0),
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