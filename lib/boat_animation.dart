import 'package:flutter/material.dart';
import 'package:flutter_explosive_like/onboarding_screen28.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';

class BoatAnimationTestScreen extends StatefulWidget {
  const BoatAnimationTestScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BoatAnimationState createState() => _BoatAnimationState();
}

class _BoatAnimationState extends State<BoatAnimationTestScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _boatPosition;
  double boatTop = 400;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..addListener(() async {
      if(_controller.status == AnimationStatus.forward){
        setState(() {
          boatTop = 406;
        });

        await Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            boatTop = 400;
          });
        });
      }
        
      });

    _boatPosition = Tween<double>(
      begin: -1.0,
      end: 1.0,
    ).animate(_controller);

    _controller.forward();

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SeaWave(animation: _controller),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Positioned(
                      // bottom: 80 + 100 * _boatPosition.value,
                      top: boatTop,
                      left: MediaQuery.of(context).size.width / 2 - 50,
                      child: Image.asset(
                        'assets/boat.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class SeaWave extends StatelessWidget {
  final Animation<double> animation;

  const SeaWave({Key? key, required this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return CustomPaint(
          painter: LiquidPainter(animation.value),
          size: MediaQuery.of(context).size,
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
    const gradient = LinearGradient(
      colors: [
        Colors.blue,
        Colors.blue,
        Colors.blue,
      ],
      stops: [0.3, 0.5, 0.7],
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
