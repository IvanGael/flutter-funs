
import 'dart:async';

import 'package:flutter/material.dart';

class OnboardingScreen31 extends StatefulWidget {
  const OnboardingScreen31({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen31> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<String> titles = [
    'Welcome',
    'Discover Amazing Features',
    'Get Started Now',
  ];

  List<String> descriptions = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    'Explore the fantastic features we offer to you.',
    'Start your journey and enjoy the experience.',
  ];

  List<String> images = [
    'assets/bank2.jpg',
    'assets/bank1.jpg',
    'assets/bank3.jpg',
  ];

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_currentPage < titles.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: titles.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          return PulseOnboardingPage(
            title: titles[index],
            description: descriptions[index],
            imageAsset: images[index],
            currentPage: _currentPage,
            pageIndex: index,
          );
        },
      ),
    );
  }
}

class PulseOnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageAsset;
  final int currentPage;
  final int pageIndex;

  const PulseOnboardingPage({super.key, 
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.currentPage,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    final pulseValue = 1.0 - ((currentPage - pageIndex).abs() * 0.2).clamp(0.0, 1.0);

    return AnimatedBuilder(
      animation: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: ModalRoute.of(context)!.animation!,
          curve: Curves.decelerate,
        ),
      ),
      builder: (context, child) {
        return Transform.scale(
          scale: pulseValue,
          child: child,
        );
      },
      child: OnboardingPage(
        title: title,
        description: description,
        imageAsset: imageAsset,
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageAsset;

  const OnboardingPage({super.key, required this.title, required this.description, required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageAsset,
            width: double.infinity,
            height: 400,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20.0),
          Text(
            title,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}