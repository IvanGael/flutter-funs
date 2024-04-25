import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_explosive_like/space_animation.dart';

class ParallelUniverseScreen extends StatefulWidget {
  const ParallelUniverseScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ParallelUniverseScreenState createState() => _ParallelUniverseScreenState();
}

class _ParallelUniverseScreenState extends State<ParallelUniverseScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Universe'),
      // ),
      backgroundColor: Colors.white54,
      body: Center(
        child: Stack(
          children: [
            SpaceAnimation(),
            for (int i = 0; i < 7; i++)
              Planet(
                color: _getPlanetColor(i),
                radius: 40.0,
                angle: math.pi * 2 / 7 * i,
                controller: _controller,
                name: _getPlanetName(i),
              ),
          ],
        ),
      ),
    );
  }

  Color _getPlanetColor(int index) {
    switch (index) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.indigo;
      case 4:
        return Colors.greenAccent;
      case 5:
        return Colors.brown;
      case 6:
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  String _getPlanetName(int index) {
    switch (index) {
      case 0:
        return 'Mercury';
      case 1:
        return 'Venus';
      case 2:
        return 'Earth';
      case 3:
        return 'Mars';
      case 4:
        return 'Jupiter';
      case 5:
        return 'Saturn';
      case 6:
        return 'Uranus';
      default:
        return 'Unknown';
    }
  }
}

class Planet extends StatelessWidget {
  final Color color;
  final double radius;
  final double angle;
  final AnimationController controller;
  final String name;

  const Planet({super.key, 
    required this.color,
    required this.radius,
    required this.angle,
    required this.controller,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final double transformAngle = angle + controller.value * 2 * math.pi;
        final double x = 150 * math.cos(transformAngle);
        final double y = 150 * math.sin(transformAngle);

        return Positioned(
          top: MediaQuery.of(context).size.height * 0.5 - radius + y,
          left: MediaQuery.of(context).size.width * 0.5 - radius + x,
          child: Column(
            children: [
              Container(
                width: radius * 2,
                height: radius * 2,
                decoration: BoxDecoration(
                  // color: color,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/${name.toLowerCase()}.png'),
                    fit: BoxFit.cover
                  )
                ),
              ),
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12, 
                  color: Colors.white
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
