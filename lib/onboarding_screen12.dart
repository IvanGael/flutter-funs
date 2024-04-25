import 'package:flutter/material.dart';

class OnboardingScreen12 extends StatefulWidget {
  const OnboardingScreen12({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen12> {
  final List<OnboardingPage> onboardingPages = [
    OnboardingPage(
      title: 'Welcome to MyApp',
      description: 'Explore the amazing features',
      imageUrl: 'assets/call_illustration.jpg',
    ),
    OnboardingPage(
      title: 'Discover New Things',
      description: 'Find exciting content with ease',
      imageUrl: 'assets/make_or_join.jpg',
    ),
    OnboardingPage(
      title: 'Get Started Now',
      description: 'Join us and experience the magic!',
      imageUrl: 'assets/call_illustration.jpg',
    ),
  ];

  PageController pageController = PageController();
  double? initialPage = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        initialPage = pageController.page;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return PageView.builder(
            controller: pageController,
            itemCount: onboardingPages.length,
            itemBuilder: (context, index) {
              double parallax = (initialPage ?? 0) - index.toDouble();
              parallax = parallax.abs();

              return OnboardingPageWidget(
                onboardingPage: onboardingPages[index],
                parallax: parallax,
              );
            },
          );
        },
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String imageUrl;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage onboardingPage;
  final double parallax;

  const OnboardingPageWidget({super.key, 
    required this.onboardingPage,
    required this.parallax,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateY(parallax),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(onboardingPage.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              onboardingPage.title,
              style: const TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              onboardingPage.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}