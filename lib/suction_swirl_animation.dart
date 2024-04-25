
import 'dart:math';

import 'package:flutter/material.dart';

class SuctionSwirlAnimationScreen extends StatelessWidget {
  const SuctionSwirlAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: SuctionSwirlAnimation(),
        ),
      );
  }
}

class SuctionSwirlAnimation extends StatefulWidget {
  const SuctionSwirlAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SuctionSwirlAnimationState createState() => _SuctionSwirlAnimationState();
}

class _SuctionSwirlAnimationState extends State<SuctionSwirlAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _animation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: SuctionSwirlPainter(_animation.value),
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

class SuctionSwirlPainter extends CustomPainter {
  final double rotation;

  SuctionSwirlPainter(this.rotation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 3;

    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    final path = Path();

    const angleIncrement = pi / 180; 

    for (double angle = 0; angle < 2 * pi; angle += angleIncrement) {
      final x = center.dx + radius * cos(angle + rotation);
      final y = center.dy + radius * sin(angle + rotation);

      if (angle == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}