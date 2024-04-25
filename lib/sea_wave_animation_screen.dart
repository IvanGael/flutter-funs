
import 'dart:math';

import 'package:flutter/material.dart';

class SeaWaveAnimationScreen extends StatelessWidget {
  const SeaWaveAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SeaWaveAnimation(),
      );
  }
}

class SeaWaveAnimation extends StatefulWidget {
  const SeaWaveAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SeaWaveAnimationState createState() => _SeaWaveAnimationState();
}

class _SeaWaveAnimationState extends State<SeaWaveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: SeaWavePainter(
            animationValue: _controller.value,
          ),
        );
      },
    )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class SeaWavePainter extends CustomPainter {
  final double animationValue;

  SeaWavePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.fill;

    Path path = Path();

    double waveHeight = size.height * 0.2;
    double waveFrequency = 2.0;
    double waveSpeed = 0.02;

    for (double i = 0.0; i <= size.width; i++) {
      double waveY = size.height * 0.5 +
          waveHeight * sin((i / size.width * waveFrequency * 2 * pi) +
              (animationValue * waveSpeed * 2 * pi));

      if (i == 0) {
        path.moveTo(i, waveY);
      } else {
        path.lineTo(i, waveY);
      }
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}