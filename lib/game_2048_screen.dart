import 'dart:math';

import 'package:flutter/material.dart';

class Game2048Screen extends StatefulWidget {
  const Game2048Screen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Game2048State createState() => _Game2048State();
}

class _Game2048State extends State<Game2048Screen> {
  late List<List<int>> _board;
  late Random _random;

  @override
  void initState() {
    super.initState();
    _initBoard();
  }

  void _initBoard() {
    _board = List.generate(4, (i) => List<int>.filled(4, 0));
    _random = Random();
    _addRandomTile();
    _addRandomTile();
  }

  void _addRandomTile() {
    List<int> emptyTiles = [];
    for (int i = 0; i < _board.length; i++) {
      for (int j = 0; j < _board[i].length; j++) {
        if (_board[i][j] == 0) {
          emptyTiles.add(i * 4 + j);
        }
      }
    }

    if (emptyTiles.isNotEmpty) {
      int index = _random.nextInt(emptyTiles.length);
      int tileValue =
          _random.nextInt(10) < 9 ? 2 : 4; // 90% chance of 2, 10% chance of 4
      int row = emptyTiles[index] ~/ 4;
      int col = emptyTiles[index] % 4;
      _board[row][col] = tileValue;
    }
  }

  void _swipeLeft() {
    setState(() {
      for (int i = 0; i < _board.length; i++) {
        _board[i] = _mergeTiles(_board[i]);
      }
      _addRandomTile();
    });
  }

  void _swipeRight() {
    setState(() {
      for (int i = 0; i < _board.length; i++) {
        _board[i] = _mergeTiles(_board[i].reversed.toList()).reversed.toList();
      }
      _addRandomTile();
    });
  }

  void _swipeUp() {
    setState(() {
      for (int j = 0; j < _board[0].length; j++) {
        List<int> column = [];
        for (int i = 0; i < _board.length; i++) {
          column.add(_board[i][j]);
        }
        column = _mergeTiles(column);
        for (int i = 0; i < _board.length; i++) {
          _board[i][j] = column[i];
        }
      }
      _addRandomTile();
    });
  }

  void _swipeDown() {
    setState(() {
      for (int j = 0; j < _board[0].length; j++) {
        List<int> column = [];
        for (int i = 0; i < _board.length; i++) {
          column.add(_board[i][j]);
        }
        column = _mergeTiles(column.reversed.toList()).reversed.toList();
        for (int i = 0; i < _board.length; i++) {
          _board[i][j] = column[i];
        }
      }
      _addRandomTile();
    });
  }

  List<int> _mergeTiles(List<int> row) {
    row = row.where((tile) => tile != 0).toList();
    for (int i = 0; i < row.length - 1; i++) {
      if (row[i] == row[i + 1]) {
        row[i] *= 2;
        row[i + 1] = 0;
      }
    }
    row = row.where((tile) => tile != 0).toList();
    while (row.length < 4) {
      row.add(0);
    }
    return row;
  }

  void _mergeTilesAndUpdateState() {
    setState(() {
      for (int i = 0; i < _board.length; i++) {
        _board[i] = _mergeTiles(_board[i]);
      }
      _addRandomTile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2048 Game'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Reach 2048!',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity! > 0) {
                  _swipeDown();
                } else if (details.primaryVelocity! < 0) {
                  _swipeUp();
                }
              },
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! > 0) {
                  _swipeRight();
                } else if (details.primaryVelocity! < 0) {
                  _swipeLeft();
                }
              },
              child: Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (context, index) {
                    int row = index ~/ 4;
                    int col = index % 4;
                    return Container(
                      color: _getTileColor(_board[row][col]),
                      child: Center(
                        child: Text(
                          _board[row][col] != 0
                              ? _board[row][col].toString()
                              : '',
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 16,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _swipeLeft,
                child: const Icon(Icons.arrow_back),
              ),
              ElevatedButton(
                onPressed: _swipeUp,
                child: const Icon(Icons.arrow_upward),
              ),
              ElevatedButton(
                onPressed: _swipeDown,
                child: const Icon(Icons.arrow_downward),
              ),
              ElevatedButton(
                onPressed: _swipeRight,
                child: const Icon(Icons.arrow_forward),
              ),
              ElevatedButton(
                onPressed: _mergeTilesAndUpdateState,
                child: const Icon(Icons.merge),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _initBoard();
              });
            },
            child: const Text('Restart Game'),
          ),
        ],
      ),
    );
  }

  Color _getTileColor(int value) {
    switch (value) {
      case 2:
        return Colors.orangeAccent;
      case 4:
        return Colors.deepOrangeAccent;
      case 8:
        return Colors.redAccent;
      case 16:
        return Colors.pinkAccent;
      case 32:
        return Colors.purpleAccent;
      case 64:
        return Colors.deepPurpleAccent;
      case 128:
        return Colors.indigoAccent;
      case 256:
        return Colors.blueAccent;
      case 512:
        return Colors.lightBlueAccent;
      case 1024:
        return Colors.cyanAccent;
      case 2048:
        return Colors.tealAccent;
      default:
        return Colors.grey;
    }
  }
}
