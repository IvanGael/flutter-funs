import 'package:flutter/material.dart';


class OnboardingScreen35 extends StatelessWidget {
  const OnboardingScreen35({super.key});

  void _showOnboarding(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const OnboardingScreenShow();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Onboarding'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showOnboarding(context),
          child: const Text('Show Onboarding'),
        ),
      ),
    );
  }
}

class OnboardingScreenShow extends StatelessWidget {
  const OnboardingScreenShow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Welcome to My App',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'This is a custom onboarding screen. Add your onboarding content here.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Get Started'),
          ),
        ],
      ),
    );
  }
}