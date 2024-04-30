import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SpiderAnimationScreen extends StatefulWidget {
  const SpiderAnimationScreen({super.key});

  @override
  _SpiderAnimationScreenState createState() => _SpiderAnimationScreenState();
}

class _SpiderAnimationScreenState extends State<SpiderAnimationScreen> {
  int gridRows = 8;
  int gridColumns = 6;
  double cellWidth = 200.0;
  double cellHeight = 200.0;
  Offset spiderPosition = const Offset(0, 0); // Initial position of the spider

  @override
  void initState() {
    super.initState();
    // Start the timer to move the spider randomly every 5 seconds
    Timer.periodic(Duration(seconds: 1), (timer) {
      moveSpiderRandomly();
    });
  }

  void moveSpiderRandomly() {
    // Generate random coordinates for the spider
    Random random = Random();
    int randomX = random.nextInt(gridColumns);
    int randomY = random.nextInt(gridRows);

    // Calculate the position of the spider based on the random coordinates
    double spiderX = randomX * cellWidth;
    double spiderY = randomY * cellHeight;

    // Update the spider position
    setState(() {
      spiderPosition = Offset(spiderX, spiderY);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: GestureDetector(
        onTapDown: (TapDownDetails details) {
          // Calculate the tapped cell position
          double tappedX = details.localPosition.dx;
          double tappedY = details.localPosition.dy;
          int cellX = (tappedX / cellWidth).floor();
          int cellY = (tappedY / cellHeight).floor();

          // Calculate the position of the spider based on the tapped cell
          double spiderX = cellX * cellWidth;
          double spiderY = cellY * cellHeight;

          // Update the spider position
          setState(() {
            spiderPosition = Offset(spiderX, spiderY);
          });
        },
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridColumns,
          ),
          itemCount: gridRows * gridColumns,
          itemBuilder: (context, index) {
            int cellX = index % gridColumns;
            int cellY = index ~/ gridColumns;

            return SizedBox(
              width: cellWidth,
              height: cellHeight,
              child: Stack(
                children: [
                  // Spider animation
                  if (spiderPosition.dx == cellX * cellWidth &&
                      spiderPosition.dy == cellY * cellHeight)
                    Center(
                      child: Lottie.asset(
                        'assets/spider.json',
                        width: cellWidth,
                        height: cellHeight,
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
