import 'dart:math';

import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    particles = List.generate(
      50,
      (index) => Particle(
        position: Offset(
          Random().nextDouble() * 400,
          Random().nextDouble() * 300,
        ),
        color: Colors.white,
        size: Random().nextDouble() * 40 + 5,
        speed: Random().nextDouble() * 0.6 + 0.2,
        angle: Random().nextDouble() * 2 * pi,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              children: particles.map((particle) {
                return Positioned(
                  left: particle.position.dx +
                      sin(particle.angle) * _controller.value * particle.speed,
                  top: particle.position.dy +
                      cos(particle.angle) * _controller.value * particle.speed,
                  child: Container(
                    width: particle.size,
                    height: particle.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: particle.color,
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Particle {
  Offset position;
  Color color;
  double size;
  double speed;
  double angle;

  Particle({
    required this.position,
    required this.color,
    required this.size,
    required this.speed,
    required this.angle,
  });
}