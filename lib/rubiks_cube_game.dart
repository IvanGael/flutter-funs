
import 'dart:math';

import 'package:flutter/material.dart';


class RubiksCubeGame extends StatefulWidget {
  const RubiksCubeGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<RubiksCubeGame> with SingleTickerProviderStateMixin {
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
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // perspective
                ..rotateX(0.5 * _controller.value * 2 * pi)
                ..rotateY(0.5 * _controller.value * 2 * pi)
                ..rotateZ(360),
              alignment: FractionalOffset.center,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.pink,
              ),
            );
          },
        ),
      ),
    );
  }
}