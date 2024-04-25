import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter/material.dart';

class CareerStep {
  final String title;
  final String description;
  final String date;

  CareerStep({required this.title, required this.description, required this.date});
}


class TimelineCareer extends StatelessWidget {
  final List<CareerStep> careerSteps = [
    CareerStep(title: 'Étape 1', description: 'Description de l\'étape 1', date: '2022-01-01'),
    CareerStep(title: 'Étape 2', description: 'Description de l\'étape 2', date: '2022-02-01'),
    CareerStep(title: 'Étape 3', description: 'Description de l\'étape 3', date: '2022-03-01'),
    // Ajoutez d'autres étapes de carrière ici
  ];

  TimelineCareer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Timeline Interactive'),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: careerSteps.length,
            itemBuilder: (context, index) {
              final step = careerSteps[index];
              final isEven = index.isEven;

              return TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.1,
                isFirst: index == 0,
                isLast: index == careerSteps.length - 1,
                indicatorStyle: IndicatorStyle(
                  width: 40,
                  height: 40,
                  indicator: _buildIcon(isEven),
                ),
                startChild: _buildTimelineCard(step),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineCard(CareerStep step) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              step.title,
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(step.description),
            const SizedBox(height: 8.0),
            Text('Date: ${step.date}'),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(bool isEven) {
    if (isEven) {
      return const Icon(Icons.pause);
    } else {
      return const Icon(Icons.menu);
    }
  }
}