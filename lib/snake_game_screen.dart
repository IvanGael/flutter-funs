import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

class SnakeGame extends StatefulWidget {
  const SnakeGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SnakeGameState createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  final int gridSize = 20;
  final List<int> snake = [45, 44, 43]; // Initial position of the snake
  int food = 0;
  Direction direction = Direction.right;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snake Game'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.primaryDelta! < 0) {
                  changeDirection(Direction.up);
                } else if (details.primaryDelta! > 0) {
                  changeDirection(Direction.down);
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.primaryDelta! > 0) {
                  changeDirection(Direction.right);
                } else if (details.primaryDelta! < 0) {
                  changeDirection(Direction.left);
                }
              },
              child: Container(
                color: Colors.black,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridSize,
                  ),
                  itemBuilder: (context, index) {
                    if (snake.contains(index)) {
                      return Center(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    } else if (index == food) {
                      return Center(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            border: Border.all(color: Colors.black),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Buttons to move the snake
              DirectionButton(
                icon: Icons.arrow_back,
                onPressed: () => changeDirection(Direction.left),
              ),
              DirectionButton(
                icon: Icons.arrow_upward,
                onPressed: () => changeDirection(Direction.up),
              ),
              DirectionButton(
                icon: Icons.arrow_downward,
                onPressed: () => changeDirection(Direction.down),
              ),
              DirectionButton(
                icon: Icons.arrow_forward,
                onPressed: () => changeDirection(Direction.right),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void changeDirection(Direction newDirection) {
    // Avoid opposite direction changes
    if (!(direction == Direction.left && newDirection == Direction.right) &&
        !(direction == Direction.right && newDirection == Direction.left) &&
        !(direction == Direction.up && newDirection == Direction.down) &&
        !(direction == Direction.down && newDirection == Direction.up)) {
      direction = newDirection;
    }
  }

  void updateGame() {
    // Update snake position based on the current direction
    int head = snake.first;

    switch (direction) {
      case Direction.up:
        head -= gridSize;
        break;
      case Direction.down:
        head += gridSize;
        break;
      case Direction.left:
        head -= 1;
        break;
      case Direction.right:
        head += 1;
        break;
    }

    // Check for collisions with the walls or itself
    if (head < 0 ||
        head >= gridSize * gridSize ||
        (direction == Direction.left && head % gridSize == gridSize - 1) ||
        (direction == Direction.right && head % gridSize == 0) ||
        snake.contains(head)) {
      // Game over logic
      // Reset the game or show a game over screen
    } else {
      // Check for eating food
      if (head == food) {
        // Generate new food position
        food = Random().nextInt(gridSize * gridSize);
      } else {
        // Remove the last segment of the snake
        snake.removeLast();
      }

      // Add the new head to the snake
      snake.insert(0, head);
    }
  }

  @override
  void initState() {
    super.initState();
    // Start the game loop
    startGameLoop();
  }

  void startGameLoop() {
    Duration speed = const Duration(milliseconds: 300);

    // Update the game state every 'speed' duration
    Timer.periodic(speed, (timer) {
      setState(() {
        updateGame();
      });
    });
  }
}

class DirectionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const DirectionButton({super.key, 
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
      iconSize: 40,
      color: Colors.blue,
    );
  }
}

enum Direction {
  up,
  down,
  left,
  right,
}
