
import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedBackgroundScreen extends StatelessWidget {
  const AnimatedBackgroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: AnimatedBackground(),
      );
  }
}

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: BackgroundPainter(_animation.value),
          child: Container(),
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

class BackgroundPainter extends CustomPainter {
  final double animationValue;

  BackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background gradient
    final gradient = const LinearGradient(
      colors: [
        Color(0xFF002C61),
        Color(0xFF004982),
        Color(0xFF0078A6),
      ],
      stops: [0.0, 0.5, 1.0],
    ).createShader(Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)));

    final paint = Paint()..shader = gradient;
    canvas.drawRect(Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)), paint);

    // Draw animated stars
    final random = Random();
    final starsPaint = Paint()..color = Colors.white;
    const numberOfStars = 50;

    for (int i = 0; i < numberOfStars; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final starSize = (random.nextDouble() * 2 + 1) * (1 - animationValue);
      canvas.drawCircle(Offset(x, y), starSize, starsPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}