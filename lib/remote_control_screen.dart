
import 'package:flutter/material.dart';

class RemoteControlScreen extends StatefulWidget {
  const RemoteControlScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RemoteControlScreenState createState() => _RemoteControlScreenState();
}

class _RemoteControlScreenState extends State<RemoteControlScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Remote Control'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RemoteButton(icon: Icons.power_settings_new, label: 'Power'),
                RemoteButton(icon: Icons.volume_up, label: 'Volume Up'),
                RemoteButton(icon: Icons.volume_down, label: 'Volume Down'),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RemoteButton(icon: Icons.arrow_upward, label: 'Up'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RemoteButton(icon: Icons.arrow_back, label: 'Left'),
                RemoteButton(icon: Icons.check, label: 'OK'),
                RemoteButton(icon: Icons.arrow_forward, label: 'Right'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RemoteButton(icon: Icons.arrow_downward, label: 'Down'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RemoteButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const RemoteButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // Implement button functionality
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
            ),
            child: Icon(icon, size: 30),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}