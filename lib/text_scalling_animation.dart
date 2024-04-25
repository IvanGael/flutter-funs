

import 'package:flutter/material.dart';

class TextScallingAnimationScreen extends StatelessWidget {
  const TextScallingAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TextScallingAnimation(),
    );
  }
}

class TextScallingAnimation extends StatefulWidget {
  const TextScallingAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TextScallingAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Set up the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Set up the text scaling animation
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Scaling Animation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: const Text(
                    "Flutter is amazing!",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Reverse the animation
                _controller.reverse();
              },
              child: const Text('Shrink Text'),
            ),
            ElevatedButton(
              onPressed: () {
                // Forward the animation
                _controller.forward();
              },
              child: const Text('Grow Text'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}