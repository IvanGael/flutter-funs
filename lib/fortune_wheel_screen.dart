import 'dart:math';
import 'package:flutter/material.dart';

class FortuneWheelScreen extends StatelessWidget {
  const FortuneWheelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FortuneWheel(),
      ),
    );
  }
}

class FortuneWheel extends StatefulWidget {
  const FortuneWheel({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FortuneWheelState createState() => _FortuneWheelState();
}

class _FortuneWheelState extends State<FortuneWheel> {
  int selectedSector = 0;
  double rotationAngle = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              rotationAngle += details.delta.dx * 0.01; 
            });
          },
          child: CustomPaint(
            size: const Size(200, 200),
            painter: WheelPainter(selectedSector, rotationAngle),
          ),
        ),
        // const SizedBox(height: 20),
        // ElevatedButton(
        //   onPressed: () {
        //     spinWheel();
        //   },
        //   child: const Text('Spin Wheel'),
        // ),
      ],
    );
  }

  void spinWheel() {
    setState(() {
      selectedSector = Random().nextInt(8);
    });
  }
}

class WheelPainter extends CustomPainter {
  final int selectedSector;
  final double rotationAngle;

  WheelPainter(this.selectedSector, this.rotationAngle);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    double radius = size.width / 2;
    double centerX = size.width / 2;
    double centerY = size.height / 2;

    canvas.save();
    canvas.translate(centerX, centerY);
    canvas.rotate(rotationAngle);

    canvas.drawCircle(const Offset(0, 0), radius, paint);

    // Draw sectors
    double angle = 2 * pi / 8; // Divide by the number of sectors
    for (int i = 0; i < 8; i++) {
      paint.color = i == selectedSector ? Colors.red : Colors.greenAccent;
      canvas.drawArc(
        Rect.fromCircle(center: const Offset(0, 0), radius: radius),
        angle * i,
        angle,
        true,
        paint,
      );
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
