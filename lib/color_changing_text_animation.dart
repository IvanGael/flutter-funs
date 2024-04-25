
import 'package:flutter/material.dart';

class ColorChangingTextAnimationScreen extends StatelessWidget {
  const ColorChangingTextAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ColorChangingTextAnimation(),
    );
  }
}

class ColorChangingTextAnimation extends StatefulWidget {
  const ColorChangingTextAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ColorChangingTextAnimationState createState() => _ColorChangingTextAnimationState();
}

class _ColorChangingTextAnimationState extends State<ColorChangingTextAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();

    _colorAnimation = _controller.drive(ColorTween(
      begin: Colors.blue,
      end: Colors.pink,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Changing Text Animation'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _colorAnimation,
          builder: (context, child) {
            return Text(
              'Amazing Animation!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: _colorAnimation.value,
              ),
            );
          },
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