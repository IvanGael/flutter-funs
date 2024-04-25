import 'package:flutter/material.dart';


class BrushStrokeEffect extends StatelessWidget {
  const BrushStrokeEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
      child: BrushStroke(),
    ),
    );
  }
}

class BrushStrokePainter extends CustomPainter {
  final List<Offset> points;

  BrushStrokePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 15.0;

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
        }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class BrushStroke extends StatefulWidget {
  const BrushStroke({super.key});

  @override
  _BrushStrokeState createState() => _BrushStrokeState();
}

class _BrushStrokeState extends State<BrushStroke> {
  List<Offset> points = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          RenderBox renderBox = context.findRenderObject() as RenderBox;
          points.add(renderBox.globalToLocal(details.globalPosition));
        });
      },
      onPanEnd: (details) {
        // points.add(null);
      },
      child: CustomPaint(
        painter: BrushStrokePainter(points),
      ),
    );
  }
}