
import 'dart:math';

import 'package:flutter/material.dart';

class RubickCubeLoaderScreen extends StatefulWidget {
  const RubickCubeLoaderScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<RubickCubeLoaderScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return Transform.rotate(
              angle: _controller.value * 2 * pi,
              child: CustomPaint(
                painter: CubePainter(),
                child: const SizedBox(
                  width: 100,
                  height: 100,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CubePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.indigo
      ..style = PaintingStyle.fill
      ..strokeWidth = 4;

    canvas.drawRect(Offset.zero & size, paint);
    canvas.drawLine(Offset.zero, Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(CubePainter oldDelegate) => false;
}