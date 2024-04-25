import 'package:flutter/material.dart';

class ChessGameScreen extends StatefulWidget {
  const ChessGameScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChessBoardState createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessGameScreen> {
  List<List<String>> chessboard = List.generate(8, (row) => List.filled(8, ''));

  @override
  Widget build(BuildContext context) {
    initializeBoard();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 400,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final clampedIndex = index.clamp(0, 63);
                final row = clampedIndex ~/ 8;
                final col = clampedIndex % 8;

                return ChessSquare(
                  position: Position(row, col),
                  piece: chessboard[row][col],
                  onMove: (from, to) {
                    movePiece(from, to);
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_upward),
                onPressed: () {
                  // Move logic for upward direction
                  // Example: Move a pawn forward
                  movePiece(Position(1, 0), Position(2, 0));
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_downward),
                onPressed: () {
                  // Move logic for downward direction
                  // Example: Move a pawn backward
                  movePiece(Position(6, 0), Position(5, 0));
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  // Move logic for left direction
                  // Example: Move a pawn left
                  movePiece(Position(0, 1), Position(0, 0));
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  // Move logic for right direction
                  // Example: Move a pawn right
                  movePiece(Position(0, 0), Position(0, 1));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void initializeBoard() {
    chessboard = [
      ['r', 'n', 'b', 'q', 'k', 'b', 'n', 'r'],
      ['p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['P', 'P', 'P', 'P', 'P', 'P', 'P', 'P'],
      ['R', 'N', 'B', 'Q', 'K', 'B', 'N', 'R'],
    ];
  }

  void movePiece(Position from, Position to) {
    setState(() {
      final piece = chessboard[from.row][from.col];

      if (isValidMove(piece, from, to)) {
        // Implement special rules
        handleSpecialRules(piece, from, to);

        // Update the chessboard after moving
        chessboard[to.row][to.col] = piece;
        chessboard[from.row][from.col] = '';
      }
    });
  }

  void handleSpecialRules(String piece, Position from, Position to) {
    // Implement special rules here
    if (piece.toLowerCase() == 'p') {
      // Pawn promotion
      if (to.row == 0 || to.row == 7) {
        chessboard[to.row][to.col] =
            'q'; // Promote pawn to queen (can be customized)
      }
      // En passant (add logic based on game state)
    } else if (piece.toLowerCase() == 'k') {
      // Castling (add logic based on game state)
    }
  }

  bool isValidMove(String piece, Position from, Position to) {
    // Implement piece-specific movement logic
    switch (piece.toLowerCase()) {
      case 'r':
        // Rook movement logic
        return from.row == to.row || from.col == to.col;
      case 'n':
        // Knight movement logic
        return ((from.row - to.row).abs() == 2 &&
                (from.col - to.col).abs() == 1) ||
            ((from.row - to.row).abs() == 1 && (from.col - to.col).abs() == 2);
      case 'b':
        // Bishop movement logic
        return (from.row - to.row).abs() == (from.col - to.col).abs();
      case 'q':
        // Queen movement logic (combination of rook and bishop)
        return (from.row == to.row || from.col == to.col) ||
            (from.row - to.row).abs() == (from.col - to.col).abs();
      case 'k':
        // King movement logic (basic for now, add castling logic later)
        return (from.row - to.row).abs() <= 1 && (from.col - to.col).abs() <= 1;
      case 'p':
        // Pawn movement logic (add en passant and pawn promotion logic later)
        return isValidPawnMove(piece, from, to);
      default:
        return false;
    }
  }

  bool isValidPawnMove(String piece, Position from, Position to) {
    // Basic pawn movement logic (can be extended for en passant and promotion)
    if (from.col == to.col) {
      if (piece == 'p' && from.row < to.row) {
        return (to.row - from.row) == 1; // Move one square forward
      } else if (piece == 'P' && from.row > to.row) {
        return (from.row - to.row) == 1; // Move one square forward
      }
    }
    // Add en passant and pawn promotion logic here
    return false;
  }
}

class ChessSquare extends StatelessWidget {
  final Position position;
  final String piece;
  final Function(Position, Position) onMove;

  const ChessSquare({
    Key? key,
    required this.position,
    required this.piece,
    required this.onMove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onMove(Position(0, 0), position);
      },
      child: Container(
        width: 50.0,
        height: 50.0,
        color: (position.row + position.col) % 2 == 1
            ? Colors.brown
            : Colors.white,
        child: Center(
          child: Text(
            piece,
            style: const TextStyle(
                fontSize: 20.0,
                decoration: TextDecoration.none,
                color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class Position {
  final int row;
  final int col;

  Position(this.row, this.col);
}
