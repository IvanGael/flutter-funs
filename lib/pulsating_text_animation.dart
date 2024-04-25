

import 'package:flutter/material.dart';

class PulsatingTextAnimationScreen extends StatelessWidget {
  const PulsatingTextAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: PulsatingTextAnimation(),
        ),
      );
  }
}

class PulsatingTextAnimation extends StatefulWidget {
  const PulsatingTextAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PulsatingTextState createState() => _PulsatingTextState();
}

class _PulsatingTextState extends State<PulsatingTextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double scaleFactor = _controller.value * 0.5 + 1.0; // Scale between 0.5 and 1.5
        return Transform.scale(
          scale: scaleFactor,
          child: const Text(
            'Flutter',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
