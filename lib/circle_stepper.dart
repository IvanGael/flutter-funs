
import 'package:flutter/material.dart';
import 'package:flutter_explosive_like/circle_stepper_item.dart';

class CirclesStepper extends StatefulWidget {
  final List<CircleStepItem> steps;

  const CirclesStepper({super.key, required this.steps});

  @override
  // ignore: library_private_types_in_public_api
  _CirclesStepperState createState() => _CirclesStepperState();
}

class _CirclesStepperState extends State<CirclesStepper> {
  int currentStep = 0;

  void goToNextStep() {
    if (currentStep < widget.steps.length - 1) {
      setState(() {
        currentStep++;
      });
    }
  }

  void goToPreviousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          for (int i = 0; i < widget.steps.length; i++)
            _buildStep(widget.steps[i], i == currentStep, i == widget.steps.length - 1),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: goToPreviousStep,
                child: const Text('Previous'),
              ),
              ElevatedButton(
                onPressed: goToNextStep,
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep(CircleStepItem step, bool isActive, bool isLast) {
    return Row(
      children: [
        _buildCircle(isActive),
        if (!isLast) _buildLine(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
                if (isActive) step.content,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCircle(bool isActive) {
    return Container(
      width: 24.0,
      height: 24.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.blue : Colors.grey,
      ),
      child: Center(
        child: Text(
          (widget.steps.indexOf(widget.steps.firstWhere((step) => step.title == 'Step 1')) +
                  1)
              .toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildLine() {
    return Expanded(
      child: Container(
        height: 2.0,
        color: Colors.grey,
      ),
    );
  }
}

