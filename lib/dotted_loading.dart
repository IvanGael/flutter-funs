
import 'package:flutter/material.dart';


class DottedProgressIndicatorTestScreen extends StatelessWidget {
  const DottedProgressIndicatorTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: DottedProgressIndicator(),
        ),
      );
  }
}

class DottedProgressIndicator extends StatefulWidget {
  const DottedProgressIndicator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DottedProgressIndicatorState createState() => _DottedProgressIndicatorState();
}

class _DottedProgressIndicatorState extends State<DottedProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  int totalDots = 5; // Change this to set the total number of dots

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Change duration as needed
    );

    _animation = Tween<double>(begin: 0, end: totalDots.toDouble()).animate(_controller)
      ..addListener(() {
        setState(() {}); // Redraw the UI on each animation frame
      });

    _controller.repeat(); // Repeat the animation indefinitely
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: DottedProgressPainter(_animation.value, totalDots),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class DottedProgressPainter extends CustomPainter {
  final double progress;
  final int totalDots;

  DottedProgressPainter(this.progress, this.totalDots);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.deepPurple // Change the color as needed
      ..style = PaintingStyle.fill;

    const double dotRadius = 10.0;
    const double gap = 20.0; // Change the gap between dots as needed

    for (int i = 0; i < totalDots; i++) {
      double xPos = i * (dotRadius * 2 + gap);
      canvas.drawCircle(Offset(xPos, size.height / 2), dotRadius, paint);
    }

    // Draw lit-up dots based on progress
    paint.color = Colors.greenAccent; // Change the color of lit-up dots
    for (int i = 0; i < progress; i++) {
      double xPos = i * (dotRadius * 2 + gap);
      canvas.drawCircle(Offset(xPos, size.height / 2), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
