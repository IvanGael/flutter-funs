
import 'package:flutter/material.dart';

class PaintBrushEffect extends StatefulWidget {
  const PaintBrushEffect({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PaintBrushEffectState createState() => _PaintBrushEffectState();
}

class _PaintBrushEffectState extends State<PaintBrushEffect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/a.png'), // Remplacez cela par votre image de fond
          fit: BoxFit.cover,
        ),
      ),
      child: CustomPaint(
        painter: BrushPainter(),
        child: const Center(
          // Vos éléments ici
          child: Text(
            'Coup de Pinceau',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class BrushPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;

    // Dessinez vos formes avec le pinceau ici
    canvas.drawLine(const Offset(50, 50), const Offset(200, 200), paint);
    canvas.drawCircle(const Offset(300, 100), 50, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}