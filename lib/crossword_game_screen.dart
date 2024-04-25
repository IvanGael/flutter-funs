import 'dart:math';

import 'package:flutter/material.dart';

class CrosswordGameScreen extends StatefulWidget {
  const CrosswordGameScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CrosswordGameState createState() => _CrosswordGameState();
}

class _CrosswordGameState extends State<CrosswordGameScreen> {
  List<List<String>> crosswordGrid = [];

  List<String> wordsToFind = ['APPLE', 'BOOKS', 'CHAIR', 'DOGS', 'ELEPHANT'];
  List<String> foundWords = [];
  int selectedRow = 0;
  int selectedCol = 0;
  String selectedWord = '';
  bool movedByButtons = false;


  @override
  void initState() {
    super.initState();
    generateRandomCrosswordGrid();
  }

  void generateRandomCrosswordGrid() {
    // Initialize an empty grid
    crosswordGrid = List.generate(10, (row) => List.generate(10, (col) => ''));

    // Shuffle the words randomly
    wordsToFind.shuffle();

    // Place each word in the grid
    for (String word in wordsToFind) {
      bool placed = false;
      while (!placed) {
        // Randomly choose a direction (0 for horizontal, 1 for vertical)
        int direction = Random().nextInt(2);

        // Randomly choose a starting position
        int startRow = Random().nextInt(crosswordGrid.length);
        int startCol = Random().nextInt(crosswordGrid[startRow].length);

        // Check if the word can be placed in the chosen direction
        bool canPlaceWord = true;
        for (int i = 0; i < word.length; i++) {
          int row = direction == 0 ? startRow : startRow + i;
          int col = direction == 1 ? startCol : startCol + i;

          if (row >= crosswordGrid.length || col >= crosswordGrid[row].length || crosswordGrid[row][col].isNotEmpty) {
            canPlaceWord = false;
            break;
          }
        }

        // Place the word if possible
        if (canPlaceWord) {
          for (int i = 0; i < word.length; i++) {
            int row = direction == 0 ? startRow : startRow + i;
            int col = direction == 1 ? startCol : startCol + i;

            crosswordGrid[row][col] = word[i];
          }
          placed = true;
        }
      }
    }

    // Fill the remaining empty cells with random letters
    for (int row = 0; row < crosswordGrid.length; row++) {
      for (int col = 0; col < crosswordGrid[row].length; col++) {
        if (crosswordGrid[row][col].isEmpty) {
          crosswordGrid[row][col] = String.fromCharCode(Random().nextInt(26) + 'A'.codeUnitAt(0));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crossword Game'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildCrosswordGrid(),
              const SizedBox(height: 20),
              buildFoundWords(),
              const SizedBox(height: 20),
              buildMoveButtons(),
              const SizedBox(height: 20),
              buildSelectLetterButton(),
              const SizedBox(height: 20),
              buildSelectWordButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCrosswordGrid() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: List.generate(crosswordGrid.length, (row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(crosswordGrid[row].length, (col) {
              return InkWell(
                onTap: () {
                  selectLetter(row, col);
                },
                child: Container(
                  width: 35,
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: (row == selectedRow && col == selectedCol)
                        ? (movedByButtons ? Colors.blue : Colors.pink)
                        : Colors.white,
                  ),
                  child: Text(
                    crosswordGrid[row][col],
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }

  Widget buildFoundWords() {
    return Column(
      children: List.generate(foundWords.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            foundWords[index],
            style: const TextStyle(fontSize: 18, color: Colors.greenAccent),
          ),
        );
      }),
    );
  }

  Widget buildMoveButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            moveSelectedLetter('UP');
          },
          child: const Icon(Icons.arrow_upward),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            moveSelectedLetter('DOWN');
          },
          child: const Icon(Icons.arrow_downward),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            moveSelectedLetter('LEFT');
          },
          child: const Icon(Icons.arrow_back),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            moveSelectedLetter('RIGHT');
          },
          child: const Icon(Icons.arrow_forward),
        ),
      ],
    );
  }

  Widget buildSelectLetterButton() {
    return ElevatedButton(
      onPressed: () {
        selectLetter(selectedRow, selectedCol);
      },
      child: const Text('Select Letter'),
    );
  }

  Widget buildSelectWordButton() {
    return ElevatedButton(
      onPressed: () {
        selectWord();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      ),
      child: const Text(
        'Show found word',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  void selectLetter(int row, int col) {
    setState(() {
      selectedRow = row;
      selectedCol = col;
      selectedWord += crosswordGrid[row][col];
      movedByButtons = false;
    });
  }

  void moveSelectedLetter(String direction) {
    setState(() {
      movedByButtons = true;
      switch (direction) {
        case 'UP':
          if (selectedRow > 0) selectedRow--;
          break;
        case 'DOWN':
          if (selectedRow < crosswordGrid.length - 1) selectedRow++;
          break;
        case 'LEFT':
          if (selectedCol > 0) selectedCol--;
          break;
        case 'RIGHT':
          if (selectedCol < crosswordGrid[selectedRow].length - 1) {
            selectedCol++;
          }
          break;
      }
    });
  }

  void selectWord() {
    if (wordsToFind.contains(selectedWord) &&
        !foundWords.contains(selectedWord)) {
      foundWords.add(selectedWord);
    }
    selectedWord = '';
    setState(() {
      selectedRow = 0;
      selectedCol = 0;
      movedByButtons = false;
    });
  }
}
