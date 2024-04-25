import 'package:flutter/material.dart';

class GradientStepper extends StatefulWidget {
  const GradientStepper({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GradientStepperState createState() => _GradientStepperState();
}

class _GradientStepperState extends State<GradientStepper> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Stepper(
        currentStep: _currentStep,
        // type: StepperType.horizontal,
        onStepContinue: () {
          setState(() {
            if (_currentStep < 2) {
              _currentStep += 1;
            }
          });
        },
        onStepCancel: () {
          setState(() {
            if (_currentStep > 0) {
              _currentStep -= 1;
            }
          });
        },
        steps: [
          _buildStep(
            title: 'Step 1',
            content: const Text('This is the content of Step 1'),
            beginColor: Colors.blue,
            endColor: Colors.green,
          ),
          _buildStep(
            title: 'Step 2',
            content: const Text('This is the content of Step 2'),
            beginColor: Colors.blue,
            endColor: Colors.green,
          ),
          _buildStep(
            title: 'Step 3',
            content: const Text('This is the content of Step 3'),
            beginColor: Colors.blue,
            endColor: Colors.green,
          ),
        ],
      ),
    );
  }

  Step _buildStep({
    required String title,
    required Widget content,
    required Color beginColor,
    required Color endColor,
  }) {
    return Step(
      title: Text(title),
      content: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [beginColor, endColor],
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: content,
        ),
      ),
    );
  }
}