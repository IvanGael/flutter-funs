
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';


class AnimatedTextMaskScreen extends StatelessWidget {
  const AnimatedTextMaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: AnimatedTextMask(),
        ),
      );
  }
}

class AnimatedTextMask extends StatefulWidget {
  const AnimatedTextMask({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedTextMaskState createState() => _AnimatedTextMaskState();
}

class _AnimatedTextMaskState extends State<AnimatedTextMask> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  List<String> images = [
    'assets/goku_ssj_blue.png',
    'assets/golden_freezer.png',
    'assets/jiren.png'
  ];

  int imageIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // _controller.addListener(() {
    //   if (_controller.isCompleted) {
    //     // Animation completed, update the image index
    //     setState(() {
    //       imageIndex = (imageIndex + 1) % images.length;
    //     });
    //     _controller.repeat();
    //   } 
    // });

    _controller.forward();
  }

 
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ClipRect(
          clipper: TextMaskClipper(_animation.value),
          child: Container(
            color: Colors.blue, 
            child: Center(
              child: Text(
                'Hello world',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              // child: Image.asset(
              //   images[imageIndex],
              //   width: 200,
              //   height: 200,
              // ),
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

class TextMaskClipper extends CustomClipper<Rect> {
  final double animationValue;

  TextMaskClipper(this.animationValue);

  @override
  Rect getClip(Size size) {
    double width = size.width * animationValue;
    return Rect.fromLTWH(0, 0, width, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
