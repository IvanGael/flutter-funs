import 'dart:math';

import 'package:flutter/material.dart';

class MazeGameScreen extends StatelessWidget {
  const MazeGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maze Game'),
      ),
      body: const MazeWidget(),
    );
  }
}

class MazeWidget extends StatefulWidget {
  const MazeWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MazeWidgetState createState() => _MazeWidgetState();
}

class _MazeWidgetState extends State<MazeWidget> {
  late List<List<int>> maze;
  int rows = 10;
  int cols = 10;
  int playerRow = 0;
  int playerCol = 0;

  @override
  void initState() {
    super.initState();
    generateMaze();
  }

  void generateMaze() {
    maze = List.generate(
        rows, (i) => List.generate(cols, (j) => Random().nextInt(2)));
    maze[0][0] = 0; // Ensure starting point is open
    maze[rows - 1][cols - 1] = 0; // Ensure ending point is open
  }

  void movePlayer(int newRow, int newCol) {
    if (newRow >= 0 &&
        newRow < rows &&
        newCol >= 0 &&
        newCol < cols &&
        maze[newRow][newCol] == 0) {
      setState(() {
        playerRow = newRow;
        playerCol = newCol;
      });
    }
  }

  Widget buildMaze() {
    List<Widget> rowsWidgets = [];

    for (int i = 0; i < rows; i++) {
      List<Widget> rowWidgets = [];
      for (int j = 0; j < cols; j++) {
        Color color = maze[i][j] == 1 ? Colors.teal[800]! : Colors.white;
        rowWidgets.add(
          Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.grey),
            ),
            child: (i == playerRow && j == playerCol)
                ? Center(
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Colors.red[900]!,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                : null,
          ),
        );
      }
      rowsWidgets.add(
        Row(
          children: rowWidgets,
        ),
      );
    }

    return Column(
      children: rowsWidgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: buildMaze(),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => movePlayer(playerRow - 1, playerCol), // Up
              child: const Text('Up'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => movePlayer(playerRow, playerCol - 1), // Left
              child: const Text('Left'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () => movePlayer(playerRow, playerCol + 1), // Right
              child: const Text('Right'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => movePlayer(playerRow + 1, playerCol), // Down
              child: const Text('Down'),
            ),
          ],
        ),
      ],
    );
  }
}
