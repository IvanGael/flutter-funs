

import 'package:flutter/material.dart';

class PuzzleGameScreen extends StatefulWidget {
  const PuzzleGameScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PuzzleGameState createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<PuzzleGameScreen> {
  late List<int> puzzlePieces;
  late int emptyIndex;

  @override
  void initState() {
    super.initState();
    initializePuzzle();
  }

  void initializePuzzle() {
    puzzlePieces = List.generate(9, (index) => index + 1)..shuffle();
    emptyIndex = 8; // Initially, the last piece is empty
  }

  void onPieceTap(int index) {
    if (isMoveValid(index)) {
      setState(() {
        swapPieces(index);
        if (isPuzzleSolved()) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Congratulations!'),
                content: const Text('You solved the puzzle!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      initializePuzzle();
                    },
                    child: const Text('Play Again'),
                  ),
                ],
              );
            },
          );
        }
      });
    }
  }

  bool isMoveValid(int index) {
    // Check if the selected piece can be moved
    return ((index - emptyIndex).abs() == 1 && index ~/ 3 == emptyIndex ~/ 3) ||
        ((index - emptyIndex).abs() == 3 && index % 3 == emptyIndex % 3);
  }

  void swapPieces(int index) {
    setState(() {
      int temp = puzzlePieces[index];
      puzzlePieces[index] = puzzlePieces[emptyIndex];
      puzzlePieces[emptyIndex] = temp;
      emptyIndex = index;
    });
  }

  bool isPuzzleSolved() {
    // Check if the puzzle pieces are in ascending order
    for (int i = 0; i < puzzlePieces.length - 1; i++) {
      if (puzzlePieces[i] != i + 1) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Puzzle Game'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onPieceTap(index),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Text(
                  puzzlePieces[index] != 9 ? '${puzzlePieces[index]}' : '',
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}