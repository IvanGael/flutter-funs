import 'package:flutter/material.dart';
import 'dart:async';

class MemoryMatchGame extends StatefulWidget {
  const MemoryMatchGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MemoryMatchGameState createState() => _MemoryMatchGameState();
}

class _MemoryMatchGameState extends State<MemoryMatchGame> {
  List<String> images = [
    '🌈',
    '🌈',
    '🎈',
    '🎈',
    '🌟',
    '🌟',
    '🎁',
    '🎁',
    '🚀',
    '🚀',
    '🌺',
    '🌺',
    '🍦',
    '🍦',
    '🍭',
    '🍭',
  ];

  List<String> shuffledImages = [];
  List<bool> flipped = [];
  List<int> indexes = [];
  bool isProcessing = false;
  int numberOfMatches = 0;
  int maxMatches = 8;
  int secondsRemaining = 60;
  bool hasGameEnded = false;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    images.shuffle();
    shuffledImages = List<String>.from(images);
    flipped = List<bool>.generate(images.length, (index) => false);
    numberOfMatches = 0;
    indexes = [];
    isProcessing = false;
    secondsRemaining = 60;

    // Timer to count down the time
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsRemaining > 0 && numberOfMatches < maxMatches) {
          secondsRemaining--;
        } else {
          timer.cancel();
          if (!hasGameEnded) {
            showGameOverDialog();
          }
        }
      });
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Game Over"),
          content: Text("You matched $numberOfMatches pairs!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                startGame();
              },
              child: const Text("Play Again"),
            ),
          ],
        );
      },
    );
  }

  void _onCardTap(int index) {
    if (!isProcessing && !flipped[index]) {
      setState(() {
        flipped[index] = true;
      });

      if (indexes.length < 2) {
        indexes.add(index);
      }

      if (indexes.length == 2) {
        isProcessing = true;
        Future.delayed(const Duration(milliseconds: 1000), () {
          checkForMatch();
        });
      }
    }
  }

  void showGameWinDialog() {
    setState(() {
      hasGameEnded = true;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Congratulations!"),
          content: const Text("You won!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                startGame();
              },
              child: const Text("Play Again"),
            ),
          ],
        );
      },
    );
  }

  void checkForMatch() {
    int index1 = indexes[0];
    int index2 = indexes[1];

    if (shuffledImages[index1] == shuffledImages[index2]) {
      numberOfMatches++;
      if (numberOfMatches == maxMatches) {
        showGameWinDialog();
      }
    } else {
      setState(() {
        flipped[index1] = false;
        flipped[index2] = false;
      });
    }

    indexes = [];
    isProcessing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.punch_clock),
                Text(
                  ':${secondsRemaining}s',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            Text(
              'Matches: $numberOfMatches / $maxMatches',
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _onCardTap(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: flipped[index] ? Colors.white : Colors.blue,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          flipped[index] ? shuffledImages[index] : '🤔',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
