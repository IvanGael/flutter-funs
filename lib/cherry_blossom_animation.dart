import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class CherryBlossomAnimation extends StatefulWidget {
  const CherryBlossomAnimation({Key? key}) : super(key: key);

  @override
  _CherryBlossomAnimationState createState() => _CherryBlossomAnimationState();
}

class _CherryBlossomAnimationState extends State<CherryBlossomAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Petal> petals;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    petals = List.generate(50, (index) => Petal(this, index));

    timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade300, Colors.blue.shade400],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          for (var petal in petals) petal.build(),
        ],
      ),
    );
  }
}

class Petal {
  late double left;
  late double top;
  late double size;
  late AnimationController controller;
  late int index;

  Petal(TickerProvider vsync, this.index) {
    left = Random().nextDouble() * 400;
    top = 50;
    size = Random().nextDouble() * 20 + 10;

    final duration = 2.0 + Random().nextDouble() * 3.0;

    controller = AnimationController(
      duration: Duration(seconds: duration.toInt()),
      vsync: vsync,
    );

    controller.addListener(() {
      top = controller.value * 400;
      if (top >= 400) {
        top = -10;
        controller.reset();
      }
    });

    // Delay each petal's animation to create a staggered effect
    Timer(Duration(milliseconds: index * 100), () {
      controller.forward();
    });
  }

  Widget build() {
    return Positioned(
      left: left,
      top: top,
      child: FadeTransition(
        opacity: controller,
        child: Image.asset(
          'assets/petals.png',
          width: size,
          height: size,
        ),
      ),
    );
  }
}