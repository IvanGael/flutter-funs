import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SharinganToMangekyouScreen extends StatefulWidget {
  const SharinganToMangekyouScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<SharinganToMangekyouScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Color backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )
      ..repeat(reverse: true)
      ..addListener(() {
        if (_controller.value >= 0.5) {
          setState(() {
            backgroundColor = Colors.transparent;
          });
        } else {
          setState(() {
            backgroundColor = Colors.white;
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Transform.translate(
            offset: const Offset(-250, 0),
            child: Container(
              color: backgroundColor,
              child: _controller.value >= 0.5 ? Lottie.asset(
                'assets/flying_crows.json',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ) : null, 
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                if (_controller.value < 0.5) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * pi,
                    child: Image.asset(
                      'assets/sharingan.png',
                      width: 200,
                      height: 200,
                    ),
                  );
                } else {
                  return Transform.scale(
                    scale: (_controller.value - 0.5) * 2,
                    child: Image.asset(
                      'assets/mangekyou.png',
                      width: 200,
                      height: 200,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
