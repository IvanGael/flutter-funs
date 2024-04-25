import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

// class SpiderAnimation extends StatefulWidget {
//   const SpiderAnimation({Key? key}) : super(key: key);

//   @override
//   _SpiderAnimationState createState() => _SpiderAnimationState();
// }

// class _SpiderAnimationState extends State<SpiderAnimation>
//     with SingleTickerProviderStateMixin {
//   late RiveAnimationController _controller;
//   late Artboard _artboard;

//   @override
//   void initState() {
//     super.initState();

//     _controller = SimpleAnimation('spider_walk');

//     // Load the Rive file
//     loadRiveFile();

//     _controller.isActiveChanged.addListener(() {
//       if (!_controller.isActive) {
//         // Reverse animation when it reaches the end
        
//         // _controller.direction = _controller.direction == 1 ? -1 : 1;
//       }
//     });
//   }

//   Future<void> loadRiveFile() async {
//     final ByteData data = await rootBundle.load('assets/spider_animation.riv'); 
//     final RiveFile riveFile = RiveFile.import(data);

//     setState(() {
//       _artboard = riveFile.mainArtboard;
//       _artboard.addController(_controller);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       // ignore: unnecessary_null_comparison
//       child: _artboard != null
//           ? Rive(
//               artboard: _artboard,
//               fit: BoxFit.contain,
//               alignment: Alignment.center,
//             )
//           : const CircularProgressIndicator(),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }


class SpiderAnimation extends StatefulWidget {
  const SpiderAnimation({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SpiderAnimationState createState() => _SpiderAnimationState();
}

class _SpiderAnimationState extends State<SpiderAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationX;
  late Animation<double> _animationY;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animationX = Tween<double>(begin: -1, end: 1).animate(_controller);
    _animationY = Tween<double>(begin: -1, end: 1).animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: SpiderPainter(_animationX.value, _animationY.value, MediaQuery.of(context).size),
        size: const Size(200, 200),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class SpiderPainter extends CustomPainter {
  final double animationValueX;
  final double animationValueY;
  final Size screenSize;

  SpiderPainter(this.animationValueX, this.animationValueY, this.screenSize);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    const bodyRadius = 20.0;
    const legLength = 40.0;

    final bodyOffset = Offset(
      (screenSize.width / 2) + (animationValueX * (screenSize.width - 2 * bodyRadius)),
      (screenSize.height / 2) + (animationValueY * (screenSize.height - 2 * bodyRadius)),
    );

    // Draw body
    canvas.drawCircle(bodyOffset, bodyRadius, paint);

    // Draw legs
    drawLeg(canvas, bodyOffset, legLength, -1, -1);
    drawLeg(canvas, bodyOffset, legLength, 1, -1);
    drawLeg(canvas, bodyOffset, legLength, -1, 1);
    drawLeg(canvas, bodyOffset, legLength, 1, 1);
  }

  void drawLeg(
    Canvas canvas,
    Offset bodyOffset,
    double legLength,
    double directionX,
    double directionY,
  ) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final legStart = bodyOffset + Offset(directionX * 20, directionY * 20);
    final legEnd =
        legStart + Offset(directionX * legLength, directionY * legLength);

    canvas.drawLine(legStart, legEnd, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}