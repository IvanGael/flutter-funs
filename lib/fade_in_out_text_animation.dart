
import 'package:flutter/material.dart';

class TextFadeInOutAnimation extends StatefulWidget {
  const TextFadeInOutAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TextFadeInOutAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInOut;

  @override
  void initState() {
    super.initState();

    // Animation controller setup
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Fade in/out animation setup
    _fadeInOut = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Start animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeInOut,
          child: const Text(
            'Amazing!',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
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