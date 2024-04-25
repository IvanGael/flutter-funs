
import 'package:flutter/material.dart';

class EmotionalStorytellingAnimation extends StatefulWidget {
  const EmotionalStorytellingAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmotionalStorytellingAnimationState createState() =>
      _EmotionalStorytellingAnimationState();
}

class _EmotionalStorytellingAnimationState
    extends State<EmotionalStorytellingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInOut;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _fadeInOut = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/db_bg1.jpg"), 
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeInOut,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmotionalCharacterAnimation(),
                SizedBox(height: 20),
                Text(
                  "Once upon a time...",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
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

class EmotionalCharacterAnimation extends StatelessWidget {
  const EmotionalCharacterAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      child: Image.asset("assets/goku_ssj_blue.png"),
    );
  }
}
