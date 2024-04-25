
import 'package:flutter/material.dart';

class ElevatorSimulatorScreen extends StatefulWidget {
  const ElevatorSimulatorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ElevatorSimulatorState createState() => _ElevatorSimulatorState();
}

class _ElevatorSimulatorState extends State<ElevatorSimulatorScreen> {
  int currentFloor = 0;
  int destinationFloor = 0;
  bool goingUp = true;
  int maxWeight = 500;
  int currentWeight = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white24),
        image: const DecorationImage(
          image: AssetImage("assets/floor.png"),
          fit: BoxFit.cover
        ),
      ),
      child: Stack(
        children: [
          // Building floors
          for (int i = 0; i < 13; i++)
            Positioned(
              top: (12 - i) * 50.0, 
              left: 20.0,
              child: ElevatedButton(
                onPressed: () {
                  if (i == currentFloor) return;

                  // Check weight limit
                  if (currentWeight + 70 > maxWeight) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Weight limit reached. Elevator cannot move.'),
                      ),
                    );
                    return;
                  }

                  setState(() {
                    destinationFloor = i;
                    goingUp = i > currentFloor;
                    currentWeight += 70;
                  });
                },
                child: Text('Floor ${i + 1}'),
              ),
            ),

          // Elevator
          Positioned(
            top: (12 - currentFloor) * 50.0,
            left: 100.0,
            child: const Elevator(),
          ),

          // Current Floor Indicator
          Positioned(
            top: 10.0,
            left: 300.0,
            child: CurrentFloorIndicator(currentFloor: currentFloor + 1),
          ),
        ],
      ),
    );
  }

  void runElevator() async {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));

      if (currentFloor == destinationFloor) {
        // Let the person exit the elevator
        setState(() {
          currentWeight -= 70;
        });

        continue;
      }

      setState(() {
        currentFloor += goingUp ? 1 : -1;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    runElevator();
  }
}

class Elevator extends StatelessWidget {
  const Elevator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      width: 80.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        border: Border.all(color: Colors.white),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10)
        ),
      ),
      child: Center(
        child: Image.asset(
          "assets/person.png"
        ),
      ),
    );
  }
}


class CurrentFloorIndicator extends StatelessWidget {
  final int currentFloor;

  const CurrentFloorIndicator({
    Key? key,
    required this.currentFloor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Colors.orange.shade800,
            Colors.amber.shade500,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.orangeAccent,
            blurRadius: 10.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Center(
        child: Text(
          '$currentFloor',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            decoration: TextDecoration.none
          ),
        ),
      ),
    );
  }
}
