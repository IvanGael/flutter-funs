
import 'dart:async';

import 'package:flutter/material.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/parcel1.jpg',
              width: double.infinity,
              height: 350,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              'Exciting Announcement!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Get ready for something amazing.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const CountdownTimer(),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Add functionality for the button, e.g., navigate to another screen
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, 
                backgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text('Learn More'),
            ),
          ],
        ),
      ),
    );
  }
}

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  // Replace the targetDate with the actual release date
  final DateTime targetDate = DateTime(2024, 3, 15);

  Duration _timeUntilTargetDate = const Duration();

  @override
  void initState() {
    super.initState();
    _updateTimeUntilTargetDate();
    // Update the countdown every second
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTimeUntilTargetDate();
    });
  }

  void _updateTimeUntilTargetDate() {
    final now = DateTime.now();
    if (targetDate.isAfter(now)) {
      setState(() {
        _timeUntilTargetDate = targetDate.difference(now);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Time left: ${_timeUntilTargetDate.inDays}d ${_timeUntilTargetDate.inHours.remainder(24)}h ${_timeUntilTargetDate.inMinutes.remainder(60)}m',
      style: const TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
    );
  }
}