
import 'package:flutter/material.dart';

class TextFlipCardAnimationScreen extends StatelessWidget {
  const TextFlipCardAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: FlipCard(),
        ),
      );
  }
}

class FlipCard extends StatefulWidget {
  const FlipCard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller.status == AnimationStatus.completed) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          double value = _animation.value;

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(value * 3.141), // 3.141 radians = 180 degrees
            alignment: Alignment.center,
            child: value < 0.5 ? const FrontCard() : const BackCard(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class FrontCard extends StatelessWidget {
  const FrontCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      color: Colors.blue,
      child: const Center(
        child: Text(
          'Front Content',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

class BackCard extends StatelessWidget {
  const BackCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      color: Colors.green,
      child: const Center(
        child: Text(
          'Back Content',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}