
import 'dart:math';

import 'package:flutter/material.dart';



class MorphingShapesLoaderTestScreen extends StatelessWidget {
  const MorphingShapesLoaderTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: MorphingShapesLoader(),
        ),
      );
  }
}

class MorphingShapesLoader extends StatefulWidget {
  const MorphingShapesLoader({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MorphingShapesAnimationState createState() =>
      _MorphingShapesAnimationState();
}

class _MorphingShapesAnimationState extends State<MorphingShapesLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          // Rebuild the widget to reflect the changes in the animation value
        });
      });

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MorphingShapesPainter(_animation.value),
      size: const Size(200, 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MorphingShapesPainter extends CustomPainter {
  final double animationValue;

  MorphingShapesPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.deepPurple
      ..style = PaintingStyle.fill;

    double radius = 40;

    // Morphing from Circle to Square to Triangle
    if (animationValue <= 0.5) {
      double circleFraction = animationValue * 2;
      canvas.drawCircle(Offset(size.width / 2, size.height / 2),
          radius * (1 - circleFraction) + size.width * 0.5 * circleFraction, paint);
    } else if (animationValue <= 0.75) {
      double squareFraction = (animationValue - 0.5) * 4;
      double side = radius * 2;
      double halfSide = side / 2;
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: side * squareFraction + halfSide * (1 - squareFraction),
          height: side * squareFraction + halfSide * (1 - squareFraction),
        ),
        paint,
      );
    } else {
      double triangleFraction = (animationValue - 0.75) * 4;
      double height = sqrt(3) * radius;
      double halfHeight = height / 2;
      Path path = Path()
        ..moveTo(size.width / 2, size.height / 2 - height / 2)
        ..lineTo(size.width / 2 - radius * triangleFraction, size.height / 2 + halfHeight * (1 - triangleFraction))
        ..lineTo(size.width / 2 + radius * triangleFraction, size.height / 2 + halfHeight * (1 - triangleFraction))
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
