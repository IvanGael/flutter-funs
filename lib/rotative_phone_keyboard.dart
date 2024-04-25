import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';


class RotativePhoneKeyboardScreen extends StatelessWidget {
  const RotativePhoneKeyboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: RotativePhoneKeyboard(),
        ),
      );
  }
}



class RotativePhoneKeyboard extends StatefulWidget {
  const RotativePhoneKeyboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<RotativePhoneKeyboard> {
  double rotation = 0.0; // Current rotation angle
  int selectedNumber = 1; // Selected number on the keyboard

  void rotatePlus() {
    setState(() {
      rotation += 10.0; // You can adjust the rotation increment as needed
      if (rotation > 360) rotation = 0; // Reset rotation after one full circle

      // Calculate selected number based on rotation
      selectedNumber = ((rotation / 360) * 20).round() % 20 + 1;
    });
  }

  void rotateMoins() {
    setState(() {
      rotation -= 10.0; // You can adjust the rotation decrement as needed
      if (rotation < 0) rotation = 360; // Reset rotation after one full circle

      // Calculate selected number based on rotation
      selectedNumber = ((rotation / 360) * 20).round() % 20 + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                rotatePlus();
              },
              icon: const Icon(Icons.add),
            ),
            // Rotative Gesture Detector
            GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  double newRotation = rotation + details.delta.dx;
                  if (newRotation < 0) newRotation = 0;
                  if (newRotation > 360) newRotation = 360;

                  // Calculate selected number based on rotation
                  rotation = newRotation;
                  selectedNumber = ((rotation / 360) * 20).round() % 20 + 1;
                });
              },
              child: Transform.rotate(
                angle: rotation * (3.14 / 180), // Convert degrees to radians
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Text(
                      '$selectedNumber',
                      style: const TextStyle(fontSize: 32.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                rotateMoins();
              },
              icon: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
