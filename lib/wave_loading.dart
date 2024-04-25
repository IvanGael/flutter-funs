import 'dart:math';
import 'package:flutter/material.dart';

class WaveLoadingIndicatorTestScreen extends StatelessWidget {
  const WaveLoadingIndicatorTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: WaveLoadingIndicator(),
        ),
      );
  }
}

class WaveLoadingIndicator extends StatefulWidget {
  const WaveLoadingIndicator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WaveLoadingIndicatorState createState() => _WaveLoadingIndicatorState();
}

class _WaveLoadingIndicatorState extends State<WaveLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.repeat(reverse: true);
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
          painter: WavePainter(_animation.value),
          size: const Size(200, 100),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double progress;

  WavePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final wavePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final wavePath = Path();

    const waveHeight = 20.0;

    final waveWidth = size.width * 0.8;
    final waveMidPoint = size.height * (1 - progress);

    wavePath.moveTo(0, waveMidPoint);

    for (double i = 0; i <= size.width; i++) {
      final x = i;
      final y = sin((i / waveWidth) * 2 * pi) * waveHeight + waveMidPoint;
      wavePath.lineTo(x, y);
    }

    wavePath.lineTo(size.width, size.height);
    wavePath.lineTo(0, size.height);
    wavePath.close();

    canvas.drawPath(wavePath, wavePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
