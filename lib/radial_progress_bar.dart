
import 'dart:math';
import 'package:flutter/material.dart';

class RadialProgressBarTestScreen extends StatelessWidget {
  const RadialProgressBarTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: RadialProgressBar(),
        ),
      );
  }
}

class RadialProgressBar extends StatefulWidget {
  const RadialProgressBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RadialProgressBarState createState() => _RadialProgressBarState();
}

class _RadialProgressBarState extends State<RadialProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double percentage = 0.75; 

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RadialProgressBarPainter(
        percentage: percentage,
        animation: _controller,
      ),
      child: SizedBox(
        width: 200.0,
        height: 200.0,
        child: Center(
          child: Text(
            '${(percentage * 100).toStringAsFixed(0)}%',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
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

class RadialProgressBarPainter extends CustomPainter {
  final double percentage;
  final Animation<double> animation;

  RadialProgressBarPainter({required this.percentage, required this.animation})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.deepPurple
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 15.0
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, paint);

    final double arcAngle = 2 * pi * percentage;

    paint.color = Colors.greenAccent;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      arcAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
