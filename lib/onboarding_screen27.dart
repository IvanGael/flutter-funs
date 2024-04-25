
import 'package:flutter/material.dart';

class OnboardingScreen27 extends StatefulWidget {
  const OnboardingScreen27({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen27> {
  final PageController _pageController = PageController(initialPage: 0);

  List<Map<String, String>> onboardingData = [
    {
      'title': 'Welcome to Our Bank',
      'description': 'Your trusted partner for financial services',
      'image': 'assets/bank1.jpg',
    },
    {
      'title': 'Secure Transactions',
      'description': 'We prioritize the security of your transactions',
      'image': 'assets/bank2.jpg',
    },
    {
      'title': 'Easy Banking Anytime, Anywhere',
      'description': 'Access your account 24/7 with our mobile app',
      'image': 'assets/bank3.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: onboardingData.length,
        itemBuilder: (context, index) {
          return OnboardingPage(
            title: onboardingData[index]['title']!,
            description: onboardingData[index]['description']!,
            image: onboardingData[index]['image']!,
            onPageChanged: (pageIndex) {
              
            },
          );
        },
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final Function(int)? onPageChanged;

  const OnboardingPage({super.key, 
    required this.title,
    required this.description,
    required this.image,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 400,
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}