import 'dart:math';
import 'package:flutter/material.dart';



class FlipAndFallAnimationScreen extends StatelessWidget {
  const FlipAndFallAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: FlipAndFallAnimation(),
        ),
      );
  }
}

class FlipAndFallAnimation extends StatefulWidget {
  const FlipAndFallAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FlipAndFallAnimationState createState() => _FlipAndFallAnimationState();
}

class _FlipAndFallAnimationState extends State<FlipAndFallAnimation>
    with TickerProviderStateMixin {
  late AnimationController _flipController;
  late AnimationController _fallController;
  late Animation<double> _flipAnimation;
  late Animation<Offset> _fallAnimation;

  @override
  void initState() {
    super.initState();

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _fallController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(_flipController);
    _fallAnimation = Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 1))
        .animate(_fallController);

    _flipController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fallController.forward();
      }
    });

    _fallController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipController.reset();
        _fallController.reset();
        _flipController.forward();
      }
    });

    _flipController.forward();
  }

  @override
  void dispose() {
    _flipController.dispose();
    _fallController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _flipAnimation,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Perspective
            ..rotateX(_flipAnimation.value),
          alignment: Alignment.center,
          child: child,
        );
      },
      child: SlideTransition(
        position: _fallAnimation,
        // child: const Text(
        //   'Fun',
        //   style: TextStyle(
        //     fontSize: 36,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.blue,
        //   ),
        // ),
        child: Image.asset(
          "assets/spaceship.png",
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
