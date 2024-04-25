import 'package:flutter/material.dart';

class BalloonAnimationTestScreen extends StatelessWidget {
  const BalloonAnimationTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: BalloonAnimation(),
      );
  }
}

class BalloonAnimation extends StatefulWidget {
  const BalloonAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BalloonAnimationState createState() => _BalloonAnimationState();
}



class _BalloonAnimationState extends State<BalloonAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  List<double> balloonOffsets = [];

  @override
  void initState() {
    super.initState();

    // Set up animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Increased duration for slower movement
      vsync: this,
    );

    // Set up animation
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
          _controller.forward();
        }
      });

    // Generate initial balloon offsets
    for (int i = 0; i < 10; i++) {
      balloonOffsets.add(i * 50.0);
    }

    // Start the animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: balloonOffsets.length,
      itemExtent: 120.0, // Fixed height for each item
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: BalloonPainter(balloonOffsets[index], _animation.value),
              child: Container(),
            );
          },
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

class BalloonPainter extends CustomPainter {
  final double initialYOffset;
  final double animationValue;

  BalloonPainter(this.initialYOffset, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate animated yOffset based on initialYOffset and animationValue
    double yOffset = initialYOffset + (animationValue * 120); // 120 is the itemExtent

    // Draw balloon
    Paint balloonPaint = Paint()
      ..color = Colors.deepOrange
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2 + yOffset), 20.0, balloonPaint);

    // Draw balloon string
    Paint stringPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0;

    canvas.drawLine(
      Offset(size.width / 2, size.height / 2 + yOffset + 20),
      Offset(size.width / 2, size.height / 2 + yOffset + 100),
      stringPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

