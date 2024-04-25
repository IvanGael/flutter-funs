
import 'dart:math';

import 'package:flutter/material.dart';

class SpaceAnimation extends StatefulWidget {
  const SpaceAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SpaceAnimationState createState() => _SpaceAnimationState();
}

class _SpaceAnimationState extends State<SpaceAnimation>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late Animation<double> _backgroundAnimation;

  late AnimationController _shipController;
  late Animation<double> _shipAnimation;

  @override
  void initState() {
    super.initState();

    _backgroundController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _backgroundAnimation =
        Tween<double>(begin: 0, end: 1).animate(_backgroundController)
          ..addListener(() {
            setState(() {});
          });

    _shipController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _shipAnimation =
        Tween<double>(begin: 0, end: 1).animate(_shipController)
          ..addListener(() {
            setState(() {});
          });

    _backgroundController.repeat();
    _shipController.repeat();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _shipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          // Animated Space Background
          Positioned.fill(
            child: Container(
              color: Colors.black,
              child: CustomPaint(
                painter: SpaceBackgroundPainter(_backgroundAnimation.value),
              ),
            ),
          ),


          Positioned(
            top: 50,
            right: 50,
            child: Image.asset(
              "assets/moon.png",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            )
          )

          // Animated Spaceship
          // Positioned(
          //   top: MediaQuery.of(context).size.height * 0.7,
          //   left: MediaQuery.of(context).size.width * _shipAnimation.value,
          //   child: Image.asset(
          //     'assets/spaceship.png',
          //     width: 100,
          //     height: 100,
          //   ),
          // ),
        ],
      );
  }
}


class SpaceBackgroundPainter extends CustomPainter {
  final double animationValue;

  SpaceBackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint starPaint = Paint()
      ..color = Colors.white.withOpacity(0.8);

    final Paint galaxyPaint = Paint()
      ..color = Colors.white12.withOpacity(0.5);

    // Draw Stars
    for (int i = 0; i < 100; i++) {
      double x = Random().nextDouble() * size.width;
      double y = Random().nextDouble() * size.height;
      double starSize = Random().nextDouble() * 2;

      canvas.drawCircle(Offset(x, y), starSize, starPaint);
    }

    // Draw Galaxy
    // double galaxyRadius = size.width * 0.3;
    // double galaxyX = size.width * 0.7;
    // double galaxyY = size.height * 0.3;

    // canvas.drawCircle(Offset(galaxyX, galaxyY), galaxyRadius, galaxyPaint);

    // Parallax Effect
    double parallaxX = size.width * 0.5 * animationValue;
    double parallaxY = size.height * 0.2 * animationValue;

    // Draw Stars with Parallax Effect
    for (int i = 0; i < 50; i++) {
      double x = Random().nextDouble() * size.width + parallaxX;
      double y = Random().nextDouble() * size.height + parallaxY;
      double starSize = Random().nextDouble() * 2;

      canvas.drawCircle(Offset(x, y), starSize, starPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}