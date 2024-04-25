
import 'dart:math';
import 'package:flutter/material.dart';



class RotatingCubesLoaderTestScreen extends StatelessWidget {
  const RotatingCubesLoaderTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: RotatingCubesLoader(),
        ),
      );
  }
}

class RotatingCubesLoader extends StatefulWidget {
  const RotatingCubesLoader({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RotatingCubesLoaderState createState() => _RotatingCubesLoaderState();
}

class _RotatingCubesLoaderState extends State<RotatingCubesLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: Stack(
            children: [
              _buildCube(0, 0),
              _buildCube(50, 50),
              _buildCube(100, 0),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCube(double translateX, double translateY) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateX(pi / 4)
        ..rotateY(pi / 4),
      child: Container(
        width: 50,
        height: 50,
        color: Colors.greenAccent,
        margin: EdgeInsets.only(
          left: translateX,
          top: translateY,
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
