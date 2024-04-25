import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';


class WhackAMoleGame extends StatefulWidget {
  const WhackAMoleGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WhackAMoleGameState createState() => _WhackAMoleGameState();
}

class _WhackAMoleGameState extends State<WhackAMoleGame> {
  bool _gameOver = false;
  int _score = 0;
  final List<bool> _moles = List.generate(20, (index) => false);

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    _gameOver = false;
    _score = 0;
    _moles.fillRange(0, _moles.length, false);
    _startMoleTimer();
  }

  void _startMoleTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_gameOver) {
        _showRandomMole();
      } else {
        timer.cancel();
      }
    });
  }

  void _showRandomMole() {
    int randomIndex = Random().nextInt(_moles.length);
    setState(() {
      _moles[randomIndex] = true;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _moles[randomIndex] = false;
      });
    });
  }

  void _whackMole(int index) {
    if (_moles[index]) {
      setState(() {
        _moles[index] = false;
        _score++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: _moles.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _whackMole(index),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _moles[index] ? Colors.deepPurpleAccent : Colors.blueGrey,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Center(
                      child: Text(
                        _moles[index] ? '🐭' : '',
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Score: $_score',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            _gameOver
                ? FilledButton(
                    onPressed: _startGame,
                    child: const Text('Play Again'),
                  )
                : Container(),
          ],
        ),
      ),
      ),
    );
  }
}
