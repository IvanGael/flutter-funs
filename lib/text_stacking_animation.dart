
import 'package:flutter/material.dart';


class StackedTextAnimationScreen extends StatelessWidget {
  const StackedTextAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: StackedTextAnimation(),
        ),
      );
  }
}

class StackedTextAnimation extends StatefulWidget {
  const StackedTextAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StackedTextAnimationState createState() => _StackedTextAnimationState();
}

class _StackedTextAnimationState extends State<StackedTextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return StackedTextWidget(
          text: "Hello World!",
          progress: _animation.value,
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

class StackedTextWidget extends StatelessWidget {
  final String text;
  final double progress;

  const StackedTextWidget({super.key, required this.text, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRect(
        child: Stack(
          alignment: Alignment.center,
          children: [
            for (int i = 0; i < text.length; i++)
              Positioned(
                top: progress * i * 20,
                child: Opacity(
                  opacity: progress,
                  child: Text(
                    text[i],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
