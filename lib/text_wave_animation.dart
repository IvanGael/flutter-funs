

import 'dart:math';

import 'package:flutter/material.dart';

class WaveTextAnimationScreen extends StatelessWidget {
  const WaveTextAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: WaveTextAnimation(),
        ),
      );
  }
}

class WaveTextAnimation extends StatefulWidget {
  const WaveTextAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WaveTextAnimationState createState() => _WaveTextAnimationState();
}

class _WaveTextAnimationState extends State<WaveTextAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: WaveTextPainter(_controller.value),
          // child: const Center(
          //   child: Text(
          //     'Wave Text',
          //     style: TextStyle(
          //       fontSize: 40,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
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


class WaveTextPainter extends CustomPainter {
  final double animationValue;

  WaveTextPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    const textToWave = 'Wave';
    final textPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    const waveAmplitude = 20.0;
    const waveFrequency = 0.5;

    final path = Path();

    for (int i = 0; i < textToWave.length; i++) {
      final letterPath = Path()
        ..addOval(Rect.fromCircle(
          center: Offset(i * 60.0, sin((i * waveFrequency) + animationValue) * waveAmplitude),
          radius: 10.0,
        ));
      path.addPath(letterPath, Offset.zero);
    }

    canvas.drawPath(path, textPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}