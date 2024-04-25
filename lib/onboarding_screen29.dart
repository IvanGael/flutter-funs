
import 'package:flutter/material.dart';

class OnboardingScreen29 extends StatefulWidget {
  const OnboardingScreen29({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen29> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
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
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              _animationController.animateTo(index / 2);
              setState(() {
                currentPage = index;
              });
            },
            children: const [
              OnboardingPage(
                title: "Welcome",
                description: "One-stop solution for shipping and receiving parcels.",
                imagePath: "assets/parcel1.jpg",
              ),
              OnboardingPage(
                title: "Easy Shipping",
                description: "Ship your parcels hassle-free with our user-friendly interface.",
                imagePath: "assets/parcel2.jpg",
              ),
              OnboardingPage(
                title: "Secure Receiving",
                description: "Receive parcels securely and track them in real-time.",
                imagePath: "assets/parcel3.jpg",
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => buildDot(index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        double scale = 1.0;
        if (_animationController.value > index && _animationController.value < index + 1) {
          scale = 1.5 - (_animationController.value - index).abs();
        } else if (_animationController.value <= index) {
          scale = 1.0;
        } else if (_animationController.value >= index + 1) {
          scale = 0.5;
        }
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentPage ? Colors.blue : Colors.grey,
          ),
          child: Transform.scale(
            scale: scale,
            child: child,
          ),
        );
      },
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingPage({super.key, 
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 30),
        Image.asset(
          imagePath,
          width: 370,
          height: 200,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}