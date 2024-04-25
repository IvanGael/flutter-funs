
import 'package:flutter/material.dart';

class OnboardingScreen16 extends StatefulWidget {
  const OnboardingScreen16({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen16> {
  final List<OnboardingCard> onboardingCards = [
    OnboardingCard(
      title: 'Welcome',
      description: 'Explore the amazing features of our app.',
      imagePath: 'assets/call_illustration.jpg',
    ),
    OnboardingCard(
      title: 'Discover New Things',
      description: 'Find exciting content with ease.',
      imagePath: 'assets/make_or_join.jpg',
    ),
    OnboardingCard(
      title: 'Get Started Now',
      description: 'Join us and experience the magic!',
      imagePath: 'assets/call_illustration.jpg',
    ),
  ];

  int currentPage = 0;
  PageController pageController = PageController();

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
        itemCount: onboardingCards.length,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          return OnboardingCardWidget(onboardingCard: onboardingCards[index]);
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
                    if (currentPage < onboardingCards.length - 1) {
                      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    } else {
                      // Handle button click (e.g., navigate to the next screen)
                    }
                  },
                  child: Text(currentPage == onboardingCards.length - 1 ? 'Get Started' : 'Next'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OnboardingCard {
  final String title;
  final String description;
  final String imagePath;

  OnboardingCard({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

class OnboardingCardWidget extends StatelessWidget {
  final OnboardingCard onboardingCard;

  const OnboardingCardWidget({super.key, required this.onboardingCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            onboardingCard.title,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            onboardingCard.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20.0),
          Image.asset(
            onboardingCard.imagePath,
            height: 200.0,
            width: 200.0,
          ),
        ],
      ),
    );
  }
}