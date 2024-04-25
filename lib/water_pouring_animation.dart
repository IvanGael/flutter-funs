import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;

class WaterPouringAnimation extends StatefulWidget {
  const WaterPouringAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WaterPouringAnimationState createState() => _WaterPouringAnimationState();
}

class _WaterPouringAnimationState extends State<WaterPouringAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WaterPouringPainter(_animation.value),
      child: Container(),
    );
  }
}

class WaterPouringPainter extends CustomPainter {
  final double animationValue;
  late img.Image glassImage;

  WaterPouringPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) async {
    glassImage = await loadImage('assets/glass.png');

    Paint waterPaint = Paint()..color = Colors.blue.withOpacity(0.5);

    // Draw glass image
    final glassRect = Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height));
    
    // Convert img.Image to ui.Image
    final ByteData data = await rootBundle.load('assets/glass.png');
    final Uint8List bytes = data.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(Uint8List.fromList(bytes));
    final ui.Image image = (await codec.getNextFrame()).image;

    canvas.drawImageRect(
      image,
      Rect.fromPoints(const Offset(0, 0), Offset(image.width.toDouble(), image.height.toDouble())),
      glassRect,
      Paint()
    );

    // Draw water
    double waterHeight = size.height * animationValue;
    Rect waterRect = Rect.fromPoints(Offset(0, size.height - waterHeight), Offset(size.width, size.height));
    canvas.drawRect(waterRect, waterPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Future<img.Image> loadImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    final Uint8List bytes = data.buffer.asUint8List();
    return img.decodeImage(Uint8List.fromList(bytes))!;
  }
}
