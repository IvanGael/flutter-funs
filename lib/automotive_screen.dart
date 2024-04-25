import 'package:flutter/material.dart';

class AutomotiveScreen extends StatelessWidget {
  const AutomotiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Car Dashboard'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Speedometer(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ControlButton(icon: Icons.arrow_back, onPressed: () {}),
                  ControlButton(icon: Icons.arrow_forward, onPressed: () {}),
                  ControlButton(icon: Icons.pause, onPressed: () {}),
                ],
              ),
              const SizedBox(height: 20),
              const TemperatureControl(),
            ],
          ),
        ),
      );
  }
}


class Speedometer extends StatelessWidget {
  const Speedometer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      child: const Center(
        child: Text(
          '60 mph',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const ControlButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
      ),
      child: Icon(
        icon,
        size: 32,
        color: Colors.white,
      ),
    );
  }
}

class TemperatureControl extends StatefulWidget {
  const TemperatureControl({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TemperatureControlState createState() => _TemperatureControlState();
}

class _TemperatureControlState extends State<TemperatureControl> {
  double temperature = 22.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Temperature Control',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  temperature -= 1.0;
                });
              },
            ),
            Text(
              '$temperature °C',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  temperature += 1.0;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}