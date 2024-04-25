import 'package:flutter/material.dart';


class SpinnerWithBouncingBallTestScreen extends StatelessWidget {
  const SpinnerWithBouncingBallTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: SpinnerWithBouncingBall(),
        ),
      );
  }
}

class SpinnerWithBouncingBall extends StatefulWidget {
  const SpinnerWithBouncingBall({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SpinnerWithBouncingBallState createState() => _SpinnerWithBouncingBallState();
}

class _SpinnerWithBouncingBallState extends State<SpinnerWithBouncingBall>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _spinAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _spinAnimation = Tween<double>(
      begin: 0.0,
      end: 2.0 * 3.14, // 2*pi for a full circle
    ).animate(_controller);

    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: 100.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _spinAnimation.value,
          child: Transform.translate(
            offset: Offset(_bounceAnimation.value, 0),
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.greenAccent,
              ),
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
