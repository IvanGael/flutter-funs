import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';


class PinballTennisScreen extends StatefulWidget {
  const PinballTennisScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PinballTennisScreenState createState() => _PinballTennisScreenState();
}

class _PinballTennisScreenState extends State<PinballTennisScreen> {
  static const double paddleWidth = 100.0;
  static const double paddleHeight = 20.0;
  static const double ballSize = 20.0;
  static const double initialBallSpeed = 2.0;

  double paddlePosition = 0.0;
  Offset ballPosition = Offset.zero;
  Offset ballVelocity = const Offset(initialBallSpeed, initialBallSpeed);

  @override
  void initState() {
    super.initState();
    startGameLoop();
  }

  void startGameLoop() {
    Timer.periodic(const Duration(milliseconds: 16), (Timer timer) {
      setState(() {
        updateBall();
      });
    });
  }

  void updateBall() {
    ballPosition += ballVelocity;
    if (ballPosition.dx <= 0 || ballPosition.dx >= MediaQuery.of(context).size.width - ballSize) {
      ballVelocity = Offset(-ballVelocity.dx, ballVelocity.dy);
    }
    if (ballPosition.dy <= 0 || ballPosition.dy >= MediaQuery.of(context).size.height - ballSize) {
      ballVelocity = Offset(ballVelocity.dx, -ballVelocity.dy);
    }

    if (ballPosition.dx >= paddlePosition &&
        ballPosition.dx <= paddlePosition + paddleWidth &&
        ballPosition.dy >= MediaQuery.of(context).size.height - paddleHeight - ballSize) {
      ballVelocity = Offset(ballVelocity.dx, -ballVelocity.dy);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            paddlePosition = details.globalPosition.dx - paddleWidth / 2;
          });
        },
        child: Container(
          color: Colors.black,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: ballPosition.dy,
                left: ballPosition.dx,
                child: Container(
                  width: ballSize,
                  height: ballSize,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: paddlePosition,
                child: Container(
                  width: paddleWidth,
                  height: paddleHeight,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
