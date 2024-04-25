
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class DinoGameScreen extends StatefulWidget {
  const DinoGameScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DinoGameState createState() => _DinoGameState();
}

class _DinoGameState extends State<DinoGameScreen> {
  double dinoBottom = 0;
  double jumpHeight = 280;
  bool isJumping = false;
  double cactusLeft = 0;
  double cactusBottom = 50;
  bool isGameOver = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey[200],
              child: Stack(
                children: [
                  DinoWidget(dinoBottom: dinoBottom, cactusLeft: cactusLeft),
                  CactusWidget(cactusLeft: cactusLeft, cactusBottom: cactusBottom),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[400],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isGameOver
                      ? const Text(
                          'Game Over!',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Container(),
                  TextButton(
                    onPressed: () {
                      if (!isJumping && !isGameOver) {
                        jump();
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Jump',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void jump() {
    isJumping = true;
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (timer.tick == 5) {
        timer.cancel();
        isJumping = false;
        setState(() {
          dinoBottom = 0;
        });
      } else {
        setState(() {
          dinoBottom = jumpHeight - (jumpHeight * sin(timer.tick * 0.2));
        });
      }
    });
  }

  void moveCactus() {
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (!isGameOver) {
        setState(() {
          cactusLeft -= 5;
        });

        if (cactusLeft < -10) {
          cactusLeft = MediaQuery.of(context).size.width;
          // Randomize cactus height
          cactusBottom = Random().nextDouble() + 50;
        }

        if ((cactusLeft < 80 && cactusLeft > 0) && (dinoBottom < cactusBottom + 50)) {
          // gameOver();
        }
      }
    });
  }

  void gameOver() {
    isGameOver = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    moveCactus();
  }
}


class DinoWidget extends StatelessWidget {
  final double dinoBottom;
  final double cactusLeft;

  const DinoWidget({Key? key, required this.dinoBottom, required this.cactusLeft}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20, 
      bottom: dinoBottom,
      child: Container(
        alignment: const Alignment(0, 0),
        padding: const EdgeInsets.only(bottom: 0),
        child: Image.asset(
          'assets/dino.png',
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}


class CactusWidget extends StatelessWidget {
  final double cactusLeft;
  final double cactusBottom;

  const CactusWidget({Key? key, required this.cactusLeft, required this.cactusBottom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: cactusLeft,
      bottom: cactusBottom,
      child: Container(
        padding: const EdgeInsets.only(bottom: 50),
        child: Image.asset(
          'assets/cactus.png',
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}
