
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';


class ParticleLoadingTestScreen extends StatelessWidget {
  const ParticleLoadingTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ParticleLoading(),
    );
  }
}


class ParticleLoading extends StatefulWidget {
  const ParticleLoading({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ParticleLoadingScreenState createState() => _ParticleLoadingScreenState();
}

class _ParticleLoadingScreenState extends State<ParticleLoading>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> particles;
  late bool _initialized = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _initializeParticles();

    Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      _initializeParticles();
    });
  }


  void _initializeParticles() {
    setState(() {
      particles = List.generate(
        50,
        (index) => Particle(
          position: Offset(
            Random().nextDouble() * 300,
            Random().nextDouble() * 300,
          ),
          size: Random().nextDouble() * 10 + 5,
          color: Colors.blue.withOpacity(Random().nextDouble()),
          rotation: Random().nextDouble() * 360,
        ),
      );
      _initialized = true;
    });
  }
 

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_initialized)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: ParticlePainter(particles, _controller.value),
                child: Container(),
              );
            },
          ),
        Center(
          child: _initialized
              ? const Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const CircularProgressIndicator(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;

  ParticlePainter(this.particles, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      particle.draw(canvas, size, progress);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Particle {
  final Offset position;
  final double size;
  final Color color;
  final double rotation;

  Particle({
    required this.position,
    required this.size,
    required this.color,
    required this.rotation,
  });

  void draw(Canvas canvas, Size size, double progress) {
    final paint = Paint()..color = color;

    final animatedX = position.dx + progress * 50;
    final animatedY = position.dy + progress * 50;

    final animatedSize = size.height * (1 - progress);

    canvas.save();
    canvas.translate(animatedX, animatedY);
    canvas.rotate(rotation * (1 - progress));

    canvas.drawCircle(const Offset(0, 0), animatedSize, paint);

    canvas.restore();
  }
}
