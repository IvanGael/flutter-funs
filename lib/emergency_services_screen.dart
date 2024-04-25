
import 'package:flutter/material.dart';

class EmergencyServicesScreen extends StatelessWidget {
  const EmergencyServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EmergencyCard(
            icon: Icons.phone,
            title: 'Call 911',
            description: 'Immediate assistance',
            color: Colors.red,
          ),
          SizedBox(height: 16.0),
          EmergencyCard(
            icon: Icons.local_hospital,
            title: 'Medical Services',
            description: 'Find nearby hospitals',
            color: Colors.blue,
          ),
          SizedBox(height: 16.0),
          EmergencyCard(
            icon: Icons.local_fire_department,
            title: 'Fire Services',
            description: 'Report fire emergencies',
            color: Colors.orange,
          ),
          SizedBox(height: 16.0),
          EmergencyCard(
            icon: Icons.local_police,
            title: 'Police Assistance',
            description: 'Contact local police',
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

class EmergencyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const EmergencyCard({super.key, 
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40.0,
              color: Colors.white,
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}