
import 'package:flutter/material.dart';

class PhysicsGame extends StatefulWidget {
  const PhysicsGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PhysicsGameState createState() => _PhysicsGameState();
}

class _PhysicsGameState extends State<PhysicsGame> {
  double ballX = 50;
  double ballY = 50;
  double basketX = 250;
  double basketY = 500;
  double objectX = 150;
  double objectY = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Physics Game'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: ballY,
            left: ballX,
            child: Draggable(
              feedback: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.withOpacity(0.5),
                ),
              ),
              onDragEnd: (details) {
                setState(() {
                  if (isInsideBasket()) {
                    // Ball is in the basket, you can handle success here
                    // For simplicity, let's reset the ball's position
                    ballX = 50;
                    ballY = 50;
                  } else {
                    // Ball is not in the basket, reset its position
                    ballX = 50;
                    ballY = 50;
                  }
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Positioned(
            top: basketY,
            left: basketX,
            child: Container(
              width: 100,
              height: 20,
              color: Colors.green,
            ),
          ),
          Positioned(
            top: objectY,
            left: objectX,
            child: Draggable(
              feedback: Container(
                width: 100,
                height: 100,
                color: Colors.red.withOpacity(0.5),
              ),
              onDragEnd: (details) {
                setState(() {
                  // You can add additional logic here for object interactions
                });
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isInsideBasket() {
    // Check if the ball is inside the basket
    return (ballX >= basketX && ballX <= basketX + 100) &&
        (ballY >= basketY && ballY <= basketY + 20);
  }
}