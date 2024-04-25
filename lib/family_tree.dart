
import 'package:flutter/material.dart';

class FamilyTreeWidget extends StatelessWidget {
  const FamilyTreeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FamilyTree(
          names: [
            "GG1",
            "GG2",
            "G1",
            "G2",
            "P1",
            "P2",
            "C1",
            "C2",
            "C3",
            "C4",
          ],
        ),
      ),
    );
  }
}

class FamilyTree extends StatelessWidget {
  final List<String> names;

  const FamilyTree({super.key, required this.names});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.0,
      height: 400.0,
      child: CustomPaint(
        painter: FamilyTreePainter(names: names),
      ),
    );
  }
}

class FamilyTreePainter extends CustomPainter {
  final List<String> names;

  FamilyTreePainter({required this.names});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0;

    // Customize your painting logic here
    // For simplicity, a basic example is provided.

    // Draw lines to represent the family tree
    canvas.drawLine(const Offset(150, 0), const Offset(150, 50), paint); // great-grandparents
    canvas.drawLine(const Offset(75, 50), const Offset(225, 50), paint); // grandparents
    canvas.drawLine(const Offset(37.5, 100), const Offset(112.5, 100), paint); // parents
    canvas.drawLine(const Offset(187.5, 100), const Offset(262.5, 100), paint); // parents
    canvas.drawLine(const Offset(18.75, 150), const Offset(56.25, 150), paint); // children
    canvas.drawLine(const Offset(93.75, 150), const Offset(131.25, 150), paint); // children
    canvas.drawLine(const Offset(168.75, 150), const Offset(206.25, 150), paint); // children
    canvas.drawLine(const Offset(243.75, 150), const Offset(281.25, 150), paint); // children

    // Draw names
    for (int i = 0; i < names.length; i++) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: names[i],
          style: const TextStyle(color: Colors.white),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(minWidth: 0, maxWidth: size.width);

      double x = (i % 2 == 0) ? size.width * 0.25 : size.width * 0.75;
      double y = 50.0 + (i ~/ 2) * 50.0;

      textPainter.paint(canvas, Offset(x, y));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
