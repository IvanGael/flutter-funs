import 'package:flutter/material.dart';
import 'dart:math';

class BallCollectorGame extends StatefulWidget {
  const BallCollectorGame({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GameScreenState createState() => _GameScreenState();
}


class _GameScreenState extends State<BallCollectorGame> {
  double robotX = 0.0;
  double robotY = 0.0;
  double ballX = 0.0;
  double ballY = 0.0;

  final int gridSize = 5;
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text("Score : "),
            Text("$score", style: const TextStyle(fontWeight: FontWeight.bold),)
          ],
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          // The robot will move based on drag gestures
          setState(() {
            robotX += details.delta.dx;
            robotY += details.delta.dy;
            checkCollision();
          });
        },
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridSize,
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            int row = index ~/ gridSize;
            int col = index % gridSize;

            // Adjust the positions based on the grid cell size
            double cellWidth = MediaQuery.of(context).size.width / gridSize;
            double cellHeight = MediaQuery.of(context).size.height / gridSize;

            if ((row * cellHeight <= robotY) &&
                (robotY < (row + 1) * cellHeight) &&
                (col * cellWidth <= robotX) &&
                (robotX < (col + 1) * cellWidth)) {
              return const Robot();
            } else if ((row * cellHeight <= ballY) &&
                (ballY < (row + 1) * cellHeight) &&
                (col * cellWidth <= ballX) &&
                (ballX < (col + 1) * cellWidth)) {
              return const Ball();
            } else {
              return const EmptyCell();
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        color: Colors.greenAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                moveRobotLeft();
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
            ),
            IconButton(
              onPressed: () {
                moveRobotUp();
              },
              icon: const Icon(Icons.arrow_upward, color: Colors.black),
            ),
            IconButton(
              onPressed: () {
                moveRobotDown();
              },
              icon: const Icon(Icons.arrow_downward, color: Colors.black),
            ),
            IconButton(
              onPressed: () {
                moveRobotRight();
              },
              icon: const Icon(Icons.arrow_forward, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  void checkCollision() {
    // Adjust the positions based on the grid cell size
    double cellWidth = MediaQuery.of(context).size.width / gridSize;
    double cellHeight = MediaQuery.of(context).size.height / gridSize;

    int robotCol = (robotX ~/ cellWidth).clamp(0, gridSize - 1);
    int robotRow = (robotY ~/ cellHeight).clamp(0, gridSize - 1);

    int ballCol = (ballX ~/ cellWidth).clamp(0, gridSize - 1);
    int ballRow = (ballY ~/ cellHeight).clamp(0, gridSize - 1);

    if (robotCol == ballCol && robotRow == ballRow) {
      // Robot and ball collided
      setState(() {
        score += 1;
        // Respawn ball at a new random location within the grid
        ballX = (Random().nextInt(gridSize) * cellWidth);
        ballY = (Random().nextInt(gridSize) * cellHeight);
      });
    } 
    // else {
    //   if(score > 0){
    //     setState(() {
    //       score -= 1;
    //     });
    //   }
    // }
  }

  void moveRobotLeft() {
    setState(() {
      if (robotX > 0) {
        robotX -= MediaQuery.of(context).size.width / gridSize;
      }
      checkCollision();
    });
  }

  void moveRobotUp() {
    setState(() {
      if (robotY > 0) {
        robotY -= MediaQuery.of(context).size.height / gridSize;
      }
      checkCollision();
    });
  }

  void moveRobotDown() {
    setState(() {
      if (robotY < MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / gridSize) {
        robotY += MediaQuery.of(context).size.height / gridSize;
      }
      checkCollision();
    });
  }

  void moveRobotRight() {
    setState(() {
      if (robotX < MediaQuery.of(context).size.width - MediaQuery.of(context).size.width / gridSize) {
        robotX += MediaQuery.of(context).size.width / gridSize;
      }
      checkCollision();
    });
  }
}



class Robot extends StatelessWidget {
  const Robot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      height: MediaQuery.of(context).size.height / 5,
      decoration: const BoxDecoration(
        // color: Colors.green,
        // border: Border.all(color: Colors.black),
      ),
      child: Image.asset(
        "assets/dino.png",
        fit: BoxFit.cover,
      ),
    );
  }
}

class Ball extends StatelessWidget {
  const Ball({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // width: MediaQuery.of(context).size.width / 5,
        // height: MediaQuery.of(context).size.height / 5,
        decoration: const BoxDecoration(
          // color: Colors.blue,
          // shape: BoxShape.circle,
        ),
        child: Image.asset(
          "assets/ball.png",
          width: 40,
          height: 40,
          // fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class EmptyCell extends StatelessWidget {
  const EmptyCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      height: MediaQuery.of(context).size.height / 5,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
    );
  }
}
