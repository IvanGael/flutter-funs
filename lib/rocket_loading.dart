
import 'package:flutter/material.dart';


class RocketLaunchLoaderTestScreen extends StatelessWidget {
  const RocketLaunchLoaderTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: RocketLaunchLoader(),
        ),
      );
  }
}

class RocketLaunchLoader extends StatefulWidget {
  const RocketLaunchLoader({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RocketLaunchLoaderState createState() => _RocketLaunchLoaderState();
}

class _RocketLaunchLoaderState extends State<RocketLaunchLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: 0, end: 1.5).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: RocketPainter(_animation.value),
          child: Container(),
        );
      },
    );
  }
}

class RocketPainter extends CustomPainter {
  final double progress;

  RocketPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.deepPurple
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    double rocketHeight = size.height * 0.8;
    double rocketWidth = size.width * 0.2;

    double flameHeight = rocketHeight * progress;

    // Draw rocket body
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height - rocketHeight / 2),
        width: rocketWidth,
        height: rocketHeight,
      ),
      paint,
    );

    // Draw rocket head
    Path path = Path()
      ..moveTo(size.width / 2 - rocketWidth / 2, size.height - rocketHeight / 2)
      ..lineTo(size.width / 2, size.height - rocketHeight * 1.2)
      ..lineTo(size.width / 2 + rocketWidth / 2, size.height - rocketHeight / 2)
      ..close();

    canvas.drawPath(path, paint);

    // Draw rocket flame
    paint.color = Colors.greenAccent;
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height),
        width: rocketWidth,
        height: flameHeight,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
