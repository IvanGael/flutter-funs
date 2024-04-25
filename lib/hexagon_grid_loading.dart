
import 'dart:math';

import 'package:flutter/material.dart';


class HexagonGridLoaderTestScreen extends StatelessWidget {
  const HexagonGridLoaderTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: HexagonGridLoader(),
        ),
      );
  }
}

class HexagonGridLoader extends StatefulWidget {
  const HexagonGridLoader({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HexagonGridLoaderState createState() => _HexagonGridLoaderState();
}

class _HexagonGridLoaderState extends State<HexagonGridLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _animation = IntTween(begin: 0, end: 20).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: CustomPaint(
        painter: HexagonPainter(_animation.value),
        child: Center(
          child: Text(
            '${_animation.value}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}


class HexagonPainter extends CustomPainter {
  final int numberOfHexagons;

  HexagonPainter(this.numberOfHexagons);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    final Paint paint = Paint()..color = Colors.blue;

    for (int i = 0; i < numberOfHexagons; i++) {
      final double angle = (2 * pi / 6) * i;
      final double x = centerX + radius * cos(angle);
      final double y = centerY + radius * sin(angle);

      canvas.drawRegularPolygon(6, x, y, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

extension CanvasExtensions on Canvas {
  void drawRegularPolygon(int sides, double x, double y, double radius, Paint paint) {
    final Path path = Path();
    for (int i = 0; i < sides; i++) {
      double angle = 2 * pi / sides * (i + 0.5);
      double xPoint = x + radius * cos(angle);
      double yPoint = y + radius * sin(angle);
      if (i == 0) {
        path.moveTo(xPoint, yPoint);
      } else {
        path.lineTo(xPoint, yPoint);
      }
    }
    path.close();
    drawPath(path, paint);
  }
}