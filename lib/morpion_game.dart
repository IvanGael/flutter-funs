import 'package:flutter/material.dart';


class MorpionGame extends StatefulWidget {
  const MorpionGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MorpionGameState createState() => _MorpionGameState();
}

class _MorpionGameState extends State<MorpionGame> {
 List<String> _board = List.generate(9, (index) => (index + 1).toString());
  bool _isPlayer1Turn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              _onCellTapped(index);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Center(
                child: Text(
                  _board[index],
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onCellTapped(int index) {
    if (_board[index] != 'X' && _board[index] != 'O') {
      setState(() {
        _board[index] = _isPlayer1Turn ? 'X' : 'O';
        _isPlayer1Turn = !_isPlayer1Turn;
      });
      _checkWinner();
    }
  }

  void _checkWinner() {
    final List<List<int>> winningConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (final condition in winningConditions) {
      if (_board[condition[0]] == _board[condition[1]] &&
          _board[condition[1]] == _board[condition[2]] &&
          _board[condition[0]] != '${condition[0] + 1}') {
        _showWinnerDialog(_board[condition[0]]);
        return;
      }
    }

  }

  void _showWinnerDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Winner'),
          content: Text('$winner wins!'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void _resetGame() {
    setState(() {
      // _board.fillRange(0, 9, '');
      _board = List.generate(9, (index) => (index + 1).toString());
      _isPlayer1Turn = true;
    });
  }
}
