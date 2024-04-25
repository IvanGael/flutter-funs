
import 'package:flutter/material.dart';


class GradientProgressIndicatorTestScreen extends StatelessWidget {
  const GradientProgressIndicatorTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: GradientProgressIndicator(),
        ),
      );
  }
}

class GradientProgressIndicator extends StatefulWidget {
  const GradientProgressIndicator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GradientProgressIndicatorState createState() =>
      _GradientProgressIndicatorState();
}

class _GradientProgressIndicatorState extends State<GradientProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = ColorTween(
      begin: Colors.greenAccent,
      end: Colors.deepPurple,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: const LinearGradient(
          colors: [Colors.lightGreen, Colors.deepPurpleAccent],
        ),
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return FractionallySizedBox(
            widthFactor: _controller.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                  colors: [_animation.value!, Colors.transparent],
                ),
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
