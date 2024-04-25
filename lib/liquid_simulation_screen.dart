import 'package:flutter/material.dart';

class LiquidSimulationScreen extends StatefulWidget {
  const LiquidSimulationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LiquidSimulationScreenState createState() => _LiquidSimulationScreenState();
}

class _LiquidSimulationScreenState extends State<LiquidSimulationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: LiquidWidget(),
      ),
    );
  }
}

class LiquidWidget extends StatefulWidget {
  const LiquidWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LiquidWidgetState createState() => _LiquidWidgetState();
}

class _LiquidWidgetState extends State<LiquidWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: CustomPaint(
        painter: LiquidPainter(),
      ),
    );
  }
}

class LiquidPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0, size.height * 0.8)
      ..quadraticBezierTo(
          size.width * 0.25, size.height, size.width * 0.5, size.height * 0.8)
      ..quadraticBezierTo(
          size.width * 0.75, size.height * 0.6, size.width, size.height * 0.8)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}