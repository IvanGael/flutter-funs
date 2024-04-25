
import 'package:flutter/material.dart';

class RainbowTextAnimation extends StatefulWidget {
  const RainbowTextAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RainbowTextState createState() => _RainbowTextState();
}

class _RainbowTextState extends State<RainbowTextAnimation> with SingleTickerProviderStateMixin{
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );


    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _rainbowColor(0),
            _rainbowColor(0.2),
            _rainbowColor(0.4),
            _rainbowColor(0.6),
            _rainbowColor(0.8),
            _rainbowColor(1),
          ],
        ),
      ),
      child: const Center(
        child: Text(
          'Hello',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Color _rainbowColor(double position) {
    return HSVColor.fromAHSV(
      1.0,
      360 * position,
      1.0,
      1.0,
    ).toColor();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class RainbowTextAnimationScreen extends StatelessWidget {
  const RainbowTextAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: RainbowTextAnimation(),
        ),
      );
  }
}