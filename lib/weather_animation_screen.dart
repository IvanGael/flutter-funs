
import 'dart:math';

import 'package:flutter/material.dart';

class WeatherAnimationScreen extends StatefulWidget {
  const WeatherAnimationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherAnimationScreen> with TickerProviderStateMixin {
  late AnimationController rainController;
  late Animation<double> rainAnimation;
  late AnimationController cloudController;
  late Animation<double> cloudAnimation;
  late AnimationController backgroundController;
  late Animation<Color?> backgroundAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize Rain Animation
    rainController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    rainAnimation = Tween<double>(begin: 0, end: 1).animate(rainController);

    // Initialize Cloud Animation
    cloudController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    cloudAnimation = Tween<double>(begin: -1, end: 1).animate(cloudController);

    // Initialize Background Animation
    backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    backgroundAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.blue.shade300,
    ).animate(backgroundController);

    // Start animations
    rainController.repeat(reverse: true);
    cloudController.repeat(reverse: true);
    backgroundController.repeat(reverse: true);
  }

  @override
  void dispose() {
    rainController.dispose();
    cloudController.dispose();
    backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creative Weather App'),
      ),
      body: AnimatedBuilder(
        animation: rainAnimation,
        builder: (context, child) {
          return Stack(
            children: [
              // Background
              Container(
                color: backgroundAnimation.value,
                height: double.infinity,
                width: double.infinity,
              ),

              // Clouds
              Positioned(
                top: 80,
                left: MediaQuery.of(context).size.width * cloudAnimation.value,
                child: const CloudAnimation(),
              ),

              // Rain with Splash Effects
              RainAnimation(intensity: rainAnimation.value),
            ],
          );
        },
      ),
    );
  }
}

class CloudAnimation extends StatelessWidget {
  const CloudAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset("assets/spaceship.png"),
    );
  }
}

class RainAnimation extends StatelessWidget {
  final double intensity;

  const RainAnimation({super.key, required this.intensity});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: List.generate(
          50,
          (index) => Positioned(
            top: MediaQuery.of(context).size.height * intensity * Random().nextDouble(),
            left: MediaQuery.of(context).size.width * Random().nextDouble(),
            child: const Raindrop(),
          ),
        ),
      ),
    );
  }
}

class Raindrop extends StatelessWidget {
  const Raindrop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 10,
          width: 2,
          color: Colors.white,
        ),
        const SizedBox(height: 2),
        Container(
          height: 2,
          width: 10,
          color: Colors.white,
        ),
      ],
    );
  }
}