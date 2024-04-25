
import 'dart:math';

import 'package:flutter/material.dart';

class RainDrops extends StatefulWidget {
  const RainDrops({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RainDropsState createState() => _RainDropsState();
}

class _RainDropsState extends State<RainDrops> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Offset> rainDrops;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _controller.addListener(() {
      setState(() {
        rainDrops = List.generate(30, (index) {
          double randomX = Random().nextDouble() * MediaQuery.of(context).size.width;
          double y = _controller.value * MediaQuery.of(context).size.height;
          return Offset(randomX, y);
        });
      });
    });

    rainDrops = List.generate(30, (index) {
      double randomX = Random().nextDouble() * MediaQuery.of(context).size.width;
      double y = _controller.value * MediaQuery.of(context).size.height;
      return Offset(randomX, y);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RainPainter(rainDrops),
    );
  }
}

class RainPainter extends CustomPainter {
  final List<Offset> rainDrops;

  RainPainter(this.rainDrops);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    for (var offset in rainDrops) {
      canvas.drawLine(offset, Offset(offset.dx, offset.dy + 10.0), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}