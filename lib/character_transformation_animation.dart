
import 'package:flutter/material.dart';

class CharacterTransformationAnimation extends StatefulWidget {
  const CharacterTransformationAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CharacterTransformationAnimationState createState() =>
      _CharacterTransformationAnimationState();
}

class _CharacterTransformationAnimationState
    extends State<CharacterTransformationAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  int _currentCharacterIndex = 0;
  final List<String> _characterImages = [
    'assets/goku_ssj_blue.png', 
    'assets/goku_ssj_blue_kaioken.png',
    'assets/goku_ultra_instinct.png',
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward(from: 0.0);
  }

  void _changeCharacter() {
    setState(() {
      _currentCharacterIndex =
          (_currentCharacterIndex + 1) % _characterImages.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Transformation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(_animation.value == 0)
            Image.asset(
                    _characterImages[_currentCharacterIndex],
                    width: 200,
                    height: 400,
                  ),
            if(_animation.value > 0)
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value,
                  child: Image.asset(
                    _characterImages[_currentCharacterIndex],
                    width: 200,
                    height: 400,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startAnimation,
                  child: const Text('Transform Character'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _changeCharacter,
                  child: const Text('Change Character'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}