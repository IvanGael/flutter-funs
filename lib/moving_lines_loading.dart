
import 'dart:math';

import 'package:flutter/material.dart';


class MovingLinesLoaderTestScreen extends StatelessWidget {
  const MovingLinesLoaderTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: MovingLinesLoader(),
        ),
      );
  }
}

class MovingLinesLoader extends StatefulWidget {
  const MovingLinesLoader({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MovingLinesLoaderState createState() => _MovingLinesLoaderState();
}

class _MovingLinesLoaderState extends State<MovingLinesLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            children: List.generate(
              8,
              (index) {
                final angle = (index * 45) * (3.1415926535897932 / 180);
                final x = 100 + 80 * (cos(angle) * cos(_controller.value * 3.1415926535897932));
                final y = 100 + 80 * (sin(angle) * sin(_controller.value * 3.1415926535897932));

                return Positioned(
                  left: x,
                  top: y,
                  child: Container(
                    width: 10,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                );
              },
            ),
          ),
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
