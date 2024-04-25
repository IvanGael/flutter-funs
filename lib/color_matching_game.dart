
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ColorMatchingGame extends StatefulWidget {
  const ColorMatchingGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ColorMatchingGameState createState() => _ColorMatchingGameState();
}

class _ColorMatchingGameState extends State<ColorMatchingGame> {
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
  ];
  Color? targetColor;
  int score = 0;
  int level = 1;
  bool isGameOver = false;
  bool isGamePaused = false;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    _generateTargetColor();
    _startLevel();
  }

  void _generateTargetColor() {
    final random = Random();
    targetColor = colors[random.nextInt(colors.length)];
  }

  void _startLevel() {
    isGameOver = false;
    isGamePaused = false;

    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (!isGameOver && !isGamePaused) {
        _generateTargetColor();
        level++;
        _showNextLevelDialog();
      }
    });
  }

  void _showNextLevelDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Level $level'),
          content: const Text('Get ready for the next challenge!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Start'),
            ),
          ],
        );
      },
    );
  }

  void _onTap(Color tappedColor) {
    if (isGameOver || isGamePaused) return;

    if (tappedColor == targetColor) {
      _playCorrectSound();
      score++;
    } else {
      _playIncorrectSound();
      _endGame();
    }
  }

  void _playCorrectSound() {
    // Implement sound effect or other feedback for correct selection
  }

  void _playIncorrectSound() {
    // Implement sound effect or other feedback for incorrect selection
  }

  void _endGame() {
    isGameOver = true;
    isGamePaused = true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text('Your score: $score'),
          actions: <Widget>[
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
      appBar: AppBar(
        title: const Text('Color Matching Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Score: $score',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => _onTap(colors[0]),
              child: _buildColorButton(colors[0]),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _onTap(colors[1]),
              child: _buildColorButton(colors[1]),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _onTap(colors[2]),
              child: _buildColorButton(colors[2]),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _onTap(colors[3]),
              child: _buildColorButton(colors[3]),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _onTap(colors[4]),
              child: _buildColorButton(colors[4]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorButton(Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}