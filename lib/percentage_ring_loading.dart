
import 'package:flutter/material.dart';


class AnimatedPercentageRingTestScreen extends StatelessWidget {
  const AnimatedPercentageRingTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: AnimatedPercentageRing(
            percentage: 75, 
          ),
        ),
      );
  }
}

class AnimatedPercentageRing extends StatefulWidget {
  final double percentage;

  const AnimatedPercentageRing({super.key, required this.percentage});

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedPercentageRingState createState() => _AnimatedPercentageRingState();
}

class _AnimatedPercentageRingState extends State<AnimatedPercentageRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.percentage / 100,
    ).animate(_animationController);

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return CustomPaint(
            painter: PercentageRingPainter(_animation.value),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class PercentageRingPainter extends CustomPainter {
  final double percentage;

  PercentageRingPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.deepPurple
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 15;

    double radius = size.width / 2;

    canvas.drawCircle(
      Offset(radius, radius),
      radius - paint.strokeWidth / 2,
      paint,
    );

    paint.color = Colors.greenAccent;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius - paint.strokeWidth / 2),
      -0.5 * 3.14159265359, // Start angle in radians ( -0.5 * pi )
      2 * 3.14159265359 * percentage, // Sweep angle in radians
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
