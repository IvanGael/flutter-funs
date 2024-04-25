
import 'package:flutter/material.dart';

class OnboardingScreen32 extends StatefulWidget {
  const OnboardingScreen32({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen32>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  int _currentPage = 0;

  List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      title: 'Welcome to MyApp',
      description: 'Discover amazing features with our app.',
      image: 'assets/call_illustration.jpg',
      backgroundColor: Colors.black12,
    ),
    OnboardingItem(
      title: 'Explore',
      description: 'Explore a world of possibilities with MyApp.',
      image: 'assets/make_or_join.jpg',
      backgroundColor: Colors.black12,
    ),
    OnboardingItem(
      title: 'Get Started',
      description: 'Get started now and enjoy the journey.',
      image: 'assets/bank1.jpg',
      backgroundColor: Colors.black12,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingItems.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
                _animationController.forward(from: 0.0);
              });
            },
            itemBuilder: (context, index) {
              return OnboardingItemWidget(onboardingItems[index]);
            },
          ),
          Positioned(
            bottom: 16.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingItems.length,
                (index) => _buildDot(index),
              ),
            ),
          ),
          Positioned(
            bottom: 28.0,
            left: 16.0,
            right: 16.0,
            child: AnimatedOpacity(
              opacity: _currentPage == onboardingItems.length - 1 ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the next screen or perform any action
                  // when the user reaches the last onboarding screen.
                },
                child: const Text('Get Started'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 8.0,
      height: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index == _currentPage ? Colors.white : Colors.grey,
      ),
    );
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final String image;
  final Color backgroundColor;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
    required this.backgroundColor,
  });
}

class OnboardingItemWidget extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingItemWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: item.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: item.image,
            child: Image.asset(
              item.image,
              height: 200.0,
            ),
          ),
          const SizedBox(height: 32.0),
          FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: ModalRoute.of(context)!.animation!,
                curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
              ),
            ),
            child: Text(
              item.title,
              style: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: ModalRoute.of(context)!.animation!,
                curve: const Interval(0.6, 1.0, curve: Curves.easeInOut),
              ),
            ),
            child: Text(
              item.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}