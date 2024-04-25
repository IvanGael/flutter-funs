import 'package:flutter/material.dart';

class GlassFillingUpScreen extends StatefulWidget {
  const GlassFillingUpScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GlassFillingUpScreenState createState() => _GlassFillingUpScreenState();
}

class _GlassFillingUpScreenState extends State<GlassFillingUpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    );

    _controller.repeat();

    Future.delayed(Duration(seconds: 20), () {
      _controller.stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Image.asset(
              'assets/glass.png',
              width: 300,
              height: 300,
            ),
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  // return ClipRect(
                  //   clipper: GlassClipper(),
                  //   child: Container(
                  //     width: 200,
                  //     height: 300 * _controller.value,
                  //     color: Colors.blue,
                  //   ),
                  // );
                  return CustomPaint(
                    painter: LiquidPainter(_controller.value),
                    size: Size(138, 500 * _controller.value),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LiquidPainter extends CustomPainter {
  final double animationValue;

  LiquidPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final gradient = LinearGradient(
      colors: [
        Colors.blue[600]!.withOpacity(0.3),
        Colors.blue[600]!.withOpacity(0.3),
        Colors.blue[600]!.withOpacity(0.3),
      ],
      stops: const [0.3, 0.5, 0.7],
    );

    final rect = Rect.fromPoints(
        Offset(0, size.height * 0.6), Offset(size.width, size.height));

    final paint = Paint()..shader = gradient.createShader(rect);

    final path = Path();

    path.moveTo(0, size.height * 0.6);

    path.quadraticBezierTo(
      size.width * 0.15,
      size.height * 0.65 + 50 * animationValue,
      size.width * 0.3,
      size.height * 0.6,
    );

    path.cubicTo(
      size.width * 0.5,
      size.height * 0.55 - 50 * animationValue,
      size.width * 0.7,
      size.height * 0.65 + 50 * animationValue,
      size.width * 0.85,
      size.height * 0.6,
    );

    path.quadraticBezierTo(
      size.width,
      size.height * 0.55 - 50 * animationValue,
      size.width,
      size.height * 0.6,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class GlassClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    var glassPath = Path()
      ..moveTo(
          size.width * 0.1, 0) // This represents the top left edge of the glass
      ..lineTo(size.width * 0.9,
          0) // This represents the top right edge of the glass
      ..lineTo(size.width,
          size.height) // This represents the bottom right edge of the glass
      ..addArc(Rect.fromCircle(center: Offset(50, 0), radius: 40), 0,
          size.height) // This represents the bottom left edge of the glass
      ..close(); // This closes the path to form a shape

    return glassPath.getBounds();
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}
