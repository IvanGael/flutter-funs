
import 'package:flutter/material.dart';

class OnboardingScreen14 extends StatelessWidget {
  const OnboardingScreen14({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tabbed Onboarding'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 200.0,
              child: TabBarView(
                children: [
                  OnboardingTab(content: 'Feature 1 Content'),
                  OnboardingTab(content: 'Feature 2 Content'),
                  OnboardingTab(content: 'Feature 3 Content'),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Handle button click (e.g., navigate to the next screen)
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(text: 'Feature 1'),
            Tab(text: 'Feature 2'),
            Tab(text: 'Feature 3'),
          ],
        ),
      ),
    );
  }
}

class OnboardingTab extends StatelessWidget {
  final String content;

  const OnboardingTab({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          content,
          style: const TextStyle(fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}