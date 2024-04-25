

import 'package:flutter/material.dart';

class FlickeringTextAnimationScreen extends StatelessWidget {
  const FlickeringTextAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: FlickeringTextAnimation(),
        ),
      );
  }
}

class FlickeringTextAnimation extends StatefulWidget {
  const FlickeringTextAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FlickeringTextAnimationState createState() => _FlickeringTextAnimationState();
}

class _FlickeringTextAnimationState extends State<FlickeringTextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _calculateOpacity(),
          child: const Text(
            'Hello World!',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }

  double _calculateOpacity() {
    const List<double> opacityValues = [0.3, 0.7, 0.5, 0.9, 0.6, 1.0];

    final int stepCount = opacityValues.length;
    final double progress = _controller.value;

    final int currentStep = (progress * stepCount).floor();
    final double opacity = opacityValues[currentStep % stepCount];

    return opacity;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
