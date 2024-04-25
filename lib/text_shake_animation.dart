

import 'package:flutter/material.dart';


class TextShakeAnimationScreen extends StatelessWidget {
  const TextShakeAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Text Shake Animation'),
        ),
        body: const Center(
          child: TextShakeAnimation(),
        ),
      );
  }
}

class TextShakeAnimation extends StatefulWidget {
  const TextShakeAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TextShakeAnimationState createState() => _TextShakeAnimationState();
}

class _TextShakeAnimationState extends State<TextShakeAnimation> {
  @override
  Widget build(BuildContext context) {
    return const ShakeTransition(
      duration: Duration(milliseconds: 1000),
      offset: 10.0,
      child: Text(
        'Shake me!',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ShakeTransition extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final double offset;

  const ShakeTransition({super.key, 
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.offset = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: duration,
      tween: Tween(begin: -offset, end: offset),
      builder: (BuildContext context, double value, Widget? child) {
        return Transform.translate(
          offset: Offset(value, 0),
          child: child,
        );
      },
      child: child,
    );
  }
}