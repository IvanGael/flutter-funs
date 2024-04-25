
import 'package:flutter/material.dart';


class HeartbeatPulseLoaderTestScreen extends StatelessWidget {
  const HeartbeatPulseLoaderTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: HeartbeatPulseLoader(),
        ),
      );
  }
}

class HeartbeatPulseLoader extends StatefulWidget {
  const HeartbeatPulseLoader({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HeartbeatPulseLoaderState createState() => _HeartbeatPulseLoaderState();
}

class _HeartbeatPulseLoaderState extends State<HeartbeatPulseLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
      reverseDuration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut,
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
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
