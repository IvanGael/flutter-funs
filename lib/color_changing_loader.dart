
import 'dart:async';
import 'package:flutter/material.dart';


class ColorChangingLoaderTestScreen extends StatelessWidget {
  const ColorChangingLoaderTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: ColorChangingLoader(),
        ),
      );
  }
}

class ColorChangingLoader extends StatefulWidget {
  const ColorChangingLoader({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ColorChangingLoaderState createState() => _ColorChangingLoaderState();
}

class _ColorChangingLoaderState extends State<ColorChangingLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.orange,
    ).animate(_controller);

    _controller.repeat();

    // Uncomment the following line if you want to stop the animation after a specific duration
    // Timer(Duration(seconds: 10), () => _controller.stop());
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _colorAnimation.value,
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
