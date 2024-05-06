// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class QRAnimationScreen extends StatefulWidget {
  const QRAnimationScreen({super.key});

  @override
  _QRAnimationScreenState createState() => _QRAnimationScreenState();
}

class _QRAnimationScreenState extends State<QRAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final Duration _animationDuration = const Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[800],
      body: Stack(
        // fit: StackFit.expand,
        children: [
          Transform.translate(
            offset: const Offset(10, 0),
            child: Center(
            child: Image.asset(
              "assets/scan_box2_white.png",
              width: 500,
              height: 500,
              fit: BoxFit.cover,
            ),
          ),
          ),
          Positioned(
            top: 283,
            left: 90,
            child: SizedBox(
            width: 210,
            height: 210,
            child: CustomPaint(
              painter: QRCodeScannerPainter(
                animation: _animationController,
              ),
            ),
          )
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class QRCodeScannerPainter extends CustomPainter {
  final Animation<double> animation;

  QRCodeScannerPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background
    Paint bgPaint = Paint()..color = Colors.white38;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Calculate animation value
    double value = animation.value;

    // Draw scanning line vertically
    Paint linePaint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 5;

    double lineWidth = size.width ;
    double lineY = size.height * value;
    canvas.drawLine(Offset(0, lineY), Offset(lineWidth, lineY), linePaint);

    // Draw bounding box
    Paint boxPaint = Paint()
      ..color = Colors.white10
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    double boxSize = size.width * 0.6;
    double boxOffset = (size.width - boxSize) / 2;
    Rect boundingBox = Rect.fromLTWH(boxOffset, boxOffset, boxSize, boxSize);
    canvas.drawRect(boundingBox, boxPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
