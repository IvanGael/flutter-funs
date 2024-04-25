import 'dart:math';

import 'package:flutter/material.dart';



class TrampolineGame extends StatefulWidget {
  const TrampolineGame({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TrampolineGameState createState() => _TrampolineGameState();
}

class _TrampolineGameState extends State<TrampolineGame> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  double objectSize = 30.0;
  double trampolineHeight = 60.0;
  double trampolinePosition = 150.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 400).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
  }

  void moveTrampolineLeft() {
    setState(() {
      trampolinePosition = max(50, trampolinePosition - 20);
    });
  }

  void moveTrampolineRight() {
    setState(() {
      trampolinePosition = min(250, trampolinePosition + 20);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              painter: TrampolinePainter(_animation.value, objectSize, trampolineHeight, trampolinePosition),
              size: const Size(300, 500),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: moveTrampolineLeft,
                  child: const Icon(Icons.arrow_back),
                ),
                // const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: moveTrampolineRight,
                  child: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class TrampolinePainter extends CustomPainter {
  final double objectY;
  final double objectSize;
  final double trampolineHeight;
  final double trampolinePosition;

  TrampolinePainter(this.objectY, this.objectSize, this.trampolineHeight, this.trampolinePosition);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw trampoline
    Paint trampolinePaint = Paint()..color = Colors.deepPurple;
    canvas.drawRect(
      Rect.fromPoints(
        Offset(trampolinePosition - 50, size.height - trampolineHeight),
        Offset(trampolinePosition + 50, size.height),
      ),
      trampolinePaint,
    );

    // Draw falling object with bounce effect
    Paint objectPaint = Paint()..color = Colors.greenAccent;
    double bounce = sin(objectY * pi / 600); // Apply sinusoidal bounce effect
    double adjustedObjectY = size.height - trampolineHeight - objectSize - objectY + bounce * 50.0;
    canvas.drawCircle(Offset(trampolinePosition, adjustedObjectY), objectSize, objectPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


// class TrampolineAnimation extends StatefulWidget {
//   const TrampolineAnimation({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _TrampolineAnimationState createState() => _TrampolineAnimationState();
// }

// class _TrampolineAnimationState extends State<TrampolineAnimation> with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   double objectSize = 30.0;
//   double trampolineHeight = 60.0;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );

//     _animation = Tween<double>(begin: 0, end: 400).animate(_controller)
//       ..addListener(() {
//         setState(() {});
//       });

//     _animation.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         _controller.reverse();
//       } else if (status == AnimationStatus.dismissed) {
//         _controller.forward();
//       }
//     });

//     _controller.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: CustomPaint(
//           painter: TrampolinePainter(_animation.value, objectSize, trampolineHeight),
//           size: const Size(300, 500),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

// class TrampolinePainter extends CustomPainter {
//   final double objectY;
//   final double objectSize;
//   final double trampolineHeight;

//   TrampolinePainter(this.objectY, this.objectSize, this.trampolineHeight);

//   @override
//   void paint(Canvas canvas, Size size) {
//     // Draw trampoline
//     Paint trampolinePaint = Paint()..color = Colors.amber;
//     canvas.drawRect(Rect.fromPoints(Offset(50, size.height - trampolineHeight), Offset(250, size.height)), trampolinePaint);

//     // Draw falling object with bounce effect
//     Paint objectPaint = Paint()..color = Colors.blue;
//     double bounce = sin(objectY * pi / 600); // Apply sinusoidal bounce effect
//     double adjustedObjectY = size.height - trampolineHeight - objectSize - objectY + bounce * 50.0;
//     canvas.drawCircle(Offset(150, adjustedObjectY), objectSize, objectPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
