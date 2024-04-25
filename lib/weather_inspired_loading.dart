
import 'package:flutter/material.dart';
import 'dart:math';



class WeatherLoaderTestScreen extends StatelessWidget {
  const WeatherLoaderTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: WeatherLoader(),
        ),
      );
  }
}

class WeatherLoader extends StatefulWidget {
  const WeatherLoader({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WeatherLoaderState createState() => _WeatherLoaderState();
}

class _WeatherLoaderState extends State<WeatherLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Raindrop> raindrops;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    raindrops = List.generate(
      200,
      (index) => Raindrop(
        animation: _controller,
        startPos: Random().nextDouble() * 800,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            Container(
              color: Colors.pink,
              child: const Center(
                child: Text(
                  '',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            for (var drop in raindrops) drop.build(context),
          ],
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

class Raindrop {
  final Animation<double> animation;
  final double startPos;

  Raindrop({required this.animation, required this.startPos});

  Widget build(BuildContext context) {
    return Positioned(
      top: animation.value * 500 + startPos,
      left: Random().nextDouble() * MediaQuery.of(context).size.width,
      child: Container(
        width: 3,
        height: 10,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle
        ),
      ),
    );
  }
}
