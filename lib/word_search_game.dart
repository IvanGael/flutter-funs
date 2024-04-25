
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class WordSearchGame extends StatefulWidget {
  const WordSearchGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WordSearchScreenState createState() => _WordSearchScreenState();
}

class _WordSearchScreenState extends State<WordSearchGame> {
  List<String> words = ["FLUTTER", "DART", "WIDGET", "GPT", "WORD", "SEARCH"];
  List<List<String>> grid = [];
  int gridSize = 10;
  int timeLimit = 120; // in seconds
  int currentTime = 0;
  bool isGameStarted = false;
  bool isGameFinished = false;

  @override
  void initState() {
    super.initState();
    initializeGrid();
  }

  void initializeGrid() {
    grid = List.generate(
      gridSize,
      (index) => List.generate(gridSize, (index) => randomAlphabet()),
    );

    for (String word in words) {
      placeWord(word);
    }
  }

  void placeWord(String word) {
    Random random = Random();
    bool placed = false;

    while (!placed) {
      int direction = random.nextInt(4); // 0: horizontal, 1: vertical, 2: diagonal top-left to bottom-right, 3: diagonal top-right to bottom-left

      int row = random.nextInt(gridSize);
      int col = random.nextInt(gridSize);

      List<String> wordChars = word.split("");

      // Check if the word can fit in the selected direction
      bool canPlace = true;
      for (int i = 0; i < wordChars.length; i++) {
        int currentRow = direction == 1 ? row + i : row;
        int currentCol = direction == 0 ? col + i : col;
        // ignore: unnecessary_null_comparison
        if (currentRow >= gridSize || currentCol >= gridSize || grid[currentRow][currentCol] != null) {
          canPlace = false;
          break;
        }
      }

      // Place the word in the grid if it can fit
      if (canPlace) {
        for (int i = 0; i < wordChars.length; i++) {
          int currentRow = direction == 1 ? row + i : row;
          int currentCol = direction == 0 ? col + i : col;
          grid[currentRow][currentCol] = wordChars[i];
        }
        placed = true;
      }
    }
  }

  String randomAlphabet() {
    Random random = Random();
    int randomNumber = random.nextInt(26);
    return String.fromCharCode('A'.codeUnitAt(0) + randomNumber);
  }

  void startGame() {
    isGameStarted = true;
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (currentTime < timeLimit) {
          currentTime++;
        } else {
          timer.cancel();
          isGameFinished = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Search Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isGameFinished
                ? const Text(
                    'Game Over!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )
                : Text(
                    'Time Remaining: ${timeLimit - currentTime} seconds',
                    style: const TextStyle(fontSize: 18),
                  ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridSize,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemBuilder: (context, index) {
                int row = index ~/ gridSize;
                int col = index % gridSize;
                return GestureDetector(
                  onTap: () {
                    if (isGameStarted && !isGameFinished) {
                      // Handle cell tap logic here
                    }
                  },
                  child: Container(
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        grid[row][col] ?? '',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
              itemCount: gridSize * gridSize,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (!isGameStarted && !isGameFinished) {
                  startGame();
                }
              },
              child: const Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}