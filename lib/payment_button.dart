import 'package:flutter/material.dart';

class PaymentButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const PaymentButton({super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: 200,
        height: 50,
        child: CustomPaint(
          painter: PaymentButtonPainter(),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentButtonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.pinkAccent
      ..style = PaintingStyle.fill;

    final rect = Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height));
    const radius = Radius.circular(10.0);

    final roundedRect = RRect.fromRectAndRadius(rect, radius);
    canvas.drawRRect(roundedRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
