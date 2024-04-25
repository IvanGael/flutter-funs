import 'dart:math';

import 'package:flutter/material.dart';

class LiquidLinearProgressIndicator extends StatefulWidget {
  const LiquidLinearProgressIndicator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LiquidLinearProgressIndicatorState createState() =>
      _LiquidLinearProgressIndicatorState();
}

class _LiquidLinearProgressIndicatorState
    extends State<LiquidLinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        setState(() {});
      });

    // Example: To simulate a download progress from 0 to 1 over 5 seconds
    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    double progress = _animationController.value;
    String percentage = '${(progress * 100).toStringAsFixed(0)}%';

    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
          ),
          // ClipPath(
          //   clipper: LiquidClipper(progress),
          //   child: Container(
          //     color: Colors.pink,
          //   ),
          // ),
          Center(
            child: Text(
              percentage,
              style: TextStyle(
                color: progress >= 0.45 ? Colors.white : Colors.deepPurple,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                decoration: TextDecoration.none
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}


class LiquidClipper extends CustomClipper<Path> {
  final double progress;

  LiquidClipper(this.progress);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.8);

    double waveHeight = 10.0;

    for (double i = 0.0; i <= size.width; i++) {
      double x = i / size.width;
      double y = sin((x * 5.0) + (progress * 2 * pi)) * waveHeight + 0.8;
      path.lineTo(i, size.height * y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}