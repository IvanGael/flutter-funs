
import 'package:flutter/material.dart';

class FitnessScreen extends StatelessWidget {
  const FitnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Tracker'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Workout',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            WorkoutCard(
              exercise: 'Push-ups',
              sets: 3,
              reps: 15,
            ),
            WorkoutCard(
              exercise: 'Squats',
              sets: 3,
              reps: 12,
            ),
            SizedBox(height: 24.0),
            Text(
              'Weekly Goals',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            GoalCard(
              goal: 'Run 10 miles',
              progress: '5 miles completed',
            ),
            GoalCard(
              goal: 'Burn 500 calories',
              progress: '200 calories burned',
            ),
          ],
        ),
      ),
    );
  }
}

class WorkoutCard extends StatelessWidget {
  final String exercise;
  final int sets;
  final int reps;

  const WorkoutCard({super.key, 
    required this.exercise,
    required this.sets,
    required this.reps,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text('Sets: $sets | Reps: $reps'),
          ],
        ),
      ),
    );
  }
}

class GoalCard extends StatelessWidget {
  final String goal;
  final String progress;

  const GoalCard({super.key, 
    required this.goal,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              goal,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(progress),
          ],
        ),
      ),
    );
  }
}