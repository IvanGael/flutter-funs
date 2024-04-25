import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  const CustomStepper({
    super.key,
    required this.currentStep,
    required this.steps,
  });

  Icon getIcon(int index) {
    if (index < currentStep) {
      return const Icon(Icons.check, color: Colors.white);
    } else {
      switch (index) {
        case 0:
          return const Icon(Icons.lock, color: Colors.white);
        case 1:
          return const Icon(Icons.amp_stories, color: Colors.white);
        case 2:
          return const Icon(Icons.summarize, color: Colors.white);
        default:
          return const Icon(Icons.check, color: Colors.white);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;

        return Column(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index <= currentStep ? Colors.pink : Colors.grey,
              ),
              child: getIcon(index),
            ),
            const SizedBox(height: 5),
            Text(
              step,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: index <= currentStep ? Colors.pink : Colors.grey,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
