
import 'dart:math';

import 'package:flutter/material.dart';

class RotatingTextAnimationScreen extends StatelessWidget {
  const RotatingTextAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: RotatingTextAnimation(
            text: 'Hello World!',
          ),
        ),
      );
  }
}

class RotatingTextAnimation extends StatefulWidget {
  final String text;

  const RotatingTextAnimation({super.key, required this.text});

  @override
  // ignore: library_private_types_in_public_api
  _RotatingTextAnimationState createState() => _RotatingTextAnimationState();
}

class _RotatingTextAnimationState extends State<RotatingTextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _rotationAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 0),
        weight: 1.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 360),
        weight: 1.0,
      ),
    ]).animate(_controller);

    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationAnimation.value * (pi / 360),
          child: _buildText(),
        );
      },
    );
  }

  Widget _buildText() {
    List<Widget> characters = [];

    for (int i = 0; i < widget.text.length; i++) {
      characters.add(
        RotationTransition(
          turns: AlwaysStoppedAnimation(_controller.value),
          child: Text(
            widget.text[i],
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: characters,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}