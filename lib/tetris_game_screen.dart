import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TetrisGameScreen extends StatefulWidget {
  const TetrisGameScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TetrisGameState createState() => _TetrisGameState();
}

class _TetrisGameState extends State<TetrisGameScreen> {
  final int rows = 20;
  final int columns = 10;
  final List<List<int>> grid = List.generate(20, (i) => List.filled(10, 0));

  final List<List<int>> tetromino = [
    [1, 1, 1, 1],
  ];

  int currentRow = 0;
  int currentColumn = 0;

  Timer? gameTimer;

  @override
  void initState() {
    super.initState();
    spawnTetromino();
    startGame();
  }

  void startGame() {
    gameTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!moveTetrominoDown()) {
        clearLines();
        spawnTetromino();
      }
    });
  }

  void spawnTetromino() {
    currentRow = 0;
    currentColumn = columns ~/ 2 - tetromino[0].length ~/ 2;
    for (int i = 0; i < tetromino.length; i++) {
      for (int j = 0; j < tetromino[i].length; j++) {
        if (tetromino[i][j] == 1) {
          if (grid[currentRow + i][currentColumn + j] == 1) {
            // Game Over
            // Handle game over logic here
            // print('Game Over');
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          }
          grid[currentRow + i][currentColumn + j] = 1;
        }
      }
    }
  }

  bool moveTetrominoDown() {
    if (canMove(currentRow + 1, currentColumn)) {
      clearTetromino();
      currentRow++;
      spawnTetromino();
      return true;
    }
    return false;
  }

  bool canMove(int newRow, int newColumn) {
    for (int i = 0; i < tetromino.length; i++) {
      for (int j = 0; j < tetromino[i].length; j++) {
        if (tetromino[i][j] == 1) {
          if (newRow + i >= rows ||
              newColumn + j < 0 ||
              newColumn + j >= columns ||
              grid[newRow + i][newColumn + j] == 1) {
            return false;
          }
        }
      }
    }
    return true;
  }

  void clearTetromino() {
    for (int i = 0; i < tetromino.length; i++) {
      for (int j = 0; j < tetromino[i].length; j++) {
        if (tetromino[i][j] == 1) {
          grid[currentRow + i][currentColumn + j] = 0;
        }
      }
    }
  }

  void clearLines() {
    for (int i = rows - 1; i >= 0; i--) {
      if (grid[i].every((cell) => cell == 1)) {
        grid.removeAt(i);
        grid.insert(0, List.filled(columns, 0));
      }
    }
  }

  void moveTetrominoLeft() {
    if (canMove(currentRow, currentColumn - 1)) {
      clearTetromino();
      currentColumn--;
      spawnTetromino();
    }
  }

  void moveTetrominoRight() {
    if (canMove(currentRow, currentColumn + 1)) {
      clearTetromino();
      currentColumn++;
      spawnTetromino();
    }
  }

  void moveTetrominoUp() {
    // Add logic for moving Tetromino up if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tetris'),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            // Buttons for moving Tetromino
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    moveTetrominoLeft();
                    gameTimer?.cancel();
                  },
                  child: const Text('Left'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    moveTetrominoRight();
                    gameTimer?.cancel();
                  },
                  child: const Text('Right'),
                ),
                // You can add more buttons for up and down if needed
              ],
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: columns / rows,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    int row = index ~/ columns;
                    int col = index % columns;
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade800),
                        color: grid[row][col] == 1 ? Colors.blue : Colors.black,
                      ),
                    );
                  },
                  itemCount: rows * columns,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
