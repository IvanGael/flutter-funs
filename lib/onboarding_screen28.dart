
import 'package:flutter/material.dart';

class OnboardingScreen28 extends StatefulWidget {
  const OnboardingScreen28({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen28>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.decelerate,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LiquidBackground(animation: _animation),
          const Center(
            child: Text(
              'Welcome',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LiquidBackground extends StatelessWidget {
  final Animation<double> animation;

  const LiquidBackground({Key? key, required this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return CustomPaint(
          painter: LiquidPainter(animation.value),
          size: MediaQuery.of(context).size, // Ensure the custom paint covers the entire screen
        );
      },
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
        Colors.deepPurpleAccent.withOpacity(0.3),
        Colors.deepPurpleAccent.withOpacity(0.3),
        Colors.deepPurpleAccent.withOpacity(0.3),
      ],
      stops: const [0.3, 0.5, 0.7],
    );

    final rect = Rect.fromPoints(Offset(0, size.height * 0.6), Offset(size.width, size.height));

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
