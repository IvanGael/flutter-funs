import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class RadarScreen extends StatefulWidget {
  const RadarScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RadarScreenState createState() => _RadarScreenState();
}

class _RadarScreenState extends State<RadarScreen>
    with TickerProviderStateMixin {
  late AnimationController _sweepController;
  late Animation<double> _sweepAnimation;

  final List<TargetBlip> _targetBlips = [];

  @override
  void initState() {
    super.initState();

    _sweepController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _sweepAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * pi,
    ).animate(_sweepController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _sweepController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _sweepController.forward();
        }
      });

    _sweepController.forward();

    // Simulate target blips
    Timer.periodic(const Duration(seconds: 8), (timer) {
      setState(() {
        _targetBlips.add(TargetBlip());
      });
    });
  }

  @override
  void dispose() {
    _sweepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radar App'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Radar Circle
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
            ),
            // Radar Sweep Animation
            RotationTransition(
              turns: _sweepAnimation,
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.asset('assets/radar-sweep.png'),
              ),
            ),
            // Target Blips
            for (var blip in _targetBlips) blip,
          ],
        ),
      ),
    );
  }
}

class TargetBlip extends StatelessWidget {
  final double size = 20.0;
  final double distance = 150.0;
  final double angle = Random().nextDouble() * (2 * pi);

  TargetBlip({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: distance * sin(angle) + 150, // Adjust the center based on your radar circle size
      left: distance * cos(angle) + 150, // Adjust the center based on your radar circle size
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
      ),
    );
  }
}