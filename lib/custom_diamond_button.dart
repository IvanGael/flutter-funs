import 'package:flutter/material.dart';

class DiamondButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double width;
  final double height;
  final Color backgroundColor;

  const DiamondButton({super.key, 
    required this.onPressed,
    required this.child,
    this.width = 100.0,
    this.height = 100.0,
    this.backgroundColor = Colors.blue
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: onPressed,
        child: SizedBox(
          width: width,
          height: height,
          child: CustomPaint(
            painter: DiamondPainter(backgroundColor),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}

class DiamondPainter extends CustomPainter {
  final Color color;

  DiamondPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;

    Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, size.height / 2);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}