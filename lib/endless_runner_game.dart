
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class EndlessRunnerGame extends StatefulWidget {
  const EndlessRunnerGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EndlessRunnerGameState createState() => _EndlessRunnerGameState();
}

class _EndlessRunnerGameState extends State<EndlessRunnerGame> {
  double characterBottom = 0;
  double characterSize = 50;
  double obstacleSize = 50;
  List<Obstacle> obstacles = [];
  double gravity = 3;
  double jumpHeight = -60;
  bool isJumping = false;
  int score = 0;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    const duration = Duration(milliseconds: 30);
    obstacles = [];
    characterBottom = 0;
    score = 0;
    isJumping = false;

    // Game loop
    Timer.periodic(duration, (timer) {
      generateObstacle();
      moveCharacter();
      checkCollision();
      updateScore();

      // if (characterBottom > 0) {
      //   timer.cancel();
      //   showGameOverDialog();
      // }
    });
  }

  void generateObstacle() {
    Random random = Random();
    double obstaclePosition = random.nextDouble() * (MediaQuery.of(context).size.width - obstacleSize);
    obstacles.add(Obstacle(left: obstaclePosition, size: obstacleSize));
  }

  void moveCharacter() {
    if (isJumping) {
      characterBottom += jumpHeight;
      isJumping = false;
    } else {
      characterBottom += gravity;
    }
    setState(() {});
  }

  void checkCollision() {
    for (Obstacle obstacle in obstacles) {
      if (characterBottom >= 0 &&
          characterBottom <= obstacleSize &&
          obstacle.left <= characterSize &&
          obstacle.left + obstacle.size >= 0) {
        showGameOverDialog();
      }
    }
  }

  void updateScore() {
    setState(() {
      score++;
    });
  }

  void jump() {
    if (!isJumping) {
      isJumping = true;
    }
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text('Your score: $score'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                startGame();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: jump,
        child: Container(
          color: Colors.blueAccent,
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 30),
                alignment: Alignment(0, characterBottom),
                child: Image.asset('assets/person.png', width: characterSize, height: characterSize),
              ),
              for (Obstacle obstacle in obstacles)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 30),
                  alignment: Alignment(obstacle.left, MediaQuery.of(context).size.height - obstacleSize),
                  child: Image.asset('assets/cloud_shape.png', width: obstacleSize, height: obstacleSize),
                ),
              Positioned(
                top: 20,
                right: 20,
                child: Text('Score: $score', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Obstacle {
  double left;
  double size;

  Obstacle({required this.left, required this.size});
}