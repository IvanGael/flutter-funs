// ignore_for_file: library_private_types_in_public_api

import 'dart:math';
import 'package:flutter/material.dart';


class VibrationAnimationScreen extends StatefulWidget {
  const VibrationAnimationScreen({super.key});

  @override
  State<VibrationAnimationScreen> createState() => _VibrationAnimationScreenState();
}

class _VibrationAnimationScreenState extends State<VibrationAnimationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: VibrationAnimation(),
      ),
    );
  }
}

class VibrationAnimation extends StatefulWidget {
  const VibrationAnimation({super.key});

  @override
  _VibrationAnimationState createState() => _VibrationAnimationState();
}

class _VibrationAnimationState extends State<VibrationAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.repeat(reverse: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: VibrationPainter(_animation.value),
      size: const Size(300, 300),
    );
  }
}

class VibrationPainter extends CustomPainter {
  final double progress;

  VibrationPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.indigo
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    const double amplitude = 10.0;
    const double wavelength = 30.0;
    final double phase = 2.0 * pi * progress;

    Path path = Path();
    path.moveTo(0, size.height / 2);
    for (double x = 0; x < size.width; x++) {
      final y = size.height / 2 + amplitude * sin((2.0 * pi / wavelength) * x - phase);
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(VibrationPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}