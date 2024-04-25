
import 'package:flutter/material.dart';

class HomeAutomationScreen extends StatelessWidget {
  const HomeAutomationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Automation'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DeviceCard(
              deviceName: 'Living Room Lights',
              status: true,
              icon: Icons.lightbulb_outline,
            ),
            SizedBox(height: 16),
            DeviceCard(
              deviceName: 'Thermostat',
              status: 22,
              icon: Icons.thermostat,
            ),
            SizedBox(height: 16),
            DeviceCard(
              deviceName: 'Security Camera',
              status: 'Online',
              icon: Icons.videocam,
            ),
            // Add more DeviceCard widgets for additional devices
          ],
        ),
      ),
    );
  }
}

class DeviceCard extends StatelessWidget {
  final String deviceName;
  final dynamic status;
  final IconData icon;

  const DeviceCard({super.key, 
    required this.deviceName,
    required this.status,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  size: 40,
                  color: Colors.blue,
                ),
                Text(
                  deviceName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            buildStatusWidget(),
          ],
        ),
      ),
    );
  }

  Widget buildStatusWidget() {
    if (status is bool) {
      return Text(
        status ? 'On' : 'Off',
        style: TextStyle(
          fontSize: 16,
          color: status ? Colors.green : Colors.red,
        ),
      );
    } else {
      return Text(
        '$status',
        style: const TextStyle(
          fontSize: 16,
        ),
      );
    }
  }
}