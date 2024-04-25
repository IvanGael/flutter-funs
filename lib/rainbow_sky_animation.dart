import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class RainbowAnimationTestScreen extends StatelessWidget {
  const RainbowAnimationTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: RainbowAnimation(),
      );
  }
}

class RainbowAnimation extends StatefulWidget {
  const RainbowAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RainbowAnimationState createState() => _RainbowAnimationState();
}

class _RainbowAnimationState extends State<RainbowAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: RainbowPainter(_animation.value),
        child: Container(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class RainbowPainter extends CustomPainter {
  final double animationValue;

  RainbowPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;

    for (int i = 6; i >= 1; i--) {
      Color color = Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
          .withOpacity(1.0);

      Paint paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        animationValue + (i * pi / 6),
        pi / 6,
        true,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
