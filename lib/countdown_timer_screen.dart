
import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimerScreen extends StatefulWidget {
  const CountdownTimerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CountdownTimerScreenState createState() => _CountdownTimerScreenState();
}

class _CountdownTimerScreenState extends State<CountdownTimerScreen> {
  int _timeLeft = 10; 
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer.cancel();
        // Implement logic for when the countdown reaches 0
        _showCompletionDialog();
      }
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Countdown Complete'),
          content: const Text('Your countdown has finished!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countdown Timer'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildCountdownDisplay(),
            const SizedBox(height: 24.0),
            _buildControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildCountdownDisplay() {
    return Text(
      _formatTime(_timeLeft),
      style: const TextStyle(
        fontSize: 48.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(_timer.isActive ? Icons.pause : Icons.play_arrow),
          iconSize: 36.0,
          onPressed: () {
            if (!_timer.isActive) {
              _startTimer();
            }
          },
        ),
        IconButton(
          icon: Icon(_timer.isActive ? Icons.pause : Icons.play_arrow),
          iconSize: 36.0,
          onPressed: () {
            _timer.cancel();
          },
        ),
        IconButton(
          icon: const Icon(Icons.replay),
          iconSize: 36.0,
          onPressed: () {
            setState(() {
              _timeLeft = 180; // Reset to initial countdown time
            });
            _startTimer();
          },
        ),
      ],
    );
  }
}