
import 'package:flutter/material.dart';

class BlinkingTextAnimationScreen extends StatelessWidget {
  const BlinkingTextAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Blinking Text Animation'),
        ),
        body: const Center(
          child: BlinkingTextAnimation(),
        ),
      );
  }
}

class BlinkingTextAnimation extends StatefulWidget {
  const BlinkingTextAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BlinkingTextState createState() => _BlinkingTextState();
}

class _BlinkingTextState extends State<BlinkingTextAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: const Text(
        'Hello, Blinking World!',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
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