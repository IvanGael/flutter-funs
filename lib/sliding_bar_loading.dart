
import 'package:flutter/material.dart';


class SlidingBarIndicatorTestScreen extends StatelessWidget {
  const SlidingBarIndicatorTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: SlidingBarIndicator(),
        ),
      );
  }
}

class SlidingBarIndicator extends StatefulWidget {
  const SlidingBarIndicator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SlidingBarIndicatorState createState() => _SlidingBarIndicatorState();
}

class _SlidingBarIndicatorState extends State<SlidingBarIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Start animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 20.0,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return FractionallySizedBox(
            widthFactor: _animation.value,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
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
