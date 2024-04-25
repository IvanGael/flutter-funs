
import 'package:flutter/material.dart';

class JoystickTestScreen extends StatelessWidget {
  const JoystickTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: Joystick(),
        ),
      );
  }
}

class Joystick extends StatefulWidget {
  const Joystick({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _JoystickState createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  double knobX = 0.0;
  double knobY = 0.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 200.0,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            knobX += details.delta.dx;
            knobY += details.delta.dy;
            // Limit the knob movement within the container
            knobX = knobX.clamp(0.0, 200.0);
            knobY = knobY.clamp(0.0, 200.0);
          });
        },
        child: CustomPaint(
          painter: JoystickPainter(knobX, knobY),
        ),
      ),
    );
  }
}

class JoystickPainter extends CustomPainter {
  final double knobX;
  final double knobY;

  JoystickPainter(this.knobX, this.knobY);

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()..color = Colors.greenAccent;
    Paint knobPaint = Paint()..color = Colors.deepPurple;

    // Draw background circle
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, backgroundPaint);

    // Draw knob
    canvas.drawCircle(Offset(knobX, knobY), 20.0, knobPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
