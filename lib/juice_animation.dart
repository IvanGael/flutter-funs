import 'package:flutter/material.dart';


class JuiceSmashAnimationScreen extends StatefulWidget {
  const JuiceSmashAnimationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _JuiceSmashScreenState createState() => _JuiceSmashScreenState();
}

class _JuiceSmashScreenState extends State<JuiceSmashAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _animation = Tween<double>(begin: 0, end: 300).animate(_controller)
      ..addListener(() {
        setState(() {
          // Trigger a rebuild when animation value changes
        });
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: _animation.value,
          height: _animation.value,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              '🍊', 
              style: TextStyle(fontSize: 100),
            ),
          ),
        ),
      ),
    );
  }
}
