
import 'dart:math';

import 'package:flutter/material.dart';


class FlutteringButterflyLoaderTestScreen extends StatelessWidget {
  const FlutteringButterflyLoaderTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: FlutteringButterflyLoader(),
        ),
      );
  }
}

class FlutteringButterflyLoader extends StatefulWidget {
  const FlutteringButterflyLoader({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FlutteringButterflyLoaderState createState() =>
      _FlutteringButterflyLoaderState();
}

class _FlutteringButterflyLoaderState extends State<FlutteringButterflyLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Butterfly> butterflies;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    butterflies = List.generate(
      10,
      (index) => Butterfly(
        animationController: _controller,
        startPosition: index / 10.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          fit: StackFit.expand,
          children: butterflies,
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

class Butterfly extends StatelessWidget {
  final AnimationController animationController;
  final double startPosition;

  const Butterfly({super.key, 
    required this.animationController,
    required this.startPosition,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        double animationValue = animationController.value;
        double xPosition =
            sin((animationValue + startPosition) * 2 * pi) * 50.0;

        return Positioned(
          top: 150.0,
          left: MediaQuery.of(context).size.width * 0.5 + xPosition,
          child: Image.asset(
            'assets/butterfly.png',
            width: 100.0,
            height: 100.0,
          ),
        );
      },
    );
  }
}
