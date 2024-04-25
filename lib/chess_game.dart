import 'package:flutter/material.dart';

class ChessGame extends StatefulWidget {
  const ChessGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChessGameState createState() => _ChessGameState();
}

class _ChessGameState extends State<ChessGame> {
  List<String> pieces = [
    '♖', '♘', '♗', '♕', '♔', '♗', '♘', '♖',
    '♙', '♙', '♙', '♙', '♙', '♙', '♙', '♙',
    '', '', '', '', '', '', '', '',
    '', '', '', '', '', '', '', '',
    '', '', '', '', '', '', '', '',
    '', '', '', '', '', '', '', '',
    '♟', '♟', '♟', '♟', '♟', '♟', '♟', '♟',
    '♜', '♞', '♝', '♛', '♚', '♝', '♞', '♜',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chess Game'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
              ),
              itemCount: 64,
              itemBuilder: (context, index) {
                return ChessSquare(index, pieces, pieces[index]);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ChessSquare extends StatefulWidget {
  final int index;
  final List<String> pieces;
  final String piece;

  const ChessSquare(this.index, this.pieces, this.piece, {Key? key})
      : super(key: key);

  @override
  State<ChessSquare> createState() => _ChessSquareState();
}

class _ChessSquareState extends State<ChessSquare> {
 

  @override
  Widget build(BuildContext context) {
    Color squareColor = (widget.index ~/ 8 + widget.index) % 2 == 0
        ? Colors.white
        : Colors.black;
    Color textColor = (widget.index ~/ 8 + widget.index) % 2 == 0
        ? Colors.black
        : Colors.white;

    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          color: squareColor,
          child: Center(
            child: Draggable<String>(
              data: widget.piece,
              feedback: Text(
                widget.piece,
                style: TextStyle(
                    fontSize: 24.0,
                    color: textColor,
                    decoration: TextDecoration.none),
              ),
              childWhenDragging: Container(),
              onDragCompleted: (){
                setState(() {
                  
                });
              },
              child: Text(
                widget.piece,
                style: TextStyle(
                    fontSize: 24.0,
                    color: textColor,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
        );
      },
      onWillAccept: (data) {
        return isValidMove(data!, widget.piece);
      },
      onAccept: (data) {
        setState(() {
          widget.pieces[widget.index] = data;
        });
      },
      onMove: (targetDetails){
        setState(() {
          widget.pieces[widget.index] = targetDetails.data;
        });
      },
    );
  }

  bool isValidMove(String pieceType, String targetPiece) {
    // Check if the move is valid based on the type of chess piece
    switch (pieceType) {
      case '♙':
        // Pawn: Only move forward one square, or two squares on the first move
        return targetPiece.isEmpty &&
            (widget.index == widget.index + 8 ||
                widget.index == widget.index + 16);
      case '♟':
        // Pawn: Only move forward one square, or two squares on the first move
        return targetPiece.isEmpty &&
            (widget.index == widget.index - 8 ||
                widget.index == widget.index - 16);
      case '♖':
      case '♜':
        // Rook: Move horizontally or vertically
        return isHorizontalMove() || isVerticalMove();
      case '♗':
      case '♝':
        // Bishop: Move diagonally
        return isDiagonalMove();
      default:
        // Allow any other piece to be dropped anywhere for now
        return true;
    }
  }

  bool isHorizontalMove() {
    return widget.index ~/ 8 == (widget.index + 1) ~/ 8 ||
        widget.index ~/ 8 == (widget.index - 1) ~/ 8;
  }

  bool isVerticalMove() {
    return widget.index % 8 == widget.index + 1 % 8 ||
        widget.index % 8 == widget.index - 1 % 8;
  }

  bool isDiagonalMove() {
    return (widget.index ~/ 8 + widget.index) % 2 == 0 &&
        (widget.index + 7 == widget.index + 8 ||
            widget.index - 7 == widget.index - 8 ||
            widget.index + 9 == widget.index + 8 ||
            widget.index - 9 == widget.index - 8);
  }
}
