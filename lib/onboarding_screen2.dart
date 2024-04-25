import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';


class OnboardingScreen2 extends StatelessWidget {
  final List<PageViewModel> pages = [
    PageViewModel(
      title: "Welcome to My App",
      body: "This is a sample onboarding screen.",
      image: Image.asset("assets/call_illustration.jpg"),
    ),
    PageViewModel(
      title: "Explore Features",
      body: "Discover amazing features with our app.",
      image: Image.asset("assets/make_or_join.jpg"),
    ),
  ];

  OnboardingScreen2({super.key});


  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: pages,
      onDone: () {
        // Handle the onboarding completion
        // Typically navigate to the home screen
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => HomeScreen(),
        //   ),
        // );
      },
      onSkip: () {
        // Handle the user skipping onboarding
        // Typically navigate to the home screen
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => HomeScreen(),
        //   ),
        // );
      },
      showSkipButton: true,
      skip: const Text("Skip"),
      done: const Text("Done"),
      next: const Icon(Icons.arrow_forward),
      dotsDecorator: const DotsDecorator(
        activeColor: Colors.blue,
        size: Size(10.0, 10.0),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}