
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_explosive_like/bloc/fleet_bloc.dart';

class FleetTrackingScreen extends StatefulWidget {
  const FleetTrackingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FleetTrackingScreenState createState() => _FleetTrackingScreenState();
}

class _FleetTrackingScreenState extends State<FleetTrackingScreen> {
  Map<String, dynamic> vehicleData = {};

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the widget initializes
  }

  void fetchData() {
    // Simulate fetching data from the backend or GPS tracker API
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        vehicleData = {
          'gps': 'Latitude: 37.7749, Longitude: -122.4194',
          'accidentDetection': false,
          'speed': '65 km/h',
          'antiTheftAlarm': false,
          'ignitionDetection': true,
        };
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fleet Tracking Tool'),
      ),
      body: Center(
        child: vehicleData.isEmpty
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard('Real-time GPS', vehicleData['gps']),
                  _buildInfoCard('Accident Detection', vehicleData['accidentDetection']),
                  _buildInfoCard('Speed', vehicleData['speed']),
                  _buildInfoCard('Anti-theft Alarm', vehicleData['antiTheftAlarm']),
                  _buildInfoCard('Ignition Detection', vehicleData['ignitionDetection']),
                ],
              ),
      ),
    );
  }

  Widget _buildInfoCard(String title, dynamic value) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              value.toString(),
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}